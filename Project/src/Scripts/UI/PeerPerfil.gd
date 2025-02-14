extends NinePatchRect


@onready var PlayerInfo = get_node("PlayerInfos")


func getUI(nome:String,stat:Dictionary):
	Actions.mouse_onUI=true
	PlayerInfo.get_node("PlayerName").text=nome
	for i in stat.keys():
		var peer = PlayerInfo.get_node_or_null(i)
		if peer:
			peer.get_node("Valor").text = str(stat[i])

	visible=true



func _on_fechar_pressed():
	visible = false
	Actions.mouse_onUI=false


func _on_pvp_pressed():
	get_parent().sendPvpRequest()
