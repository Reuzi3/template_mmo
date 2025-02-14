extends Node

var max_width: int = 1280
var max_height: int = 720

func _ready():
	var screen_size = DisplayServer.screen_get_size()

	if OS.get_name() != "Android" && OS.get_name() != "iOS":
		var game_resolution = Vector2(max_width, max_height)
		var screen_ratio = screen_size.x / screen_size.y
		var game_ratio = game_resolution.x / game_resolution.y
		
		if screen_ratio < game_ratio:
			var new_width = int(screen_size.x)
			var new_height = int(screen_size.x / game_ratio)
			if new_width <= max_width and new_height <= max_height:
				resizeWindowTo16By9Resolution(Vector2(new_width, new_height))
		else:
			if screen_size.x == max_width and screen_size.y == max_height:
				resizeWindowTo16By9Resolution(Vector2(1024, 576))
			else:
				if screen_size.x < max_width or screen_size.y < max_height:
					resizeWindowToMonitorResolution()
				centerWindowOnScreen()

func resizeWindowToMonitorResolution():
	var screen_size = DisplayServer.screen_get_size()
	var desired_width = int(screen_size.x * 0.9)
	var desired_height = int(screen_size.y * 0.9)

	get_window().set_size(Vector2(desired_width, desired_height))

func resizeWindowTo16By9Resolution(new_resolution: Vector2):
	var screen_ratio = 16.0 / 9.0
	var new_width = int(new_resolution.y * screen_ratio)
	get_window().set_size(Vector2(new_width, new_resolution.y))
	centerWindowOnScreen()

func centerWindowOnScreen():
	var screen_size = DisplayServer.screen_get_size()
	var current_window_size = get_window().get_size()

	var center_x = (screen_size.x - current_window_size.x) / 2
	var center_y = (screen_size.y - current_window_size.y) / 2

	get_window().set_position(Vector2(center_x, center_y))
