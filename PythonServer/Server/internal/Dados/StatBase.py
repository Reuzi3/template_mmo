import sqlite3
from enum import Enum



# Enumeração para os tipos de classe
class CharacterClass(Enum):
    SPRING = "Spring"
    SUMMER = "Summer"
    FALL = "Fall"
    WINTER = "Winter"


# Enumeração para os tipos de raça
class CharacterRace(Enum):
    HUMAN = "Human"
    ELF = "Elf"
    DWARF = "Dwarf"
    ORC = "Orc"


race_stats_data = {}



class StatsDatabase:
    
    def __init__(self, db_name="Base_stats.db"):
        self.db_name = db_name
        self.conn = sqlite3.connect(db_name)
        self.create_table()

    def create_table(self):
        create_table_query = '''
        CREATE TABLE IF NOT EXISTS player_stats (
            race TEXT,
            class TEXT,
            hp REAL,
            sp REAL,
            att REAL,
            mag REAL,
            skl REAL,
            spd REAL,
            lck REAL,
            def REAL,
            res REAL,
            countdown INTEGER
        );
        '''
        cursor = self.conn.cursor()
        cursor.execute(create_table_query)
        self.conn.commit()

    def insert_player_stats(self, player_data):
        insert_query = '''
        INSERT INTO player_stats (race, class hp, sp, att, mag, skl, spd, lck, def, res, countdown)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        '''
        cursor = self.conn.cursor()
        cursor.execute(insert_query, player_data)
        self.conn.commit()

    def get_player_stats(self, race):
        select_query = '''
        SELECT * FROM player_stats WHERE race = ?;
        '''
        cursor = self.conn.cursor()
        cursor.execute(select_query, (race,))
        player_stats = cursor.fetchone()
        return player_stats

    def get_all_races(self):
        select_query = '''
        SELECT DISTINCT race FROM player_stats;
        '''
        cursor = self.conn.cursor()
        cursor.execute(select_query)
        races = cursor.fetchall()
        return [race[0] for race in races]
    
    def close(self):
        self.conn.close()


