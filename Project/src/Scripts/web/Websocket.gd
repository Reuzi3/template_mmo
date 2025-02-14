extends Node

signal connected
signal data
signal disconnected
signal error


#WebSocketClient instance
var _client = WebSocketPeer.new()
@export var Online=false


#Procurar informações no servidor e verificar se você está online 
func _process(delta):
	_client.poll()
	var state = _client.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while _client.get_available_packet_count():
			_on_data()

	elif state == WebSocketPeer.STATE_CLOSED:
		_closed()


#Conectar o servidor
func connect_to_server() -> void:
	# Connects to the server or emits an error signal.
	# If connected, emits a connect signal.
	Actions.get_node("Bar/TitleBar").connect("exitGame",_send_close)
	var websocket_url ="ws://"+Webserver.url+"/ws/"+str(Webserver.token)
	var err = _client.connect_to_url(websocket_url)
	if err:
		print("Unable to connect")
		set_process(false)
		emit_signal("error")
	
	_connected()


#fechar o servidor
func _closed(was_clean = false):
	var code = _client.get_close_code()
	var reason = _client.get_close_reason()
	print("Closed, clean: ", was_clean)
	set_process(false)
	emit_signal("disconnected", was_clean)
	Actions.changeSceane(Actions.sceanes["Login"])


#Conectei ao server
func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	emit_signal("connected")


#Receber mensagem do server
func _on_data():
	var data: String = _client.get_packet().get_string_from_utf8()
	emit_signal("data", data)


#Enviar mensagem para o servidor
func _send_string(string: String) -> void:
	_client.put_packet(string.to_utf8_buffer())


func _send_close():
	var message = {'type': '_close', 'id': Webserver.token}
	print(message)
	_send_string(JSON.stringify(message))
