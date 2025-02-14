extends TextureButton

var audioStreamPlayer: AudioStreamPlayer
var isPressed: bool = false
var volume: float = 0.08

func _ready():
	audioStreamPlayer = $"../../BGM"
	audioStreamPlayer.stream = preload("res://src/Sounds/BGM/Fairytale-Waltz.ogg")
	audioStreamPlayer.playing = true
	audioStreamPlayer.volume_db = linear_to_db(volume)
	
	toggle_mode = true

func _on_SomBGM_pressed():
	audioStreamPlayer.playing = !audioStreamPlayer.playing
	isPressed = !audioStreamPlayer.playing

func _on_SomBGM_toggled(button_pressed):
	isPressed = button_pressed
	
	if isPressed:
		# Ação quando o botão é pressionado
		print("Botão pressionado")
	else:
		# Ação quando o botão é solto
		print("Botão solto")
