extends TabContainer

@onready var PainelText:TextEdit = get_node("Global Chat/Chat/PainelTextos")
@onready var Chat:LineEdit = get_node("Global Chat/textBox")
@onready var web = get_parent()

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_T:
			visible = true
			Actions.mouse_onUI=true
		
		elif event.keycode == KEY_ESCAPE:
			visible = false
			await get_tree().create_timer(0.2).timeout
			Actions.mouse_onUI=false
		
		elif event.keycode == KEY_ENTER:
			_on_chaticone_pressed()
		
	else:
		return


func _on_chaticone_pressed():
	if Chat.text != "":
		var msg = Webserver.usuario + ":" + Chat.text + "\n"
		PainelText.text += msg
		Chat.text = ""
		web.send_chat_msg(msg)
