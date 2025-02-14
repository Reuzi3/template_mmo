from fastapi import APIRouter
from pydantic import BaseModel
import random
import string




#Classificar a mensagem recebida pelo client
class messageReg(BaseModel):
    username:str
    password:str
    email:str
    gender:bool
    race:str
    classe:str

class messageLog(BaseModel):
    username:str
    password:str


#Gerador de Tolens SUper HiperINCRIVEL // Temporario
def generate_string(length):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for _ in range(length))





# P-R-C
class PeerRequestConnection:
	
	def __init__( self, db):
		self.router = APIRouter()
		self.db=db
		self.setup()

	def setup(self):
        #Rota de registro
		@self.router.post("/register")
		async def register(data:messageReg):
			#Se existir um usuario com o mesmo nome ele nega
			if self.db.check_username_exists(data.username):
				return {"message": "Username already registered"}
			
            #registrar
			self.db.register_client(data.username,data.password,data.email,data.gender,data.race,data.classe)

			return {"message": "Registration successful"}
			
			


        #Rota de login
		@self.router.post("/login")
		async def login(data:messageLog):
			if self.db.get_online_state(data.username):
				return {"message": "The user is already logged in."}
      
			if not(self.db.check_username_exists(data.username)):
				
				return {"message": "User does not exist"}

			if self.db.authenticate_client(data.username,data.password):
				self.db.set_online_state(data.username, True)
				return {"message": "Login successful","token":generate_string(5)+data.username+generate_string(5)}

			else:
				return {"message": "Incorrect password"}
