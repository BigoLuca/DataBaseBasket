from flask import *
import sqlite3

DATABASE = 'db.db'
app = Flask(__name__)

def string_is_int(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

def get_branches(cursor):
    return cursor.execute('select id, nome from sede').fetchall()

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect('db.db')
    return db    

def get_cols(db_cursor, table):
    cols = db_cursor.execute(f'pragma table_info({table})').fetchall()
    cols = [ c[1] for c in cols ]
    return cols

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

@app.route("/")
def home():
    return render_template('home.html')

@app.route("/view-table/<table>")
def get_table(table):
    table = str(table)
    db_cursor = get_db().cursor()
    cols = get_cols(db_cursor, table)
    res = db_cursor.execute(f'select * from {table}').fetchall()
    return render_template('view-table.html', page_title = table, table = table, cols = cols, rows = res)

@app.route("/edit", methods=['GET', 'POST'])
def edit():
    table = str(request.args['table'])
    record_id = str(request.args['id'])
    if table is None or record_id is None:
        return Response(status=404)

    db_conn = get_db()
    db_cursor = db_conn.cursor()
    cols = get_cols(db_cursor, table)

    if request.method == 'GET':
        record = db_cursor.execute(f'select * from {table} where id = {record_id}').fetchone()
        return render_template('edit-record.html', zip=zip(cols[1:], record[1:]), table=table, cols=cols, record=record)
    if request.method == 'POST':
        for col, val in request.form.lists():
            print(col, val)
            print(f"update { table } set { col } = '{ val[0] }' where id = { record_id };")
            db_cursor.execute(f"update { table } set { col } = '{ val[0] }' where id = { record_id };")
        db_conn.commit()
        return redirect('/', 200)

@app.route('/players')
def players_list():
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    SEDE = None
    QUERY = f'select * from giocatore'
    PAGE_TITLE = 'Giocatori'
    BRANCHES = db_cursor.execute('select id, nome from sede').fetchall()
    # print(BRANCHES)

    if 'sede' in request.args:
        SEDE = str(request.args['sede'])
        if string_is_int(SEDE):
            QUERY = f'select * from giocatore where idSede = { SEDE }'
            nome_sede = db_cursor.execute(f'select nome from sede where id = { SEDE }').fetchone()[0]
            PAGE_TITLE = f'Giocatori - { nome_sede }'

    cols = get_cols(db_cursor, 'giocatore')
    players = db_cursor.execute(QUERY).fetchall()
    return render_template('view-table.html', \
        page_title = PAGE_TITLE, \
        cols = cols, \
        rows = players, \
        show_branch_selector = True, \
        branches = BRANCHES)

@app.route('/add-player', methods=['GET', 'POST'])
def add_player():
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    if request.method == 'GET':
        BRANCHES = get_branches(db_cursor)
        return render_template('add-player.html', branches=BRANCHES)

    REQUIRED_FIELDS = ['nome', 'cognome', 'cf', 'data-nascita', 'numero-maglia', 'telefono', 'email', 'sede']
    for f in REQUIRED_FIELDS:
        if f not in request.form:
            print(f'/add-player: Incomplete data submitted, { f } is missing')
            return Response(status=422)

    form = request.form
    query = f"insert into giocatore (nMaglia, CF, nome, cognome, 'data_nascita', telefono, email, idSede) values ({ form['numero-maglia'] }, '{ form['cf'] }', '{ form['nome'] }', '{ form['cognome'] }', date('{ form['data-nascita'] }'), { form['telefono'] }, '{ form['email']}', { form['sede'] })"
    res = db_cursor.execute(query)
    db_connection.commit()
    return redirect('/players', 200)

@app.route('/record-fee-payment', methods=['GET', 'POST'])
def record_fee_payment():
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    if request.method == 'GET':
        giocatori = db_cursor.execute('select id, nome, cognome, cf from giocatore').fetchall()
        return render_template('record-fee-payment.html', giocatori=giocatori)

    if request.method == 'POST':
        REQUIRED_FIELDS = ['giocatore', 'importo', 'data']
        for f in REQUIRED_FIELDS:
            if f not in request.form:
                print('Incomplete data in request')
                return Respons(status=422)

        id_giocatore = request.form['giocatore']
        importo = request.form['importo']
        data = request.form['data']
        db_cursor.execute(f'insert into quota (id_giocatore, importo, data) values ({ id_giocatore }, { importo }, { data })')
        # TODO registra movimento
        db_connection.commit()
        return Response(status=200)

@app.route('/coaches')
def coaches():    
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    SEDE = None
    QUERY = f'select * from allenatore'
    PAGE_TITLE = 'Allenatori'
    BRANCHES = db_cursor.execute('select id, nome from sede').fetchall()

    if 'sede' in request.args:
        SEDE = str(request.args['sede'])
        if string_is_int(SEDE):
            QUERY = f'select * from allenatore where idSede = { SEDE }'
            nome_sede = db_cursor.execute(f'select nome from sede where id = { SEDE }').fetchone()[0]
            PAGE_TITLE = f'Giocatori - { nome_sede }'

    cols = get_cols(db_cursor, 'allenatore')
    records = db_cursor.execute(QUERY).fetchall()

    return render_template('view-table.html', \
        page_title='allenatori',
        table='allenatore',
        cols=cols, \
        rows=records, \
        show_branch_selector=True, \
        branches=BRANCHES)

@app.route('/add-coach', methods=['GET', 'POST'])
def add_coach():
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    if request.method == 'GET':
        BRANCHES = get_branches(db_cursor)
        return render_template('add-coach.html', branches=BRANCHES)

    REQUIRED_FIELDS = ['nome', 'cognome', 'cf', 'data-nascita', 'telefono', 'email', 'sede']
    for f in REQUIRED_FIELDS:
        if f not in request.form:
            print(f'/add-coach: Incomplete data submitted, { f } is missing')
            return Response(status=422)

    form = request.form
    query = f"insert into allenatore (CF, nome, cognome, 'data_nascita', telefono, email, idSede) values ('{ form['cf'] }', '{ form['nome'] }', '{ form['cognome'] }', date('{ form['data-nascita'] }'), { form['telefono'] }, '{ form['email']}', { form['sede'] })"
    res = db_cursor.execute(query)
    db_connection.commit()
    return redirect('/add-coach.html', 200)

@app.route('/teams')
def teams():
    db_connection = get_db()
    db_cursor = db_connection.cursor()
   
    return render_template('teams.html')

@app.route('/create-team', methods=['GET', 'POST'])
def create_team():
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    if request.method == 'GET':
        BRANCHES = get_branches(db_cursor)
        giocatori = db_cursor.execute('select id, nome, cognome, cf from giocatore').fetchall()
        return render_template('create-team.html', \
            branches=BRANCHES, \
            giocatori=giocatori)

    if request.method == 'POST':
        REQUIRED_FIELDS = ['nome', 'annata', 'giocatore', 'allenatore', 'sede']
        for f in REQUIRED_FIELDS:
            if f not in request.form:
                print(f'/create-team: Incomplete data submitted, { f } is missing')
                return Response(status=422)

        print(request.form)
        nome_squadra = request.form['nome']
        annata_squadra = request.form['annata']
        id_allenatore = request.form['allenatore']
        id_sede = request.form['sede']

        db_cursor.execute(f"insert into squadra ('nome', 'annata') values ('{ nome_squadra }', '{ annata_squadra }')")
        id_squadra = db_cursor.execute(f"select id from squadra where nome = '{ nome_squadra }'").fetchone()[0] 
        db_cursor.execute(f"insert into gestisce ('idAllenatore', 'idSquadra') values ('{id_allenatore}', '{id_squadra}')")

        for id_giocatore in request.form.getlist('giocatore'):
            if id_giocatore == '':
                continue
            db_cursor.execute(f"insert into appartiene ('idSquadra', 'idGiocatore') values ('{ id_squadra }', '{ id_giocatore }')")

        db_connection.commit()
        return redirect('/teams', 200)

@app.route('/product-warehouse')
def product_warehouse():    
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    cols = get_cols(db_cursor, 'materiale')
    records = db_cursor.execute(f"select * from materiale").fetchall()
    return render_template('view-table.html', \
        page_title='magazzino',
        table='materiale',
        cols=cols, \
        rows=records, \
        )

@app.route('/record-sale', methods=['GET', 'POST'])
def record_sale():
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    if request.method == 'GET':
        cols = get_cols(db_cursor, 'materiale')
        records = db_cursor.execute(f"select * from materiale").fetchall()
        BRANCHES = get_branches(db_cursor)

        return render_template('record-sale.html', \
            page_title='Registra vendita',
            table='materiale',
            cols=cols, \
            rows=records, \
            branches=BRANCHES
            ) 

    if request.method == 'POST':
        sede = request.form['sede']
        for prodotto, quantita in request.form:
            if not string_is_int(prodotto):
                continue;
            id_prodotto = int(prodotto)
            id_quantita = int(quantita)


        return Response(status=200)




