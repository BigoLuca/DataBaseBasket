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
        return Response(status = 200)

@app.route('/players')
def players_list():
    db_connection = get_db()
    db_cursor = db_connection.cursor()

    SEDE = None
    QUERY = f'select * from giocatore'
    PAGE_TITLE = 'Giocatori'
    BRANCHES = db_cursor.execute('select id, nome from sede').fetchall()
    print(BRANCHES)

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

@app.route('/add-player')
def add_player():
    return render_template('add-player.html')

@app.route('/record-fee-payment')
def record_fee_payment():
    return render_template('record-fee-payment.html')

@app.route('/coaches')
def coaches():
    return render_template('coaches.html')

@app.route('/add-coach')
def add_coach():
    return render_template('add-coach.html')

@app.route('/teams')
def teams():
    return render_template('teams.html')

@app.route('/create-team')
def create_team():
    return render_template('create-team.html')

@app.route('/product-warehouse')
def product_warehouse():
    return render_template('product-warehouse.html')

@app.route('/record-sale')
def record_sale():
    return render_template('record-sale.html')
