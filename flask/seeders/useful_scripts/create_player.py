import random
import string

def quote(s):
	s = s.replace("'", '')
	s = s.replace(" ", '')
	return f"'{s}'"

def create_cf():
	cf = ''
	for i in range(6):
		cf += random.choice(string.ascii_uppercase)
	for i in range(2):
		cf += random.choice(string.digits)
	cf += random.choice(string.ascii_uppercase)
	for i in range(2):
		cf += random.choice(string.digits)
	cf += random.choice(string.ascii_uppercase)
	for i in range(3):
		cf += random.choice(string.digits)
	cf += random.choice(string.ascii_uppercase)
	return cf

def get_nome():
	f = open('nomi_italiani.txt')
	r = random.randint(1, 9117)
	nome = '	'
	for i in range(r):
		nome = f.readline().strip()
	return nome

def get_cognome():
	f = open('cognomi.txt')
	r = random.randint(1, 801)
	print
	cognome = ''
	for i in range(r):
		cognome = f.readline().strip()
	return cognome

def create_player():
	nMaglia = str(random.randint(0, 10000))
	cf = quote(create_cf())
	nome = quote(get_nome()).lower()
	cognome = quote(get_cognome()).lower()

	month = random.randint(1, 12)
	day = random.randint(1, 31)
	if month == 2 and day > 28:
		day = random.randint(1, 28)
	if month in [4, 6, 9, 11] and day == 31:
		day = random.randint(1, 30)
	month = str(month) if month >= 10 else '0' + str(month)
	day = str(day) if day >= 10 else '0' + str(day)
	data_nascita = f"date('{random.randint(1900, 2020)}-{month}-{day}')"

	telefono = str(random.randint(1000000, 10000000))
	email = quote(f'{nome[1:-1]}@{cognome[1:-1]}.com')
	return (nMaglia, cf, nome, cognome, data_nascita, telefono, email)

def insert_player():
	p = create_player()
	i = f"insert into giocatore (nMaglia, CF, nome, cognome, 'data_nascita', telefono, email) values ({ ', '.join(p) })"
	return i

def create_allenatore():	
	cf = quote(create_cf())
	nome = quote(get_nome()).lower()
	cognome = quote(get_cognome()).lower()

	month = random.randint(1, 12)
	day = random.randint(1, 31)
	if month == 2 and day > 28:
		day = random.randint(1, 28)
	if month in [4, 6, 9, 11] and day == 31:
		day = random.randint(1, 30)
	month = str(month) if month >= 10 else '0' + str(month)
	day = str(day) if day >= 10 else '0' + str(day)
	data_nascita = f"date('{random.randint(1900, 2020)}-{month}-{day}')"

	telefono = str(random.randint(1000000, 10000000))
	email = quote(f'{nome[1:-1]}@{cognome[1:-1]}.com')
	return (cf, nome, cognome, data_nascita, telefono, email)

def insert_allenatore():
	p = create_allenatore()
	i = f"insert into giocatore (CF, nome, cognome, data, telefono, email) values ({ ', '.join(p) })"
	return i








