extends CanvasLayer


@onready var GameChat = get_node("GameChat")
@onready var PlayerPerfil = get_node("PlayerPerfil")
@onready var PvpRequest = get_node("PvpRequest")
@export var web:Node2D



func send_chat_msg(text:String):
	var msg = {"type": "player_message", "message":text}
	web.manager.send_text(JSON.stringify(msg))


func set_new_msg(text:String):
	GameChat.PainelText.text+=(text)


func sendPvpRequest():
	$PvpRequest/Timer.start()


func SendResponsePvp(response:bool):
	var msg = Webserver.defaultMsg
	msg["type"] = "pvp_request_reponse"
	msg["value"] = response
	msg["id"]=Webserver.token
	msg["adv"]=Webserver.adv
	web.manager.send_text(JSON.stringify(msg))


func _on_timer_timeout():
	var msg = Webserver.defaultMsg
	msg["type"]="pvp_request"
	msg["id"]=Webserver.token
	msg["adv"]=Webserver.adv
	web.manager.send_text(JSON.stringify(msg))


