extends Control


@onready var username_textbox: LineEdit = get_node("Username")
@onready var password_textbox: LineEdit = get_node("Password")
@onready var email_textbox: LineEdit = get_node("Email")
@onready var labelErro:Label = get_node("Log")
@onready var http = Actions.http
@onready var gender_box = get_node("GenderSelect")
@onready var Parent = get_parent()

func _ready():
	http.connect("request_completed", Callable(self, "request_completed"))


func request_completed(result, response_code, headers, body):
	if response_code ==200:
		
		var json = JSON.parse_string(body.get_string_from_utf8())
		var msg = json
		print(msg)
		if "Registration Successful" in msg["message"]:
			pass
		labelErro.text=msg["message"]
	else:
		labelErro.text="ERROR"


func _on_Create_pressed():
	var username = username_textbox.text
	var password = password_textbox.text
	var email = email_textbox.text
	var gender = gender_box.btt
	if username=="" or password=="" or email=="":
		labelErro.text="*Fill in all fields*"
		return
	if not("@" in email) or not(".com" in email):
		labelErro.text="Invalid Email."
		return
	
	Parent.username = username
	Parent.password = password
	Parent.email = email
	Parent.gender = gender
	visible=false
	


func _on_close_pressed():
	Actions.changeSceane(Actions.sceanes["Login"])


func _on_bla_pressed():
	Actions.changeSceane(Actions.sceanes["Login"])
