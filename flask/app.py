from flask import *
import sqlite3

DATABASE = 'db.db'
app = Flask(__name__)

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect('db.db')
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/view-table/giocatore")
def get_table_giocatore():
    db_cursor = get_db().cursor()
    cols = db_cursor.execute('pragma table_info(giocatore)').fetchall()
    cols = [ c[1] for c in cols ]
    res = db_cursor.execute('select * from giocatore').fetchall()
    return render_template('view-table.html', cols=cols, rows=res)
