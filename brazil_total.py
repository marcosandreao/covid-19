import csv
import io

import requests

from firebase_services import VaccinationService


def get_data():
    url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-total.csv'
    r = requests.get(url)
    buff = io.StringIO(r.text)
    return csv.reader(buff)


def run():
    db = VaccinationService.instance().db
    data = get_data()
    header = next(data)
    col_total = db.collection(u'brazil_total')
    for row in data:
        key = row[1]
        doc = col_total.document(key)
        doc_data = {}
        for index, h in enumerate(header[2:], start=2):
            doc_data[h] = row[index]
        doc.set(doc_data)
