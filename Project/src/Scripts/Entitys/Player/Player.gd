extends Node2D

var map: TileMap
var manager

var speed = 3
var move: bool = false
var animState: String
var last_target_pos: Vector2  # Declarando a variável no escopo global

@export var nav: NavigationAgent2D
@export var visual: Node2D
@export var anim: AnimationTree
@export var PlayerInfo: NinePatchRect
@export var ui: CanvasLayer

func _input(event):
	if not event is InputEventMouseButton:
		return
	if not event.is_pressed():
		return
	if event.button_index == MOUSE_BUTTON_LEFT and not (Actions.mouse_onUI):
		nav.target_position = get_global_mouse_position()
		move = true

func _process(_delta):
	if move:
		if !getAnim("walk"):
			changeAnim("walk")
		manager.send_player_position(position, visual.scale, "walk")

		var cur_pos = global_position
		var new_pos = nav.get_next_path_position()
		var newVel = (new_pos - cur_pos).normalized() * speed

		# Move para a posição seguinte na direção normalizada
		position += newVel

		if newVel.x > 0:
			visual.scale.x = -1
		else:
			visual.scale.x = 1


		if nav.is_target_reached():
			roundPosition()
			nav.target_position = position  # Define o destino como a posição atual para interromper a navegação

func roundPosition():
	var rounded_pos = position
	rounded_pos.x = round(rounded_pos.x)
	rounded_pos.y = round(rounded_pos.y)
	position = rounded_pos

	if rounded_pos != last_target_pos:
		last_target_pos = rounded_pos

func _on_navigation_agent_2d_navigation_finished():
	move = false
	changeAnim("idle")
	manager.send_player_position(position, visual.scale, "idle")

func changeAnim(type: String):
	anim.set("parameters/conditions/" + animState, false)
	animState = type
	anim.set("parameters/conditions/" + type, true)

func getAnim(type: String):
	return anim.get("parameters/conditions/" + type)
