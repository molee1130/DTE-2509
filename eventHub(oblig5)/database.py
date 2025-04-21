import mysql.connector
from dotenv import load_dotenv
import os 

load_dotenv()

class DataBase:
    def __init__(self):
        self.mysqlConnection = mysql.connector.connect(
            host="localhost",
            user="root",
            password=os.getenv("DB_PASSWORD"),
            database="mydb"
        )

    # __enter__ and __exit__ dunder method necessary to use "with"
    def __enter__(self):
        try:
            self.cursor = self.mysqlConnection.cursor()
            return self
        except mysql.connector.Error as error:
            print("Error while connecting to MySQL:", error)

    def __exit__(self, exc_type, exc_val, exc_tb): 
        self.mysqlConnection.commit()
        self.cursor.close() #closing the spcific cursor object opend in the "with" block
        self.mysqlConnection.close()
    
    def load_user(self, user_id): 
        # NB! user_id as tuple and using %s ac placeholder to avoid sql injection
        self.cursor.execute("Select * from bruker where idBruker = %s", (user_id, )) 
        return self.cursor.fetchone() 
    
    def create_user(self, s_name, l_name, email, password): 
        self.cursor.execute("insert into bruker (fornavn, etternavn, epost, passord) values (%s, %s, %s, %s)", (s_name, l_name, email, password))
        return 

    def load_user_by_email(self, email):
        self.cursor.execute("select * FROM bruker where epost = %s;", (email,))
        return self.cursor.fetchone()
    
    def load_all_events(self): 
        self.cursor.execute("select * from arrangement")
        return self.cursor.fetchall()

    def get_participants_by_event_id(self, event_id): 
        query = """SELECT b.fornavn, b.etternavn FROM bruker b JOIN påmelding p ON b.idBruker = p.idBruker 
                JOIN arrangement a on p.idArrangement = a.idArrangement WHERE a.idArrangement = %s""" # ; necessary? 
        self.cursor.execute(query, (event_id, ))
        return self.cursor.fetchall()
    
    def add_user_to_event(self, event_id, user_id):
        self.cursor.execute("insert into påmelding (idArrangement, idBruker) values (%s, %s)", (event_id, user_id))
        return
    
    def get_event_manager_name(self, event_id):
        query = ("SELECT b.fornavn, b.etternavn FROM bruker b JOIN arrangement a ON b.idBruker = a.arrangementAnsvarlig WHERE a.idArrangement = %s")
        self.cursor.execute(query, (event_id, ))
        return self.cursor.fetchone()
    
    def is_user_registered(self, user_id, event_id):
        query = "SELECT 1 FROM påmelding WHERE idBruker = %s AND idArrangement = %s"
        self.cursor.execute(query, (user_id, event_id))
        return self.cursor.fetchone() != None 
    
    def delete_user_from_event(self, event_id, user_id): 
        query = "DELETE FROM påmelding WHERE idArrangement = %s AND idBruker = %s"
        self.cursor.execute(query, (event_id, user_id))
        return

    def get_event_by_event_id(self, event_id):
        self.cursor.execute("SELECT * FROM arrangement WHERE idArrangement = %s", (event_id, ))
        return self.cursor.fetchone()

    def add_event(self, event_manager, title, time, place, description):
        query = """INSERT INTO arrangement (arrangementAnsvarlig, tittel, tidspunkt, sted, beskrivelse)
                VALUES (%s, %s, %s, %s, %s)"""
        self.cursor.execute(query, (event_manager, title, time, place, description))
        return

    def get_event_by_event_manager(self, event_manager):
        query = "SELECT * FROM arrangement WHERE arrangementAnsvarlig = %s"
        self.cursor.execute(query, (event_manager, ))
        return self.cursor.fetchall()
    
    def update_event(self, event_id, title, time, place, description):
        query = """UPDATE arrangement SET tittel = %s, tidspunkt = %s, sted = %s, beskrivelse = %s
                WHERE idArrangement = %s"""
        self.cursor.execute(query, (title, time, place, description, event_id))
        return 

    def delete_event_by_event_id(self, event_id):
        query = "DELETE FROM arrangement WHERE idArrangement = %s"
        self.cursor.execute(query, (event_id, ))
        return 
