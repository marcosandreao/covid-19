import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


class VaccinationService:
    _instance = None

    def __init__(self, app):
        self.app = app

    @staticmethod
    def instance():
        if VaccinationService._instance is None:
            cred = credentials.Certificate("vaccination-34fd3-firebase-adminsdk-ls9kq-f9f61b17c9.json")
            app = firebase_admin.initialize_app(cred)
            VaccinationService._instance = VaccinationService(app)
            print('if')
        else:
            print('else')
        return VaccinationService._instance

    @property
    def db(self):
        return firestore.client(self.app)
