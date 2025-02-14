extends Control

var dragging = false
var offset = Vector2(0, 0)

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("mouse_click"):
		var mouse_position = event.global_position
		if rect_min_size.has_point(mouse_position):
			dragging = true
			offset = window_get_position() - mouse_position
			# Substitua a função de captura de mouse aqui, se necessário.
		event.accept_event()

	if event.is_action_released("mouse_click"):
		if dragging:
			dragging = false
			# Libere a captura de mouse aqui, se necessário.
		event.accept_event()

	if event.is_action("mouse_motion"):
		if dragging:
			var new_position = event.global_position + offset
			window_set_position(new_position)

# Substitua as funções de obtenção e configuração da posição da janela aqui,
# usando as funções do Windows fornecidas.

# Exemplo:
func window_get_position() -> Vector2:
	var position: Vector2
	# Use a função do Windows para obter a posição da janela e atribua-a à variável 'position'.
	return position

func window_set_position(position: Vector2):
	# Use a função do Windows para definir a posição da janela com base em 'position'.
