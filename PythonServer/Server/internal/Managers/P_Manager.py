from fastapi import  WebSocket
from internal.Entitys.Peer.peer import peer
import json


class P_manager:
    def __init__(self):
        self.OnlineClients = {}

    async def connect(self, websocket: WebSocket, client_token:str):
        await websocket.accept()
        client = peer(self,websocket, client_token)
        self.OnlineClients[client_token] = client
        await self.Playerlogin(client_token)
        await client.run()  # Inicie o loop do cliente


    async def Playerlogin(self,token):
    # Notifica outros clientes sobre a posição do jogador que fez login.
        for client in self.OnlineClients:
            if client != token:
                msg = {"type":"log_player_position","id":client,"data":[str(self.OnlineClients[client].position),"(0,0)","idle"]}
                data = json.dumps(msg)
                try:
                    await self.OnlineClients[token].websocket.send_bytes(data.encode())
                except:
                    continue

    
    async def broadcast(self,message,token):
        # Envia uma mensagem para todos os clientes, exceto o remetente.
        for client in self.OnlineClients:
            if client != token:
                try:
                    await self.OnlineClients[client].websocket.send_bytes(message)
                except:
                    continue


    async def SendMessageForPeer(self,client,message):
        await self.OnlineClients[client].websocket.send_bytes(message)