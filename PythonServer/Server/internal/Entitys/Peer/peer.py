from fastapi import  WebSocket
from internal.Managers.Math_Manager import Vector2
from internal.Dados.banco import dbClients
import json
from internal.Entitys.entity import Entity
from internal.Dados.StatBase import StatsDatabase
from internal.Dados.banco import dbClients




class peer(Entity):
    def __init__(self,P_Manager, websocket: WebSocket, client_token:str):
        self.StateData=StatsDatabase()
        self.username = self.get_name(client_token)
        super().__init__(self.StateData.get_player_stats(dbClients.get_race(self.username)))

        self.position.x = 362
        self.position.y = 321
        self.P_Manager=P_Manager
        self.websocket = websocket
        self.client_token = client_token

    async def send_message(self, message: str):
        await self.websocket.send_bytes(message)

    async def run(self):
        try:
            while True:
                data = await self.websocket.receive()
                
                if data["type"] == "websocket.disconnect":
                    await self.disconnect()
                    break
                
                mensagem = json.loads(data["bytes"])
                if mensagem["type"] != "player_position":
                    print(mensagem)
                match mensagem["type"]:

                    case "player_position":
                        newPos = eval(mensagem["data"][0])
                        self.position.x = newPos[0]
                        self.position.y = newPos[1]

                    case "get_peer_stats":
                        var = vars(self.P_Manager.OnlineClients[mensagem["namePeer"]].stat)
                        new_var = {k: v for k, v in var.items() if isinstance(v, (float, str, int))}
                        msg = {"namePeer":mensagem["namePeer"],"type":"get_peer_stat","data":json.dumps(new_var)}
                        msg = json.dumps(msg)
                        await self.send_message(msg.encode())

                    case "pvp_request":
                        SendMessageForPeer(mensagem["adv"],mensagem)


                    case "pvp_request_reponse":
                        print(self.client_token)
                        if bool(mensagem["value"]):
                            await self.enterFight()

                    case "_close":
                        await self.disconnect()
                        break
                
                await self.P_Manager.broadcast(data["bytes"],self.client_token)
        except:
            await self.disconnect()
        dbClients.set_online_state(self.get_name(self.client_token), False)



    async def disconnect(self):
        dbClients.set_online_state(self.get_name(self.client_token), False)
        msg = {"id":self.client_token,"type":"player_disconnected"}
        msg = json.dumps(msg)
        await self.P_Manager.broadcast(msg.encode(),self.client_token)
        del self.P_Manager.OnlineClients[self.client_token]
    
    async def enterFight(self):
        pass
        #await self.P_Manager.broadcast(msg.encode(),self.client_token)
        #del self.P_Manager.OnlineClients[self.client_token]



    def get_name(self,token):
        token = token[5:]
        token = token[:-5]
        return token