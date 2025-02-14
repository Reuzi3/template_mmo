from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from fastapi.responses import FileResponse
import os
from internal.Dados.StatBase import StatsDatabase

current_directory = os.path.dirname(os.path.abspath(__file__))
html_file_path = current_directory[:-7]+"internal/Website/template/"
css_file_path = current_directory[:-7]+"internal/Website/static/"

# W-R-C
class WebRequestConnection:
    def __init__( self, db, manager):
        self.router = APIRouter()
        self.db=db
        self.manager=manager
        self.setup()
        
        
    def setup(self):
        @self.router.get("/", response_class=HTMLResponse)
        async def main():
            with open(html_file_path+"viewplayers.html") as f:
                html = f.read()
            return HTMLResponse(content=html)
            
        
        @self.router.get("/main", response_class=HTMLResponse)
        async def read_root():
            with open(html_file_path+"index.html") as f:
                html = f.read()
            return HTMLResponse(content=html)
        
        
        @self.router.get("/static/{filename}", response_class=FileResponse)
        async def read_css(filename):
            return css_file_path+filename
        
        
        @self.router.get("/get_race/{type}", response_class=HTMLResponse)
        async def sendRaceStatehtml(type):
            with open(html_file_path+"race.html") as f:
                html = f.read()
            return HTMLResponse(content=html)
        
        
        @self.router.get("/get_state/{type}")
        async def sendRaceState(type):
            StateData = StatsDatabase()
            
            return {"raceState": StateData.get_player_stats(type)}
        
        
        @self.router.get("/get_player/{type}")
        async def get_player_var(type):
            var = vars(self.manager.OnlineClients[type].stat)
            new_var = {k: v for k, v in var.items() if isinstance(v, (float, str, int))}

            return new_var


        @self.router.get("/get_players")
        async def get_players():
            
            return {"players": list(self.manager.OnlineClients.keys())}

        
        @self.router.get("/get_races")
        def get_races():
            StateData = StatsDatabase()
            
            return {"raceList": StateData.get_all_races()}
        
      