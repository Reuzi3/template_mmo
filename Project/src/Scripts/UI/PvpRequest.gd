extends NinePatchRect

@onready var web = get_parent()

func _on_aceitar_pressed():
	visible = false
	web.SendResponsePvp(true)


func _on_recusar_pressed():
	visible = false
	web.SendResponsePvp(false)
