extends NinePatchRect



@onready var username_textbox: LineEdit = get_node("Username")
@onready var password_textbox: LineEdit = get_node("Password")
@onready var labelErro:Label = get_node("Log")
@onready var http:HTTPRequest = Actions.http

var remenber:bool=false




func _ready():
	http.connect("request_completed", Callable(self, "request_completed"))
	loadLogin()


func request_completed(_result, response_code, headers, body):
	if response_code ==200:
		
		var json = JSON.parse_string(body.get_string_from_utf8())
		var msg = json
		if "Login successful" in msg["message"]:
			Webserver.token=msg["token"]
			Actions.changeSceane(Actions.sceanes["Map01"])

		labelErro.text=msg["message"]
	else:
		labelErro.text="ERROR"


func saveLogin():
	var data = {
		"Username":username_textbox.text,
		"Passworld":password_textbox.text
	}
	var file = FileAccess.open("res://save.joshua", FileAccess.WRITE)

	var json_string = JSON.stringify(data)
	file.store_string(json_string)
	file.close()


func loadLogin():
	var file = FileAccess.open("res://save.joshua", FileAccess.READ)
	if  file:
		var json_string = file.get_as_text()
		file.close()

		var my_dictionary = JSON.parse_string(json_string)
		if "Username" in my_dictionary:
			username_textbox.text=my_dictionary["Username"]
			password_textbox.text=my_dictionary["Passworld"]
	else:
		print("Não foi possível abrir o arquivo.")


func _on_logar_pressed():
	var username = username_textbox.text
	var password = password_textbox.text
	if username=="" or password=="":
		labelErro.text="Fill in all fields."
		return
	var message = {"username": username, "password": password}
	if remenber:
		saveLogin()
	Webserver.usuario=username
	Actions.send_http_msg(message,"http://"+Webserver.url+"/login")



func _on_lembrar_toggled(button_pressed):
	print(button_pressed)
	remenber=button_pressed


func _on_criarconta_pressed():
	Actions.changeSceane(Actions.sceanes["CreateAccount"])
