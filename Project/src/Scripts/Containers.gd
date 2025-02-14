extends HBoxContainer

var botao1: TextureButton
var botao2: TextureButton

var btt =false#false--male


func _ready():
	botao1 = $Botao1
	botao2 = $Botao2

	var _conexaoBotao1 = botao1.connect("pressed", Callable(self, "_botao1_pressed"))
	var _conexaoBotao2 = botao2.connect("pressed", Callable(self, "_botao2_pressed"))

func _botao1_pressed():
	btt =true
	botao2.button_pressed = false  # Desmarca o botão 2
	botao1.button_pressed = true   # Marca o botão 1

func _botao2_pressed():
	btt =false
	botao1.button_pressed = false  # Desmarca o botão 1
	botao2.button_pressed = true   # Marca o botão 2
