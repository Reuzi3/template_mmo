extends Node2D

@onready var Flip = get_node("Flip")
@export var anim:AnimationTree


var animState:String




func changeAnim(type:String):
	anim.set("parameters/conditions/"+animState,false)
	animState=type
	anim.set("parameters/conditions/"+type,true)


func _on_ui_active_pressed():
	Actions.getUI(name)


func _on_mouse_entered():
	Actions.mouse_onUI=true


func _on_mouse_exited():
	Actions.mouse_onUI=false
