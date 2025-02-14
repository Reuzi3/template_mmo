import sqlite3




class DBClients:
    def __init__(self):
        self.conn = sqlite3.connect('clients.db')
        self.cursor = self.conn.cursor()
        self.create_clients_table()
        self.set_all_clients_offline()


    def create_clients_table(self):
        self.cursor.execute('''CREATE TABLE IF NOT EXISTS clients
                               (username TEXT PRIMARY KEY, password TEXT, email TEXT, gender TEXT, Online BOOL, race TEXT, classe TEXT)''')
        self.conn.commit()



    def register_client(self, username, password, email, gender, race, classe ):
        try:
            self.cursor.execute('INSERT INTO clients VALUES (?, ?, ?, ?,?, ?, ?)', (username, password,email, gender, False ,race, classe))
            self.conn.commit()
            return True
        except sqlite3.Error:
            return False

    def authenticate_client(self, username, password):
        self.cursor.execute('SELECT * FROM clients WHERE username = ? AND password = ?', (username, password))
        result = self.cursor.fetchone()
        return result is not None


    def check_username_exists(self, username):
        self.cursor.execute('SELECT * FROM clients WHERE username = ?', (username,))
        result = self.cursor.fetchone()
        return result is not None

    def get_all_usernames(self):
        self.cursor.execute('SELECT username FROM clients')
        result = self.cursor.fetchall()
        usernames = [row[0] for row in result]
        return usernames
    
    def set_online_state(self, username, is_online):
        try:
            self.cursor.execute('UPDATE clients SET Online = ? WHERE username = ?', (is_online, username))
            self.conn.commit()
            return True
        except sqlite3.Error:
            return False


    def get_race(self, username):
        self.cursor.execute('SELECT race FROM clients WHERE username = ?', (username,))
        result = self.cursor.fetchone()
        if result is not None:
            return result[0]
        else:
            return None

    def get_online_state(self, username):
        self.cursor.execute('SELECT Online FROM clients WHERE username = ?', (username,))
        result = self.cursor.fetchone()
        if result:
            return result[0]
        else:
            return None

    def set_all_clients_offline(self):
        try:
            self.cursor.execute('UPDATE clients SET Online = ?', (False,))
            self.conn.commit()
            return True
        except sqlite3.Error:
            return False




dbClients =DBClients()
