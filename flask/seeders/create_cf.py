import random
import string

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
