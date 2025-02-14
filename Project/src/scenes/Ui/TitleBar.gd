extends Control

signal exitGame

var following = false
var dragging_start_position = Vector2()

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			following = !following
			dragging_start_position = get_global_mouse_position()


func _process(_delta):
	if following:
		DisplayServer.window_set_position(DisplayServer.window_get_position() + Vector2i(get_global_mouse_position() - dragging_start_position)) 


func _on_close_button_pressed():
	emit_signal("exitGame")
	await get_tree().create_timer(0.4).timeout 
	get_tree().quit()


func _on_minimize_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func _on_maximize_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)






func _on_options_pressed():
	var panel = $Options/Panel
	if panel.is_visible():
		panel.hide()
	else:
		panel.show()



func transition_resolution_text():
	await get_tree().create_timer(1.0).timeout
	var modulate_color = Color(1, 1, 1, 1)  # Cor inicial (sem transparência)

	while modulate_color.a > 0:
		modulate_color.a -= 0.05 # Diminua gradualm ente a transparência
		$ReferenceRect2/Resolution.modulate = modulate_color
		await get_tree().create_timer(0.04).timeout


func _on_button_0_pressed():
	get_window().set_size(Vector2(1920, 1035))
	DisplayServer.window_set_position(Vector2(DisplayServer.screen_get_position()) + DisplayServer.screen_get_size()*0.5 - DisplayServer.window_get_size()*0.5)
	$Options/Panel.hide()
	$ReferenceRect2/Resolution.text = "1920x1080"
	transition_resolution_text()




func _on_button_1_pressed():
	get_window().set_size(Vector2(1280, 720))
	DisplayServer.window_set_position(Vector2(DisplayServer.screen_get_position()) + DisplayServer.screen_get_size()*0.5 - DisplayServer.window_get_size()*0.5)
	$Options/Panel.hide()
	$ReferenceRect2/Resolution.text = "1280x720"
	transition_resolution_text()
	
func _on_button_2_pressed():
	get_window().set_size(Vector2(768, 432))
	DisplayServer.window_set_position(Vector2(DisplayServer.screen_get_position()) + DisplayServer.screen_get_size()*0.5 - DisplayServer.window_get_size()*0.5)
	$Options/Panel.hide()
	$ReferenceRect2/Resolution.text = "768x432"
	transition_resolution_text()
	
	
func _on_button_3_pressed():
	get_window().set_size(Vector2(640, 360))
	DisplayServer.window_set_position(Vector2(DisplayServer.screen_get_position()) + DisplayServer.screen_get_size()*0.5 - DisplayServer.window_get_size()*0.5)
	$Options/Panel.hide()
	$ReferenceRect2/Resolution.text = "640x360"
	transition_resolution_text()
