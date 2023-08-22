import random
from datetime import datetime
from faker import Faker
from pywinauto.application import Application


fake = Faker()

barcode = fake.ean(length=13)
string_date = fake.date_between_dates(date_start=datetime(2022,1,1), date_end=datetime(2023,12,31))
number_of_items = random.randint(5,6)

book_titles = [fake.paragraph(nb_sentences=1, variable_nb_sentences=False).upper().replace(".","") + " "*100 for _ in range(number_of_items)]
prices = [random.randint(10,30) + random.choice([0.0,0.95]) for _ in range(number_of_items)]

base_text = f'''
MAURI'S BOOK SHOP
-----------------

{barcode}

DATE: {string_date}

ITEMS:
'''

for (t, p) in zip(book_titles, prices):
	base_text += f"\n * {t[:40]}          ${p:.2f}"

base_text += "\n   " + "-" * 56
tilt = 45 if sum(prices) < 100.00 else 44
base_text += "\n   TOTAL" + " " * tilt + f"${sum(prices):.2f}"

app = Application(backend="uia").start("notepad.exe")
lines = base_text.split("\n")
for line in lines:
	for c in line:
		if c!=" ":
			app.UntitledNotepad.type_keys(c)
		else:
			app.UntitledNotepad.type_keys("{SPACE}")
	app.UntitledNotepad.type_keys("{ENTER}")

app.UntitledNotepad.menu_select("File->SaveAs")
app.Dialog.edit1.set_text(f"{barcode}.txt")
app.Dialog.Save.click()
