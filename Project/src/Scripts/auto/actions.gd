extends Node

signal GetUI(nome)

const menuPause = preload("res://src/scenes/Ui/bar.tscn")



const sceanes = {
	"CreateAccount":"res://src/scenes/Ui/CreateAccount.tscn",
	"Login":"res://src/scenes/Ui/Login.tscn",
	"Map01":"res://src/scenes/maps/MapManager.tscn"
}

const Entitys = {
	"Player":preload("res://src/scenes/Entitys/Player&Peer/Heroi.tscn"),
	"Peer":preload("res://src/scenes/Entitys/Player&Peer/Peer/peer.tscn")
}



var http:HTTPRequest = HTTPRequest.new()

var mouse_onUI:bool=false

func _ready():
	add_child(http)
	add_child(menuPause.instantiate())
	




func changeSceane(type:String)->void:
	get_tree().change_scene_to_file(type)
	await get_tree().create_timer(1).timeout
	
	


func send_http_msg(message,url:String):
	var body_string = JSON.stringify(message)
	http.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, body_string)


func getUI(nome:String):
	emit_signal("GetUI",nome)
