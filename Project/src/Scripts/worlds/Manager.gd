extends Node2D


#Nodes
@onready var player=Actions.Entitys["Player"]
@onready var peer=Actions.Entitys["Peer"]


@export var WebsocketClient:Node
@export var PlayerFolder:Node2D
#Var
var players = {}
var MyPlayer



var defaultMsg = Webserver.defaultMsg



func _ready():
	
	Actions.connect("GetUI",get_peer_stats)
	#Conectar as funções do websocket com as do world
	WebsocketClient.connect("data", _handle_network_data)
	
	#Conectar com o servidor (ip,porta)
	WebsocketClient.set_process(WebsocketClient.Online)
	if WebsocketClient.Online:
		WebsocketClient.connect_to_server()

	# Criar o player
	MyPlayer=player.instantiate()
	players[Webserver.token] = MyPlayer
	MyPlayer.position=Vector2(333,287)
	
	#CONNECTS
	MyPlayer.manager=self


	PlayerFolder.call_deferred("add_child",MyPlayer)
	
	
	

#adicionar boneco para outro client controlar
func newplayer(id):
	var new=peer.instantiate()
	#adicionar o player na dic players para ser facilmente controlado
	players[id] = new
	new.name=id
	new.scale=Vector2(0.5,0.5)
	players[id].position=Vector2(333,287)
	PlayerFolder.add_child(new)


#Receber dados do server
func _handle_network_data(data):
	#transformar o data byte em json 
	var json=JSON.new()
	json.parse(data)
	var message: Dictionary = json.get_data() 
	
	#print(message)
	msg_of_world(message)
	
	if message.type == "player_disconnected":
			#peer qualquer desconectou e vai ser deletado
			if str(message.id) in players:
				players[str(message.id)].queue_free()
				players.erase(str(message.id))


func msg_of_world(message):
	var json = JSON.new()
	match (message.type):
		"player_position":
			#Verificar se o peer existe, se não existe ele vai criar um boneco 
			if message.id not in players:
				# cria um novo nó de cena para o novo jogador
				newplayer(message.id)
				
			#sincroniza a posição e a  animação
			players[message.id].position = str_to_var("Vector2"+message.data[0])
			players[message.id].Flip.scale = str_to_var("Vector2"+message.data[1])
			players[message.id].changeAnim(message.data[2])

		"get_peer_stat":
			json.parse(message.data)
			var new_msg = json.get_data()
			MyPlayer.PlayerInfo.getUI(get_nome(message.namePeer), new_msg)
			Webserver.adv = message.namePeer
			#print(new_msg)
		
		"pvp_request":
			MyPlayer.ui.PvpRequest.visible=true
			Webserver.adv = message.adv
		
		
		"pvp_request_reponse":
			MyPlayer.ui.get_node("PvpRequest/Timer").stop()
			var msg = Webserver.defaultMsg
			msg["type"] = "pvp_request_reponse"
			msg["value"] = message.value
			msg["id"]=Webserver.id
			msg["adv"]=message.id
			send_text(JSON.stringify(msg))

		
		
		"player_message":
			MyPlayer.ui.set_new_msg(message.message)
		
		"log_player_position":
			#player fez login e recebeu as posição dos outros players que já estavam online
			logDataPeer(message)



func logDataPeer(message)->void:
	if message.id not in players:
		newplayer(message.id)
	print(str_to_var("Vector2"+message.data[0]))
	players[message.id].position=str_to_var("Vector2"+message.data[0])
	send_player_position(MyPlayer.position,Vector2(-1,1),"idle")



#Enviar player position para o server
func send_player_position(pos,rot,anim):
	var message = defaultMsg
	message['type'] = 'player_position'
	message["id"] =  Webserver.token
	message["data"] = [pos,rot,anim]
	send_text(JSON.stringify(message))



func get_peer_stats(nome:String)->void:
	var message = defaultMsg
	message['type'] =  'get_peer_stats'
	message["id"] =  Webserver.token
	message["namePeer"] = nome
	
	send_text(JSON.stringify(message))


#Enviar msg server
func send_text(text):
	#print(text)
	WebsocketClient._send_string(text)


#transformar token e um username
func get_nome(text:String)->String:
	text=text.left(-5)
	text=text.right(-5)
	return text

