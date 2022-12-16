from flask import *
import sqlite3

DATABASE = 'db.db'
app = Flask(__name__)

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
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/view-table/<table>")
def get_table(table):
    table = str(table)
    db_cursor = get_db().cursor()
    cols = get_cols(db_cursor, table)
    res = db_cursor.execute(f'select * from {table}').fetchall()
    return render_template('view-table.html', table=table, cols=cols, rows=res)

@app.route("/edit")
def edit():
    table = str(request.args['table'])
    record_id = str(request.args['id'])
    if table is None or record_id is None:
        return Response(status=404)

    db_cursor = get_db().cursor()
    cols = get_cols(db_cursor, table)
    record = db_cursor.execute(f'select * from {table} where id = {record_id}').fetchone()
    return render_template('edit-record.html', table=table, cols=cols, record=record)