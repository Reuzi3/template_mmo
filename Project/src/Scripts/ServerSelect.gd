extends OptionButton

var sound_effect: AudioStream
var audio_player: AudioStreamPlayer

func _ready():
	sound_effect = preload("res://src/Sounds/SFX/button_click1.ogg")
	var _connection = connect("pressed", Callable(self, "_on_button_pressed"))  
	
	audio_player = $"../../SFX"

func _on_button_pressed():
	if audio_player:
		audio_player.stop()
		audio_player.stream = sound_effect
		audio_player.play()


func _on_ServerSelect_item_selected(_index):
	if audio_player:
		audio_player.stop()
		audio_player.stream = sound_effect
		audio_player.play()

