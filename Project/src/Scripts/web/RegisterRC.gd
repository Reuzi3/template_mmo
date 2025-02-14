extends Control


@onready var Parent = get_parent()

var SetClass:String
var SetRace:String

func _on_Season_pressed(classe):
	SetClass=classe


func _on_Race_pressed(race):
	
	SetRace= race


func _on_pronto_pressed():
	Parent.race = SetRace
	Parent.classe = SetClass
	Parent.SendAccount()
