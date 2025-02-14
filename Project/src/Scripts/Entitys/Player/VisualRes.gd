@tool
extends Node2D

@export var copiar_pose_para_os_iks = false: set = _set_copiar_pose_para_iks
@export var ativar_ik_maos = false: set = _set_ativar_ik_maos
@export var ativar_ik_pes = false: set = _set_ativar_ik_pes

@export var auto_set_cabeca = -1: set = _auto_set_cabeca
@export var auto_set_capacete = -1: set = _auto_set_capacete
@export var auto_set_armadura = -1: set = _auto_set_armadura
@export var auto_set_arma = -1: set = _auto_set_arma

 
var tipo_cabeca = 1: set = set_tipo_cabeca
var id_capacete = -1: set = set_id_capacete
var id_armadura = -1: set = set_id_armadura
var id_arma:= -1: set = set_id_arma

var cabeca:Sprite2D
var partes_capacete:Array
var partes_armadura:Array
var arma:Sprite2D

var tempo_efeito_dano = 0.0

@onready var iks = $IKs.get_children()

# Variáveis para acesso rápido as partes do heroi
@onready var mao_esq = $Tronco/BracoEsq/AntebracoEsq/MaoEsq
@onready var mao_dir = $Tronco/BracoDir/AntebracoDir/MaoDir

@onready var pos_refs := [$Tronco/BracoEsq/AntebracoEsq/MaoEsq/PivotArma/Position2D_0, $Position2D_1]

var pronto = false
func _ready():
	auto_set_cabeca = -1
	auto_set_capacete = -1
	auto_set_armadura = -1
	auto_set_arma = -1
	cabeca = $Tronco/Cabeca
	partes_capacete = cabeca.get_children()
	pegar_filhos(get_node("Tronco"), partes_armadura, ["Cabeca", "PivotArma", "Arma"])
	arma = $Tronco/BracoEsq/AntebracoEsq/MaoEsq/PivotArma/Arma
	
	set_tipo_cabeca(tipo_cabeca)
	set_id_capacete(id_capacete)
	set_id_armadura(id_armadura)
	set_id_arma(id_arma)
	pronto = true

		
func _set_copiar_pose_para_iks(valor):
	copiar_pose_para_os_iks = false
	if  is_inside_tree():
		if iks && valor:
			for i in iks.size():
				iks[i]._set_copiar_pose_para_ik(true)
			
func _set_ativar_ik_maos(valor):
	ativar_ik_maos = valor
	if is_inside_tree():
		if iks:
			for i in 2:
				iks[i].fixar = valor

func _set_ativar_ik_pes(valor):
	ativar_ik_pes = valor
	if is_inside_tree():
		if iks:
			for i in 2:
				iks[i+2].fixar = valor

func pegar_filhos(no_inicial:Node, filhos_encontrados:Array, nomes_excluir:Array):
	if !(no_inicial.name in nomes_excluir):
		filhos_encontrados.append(no_inicial)	
		var filhos_no_inic = no_inicial.get_children()
		if filhos_no_inic.size() > 0:
			for f in filhos_no_inic:
				pegar_filhos(f, filhos_encontrados, nomes_excluir)

func carregar_e_colocar(valor, caminho_res, nodes, tipo_item):
	var tipos = ["id_capacetes", "Armaduras"]
	if ResourceLoader.exists(caminho_res):
		var res_equip = ResourceLoader.load(caminho_res)
		if res_equip.texturas.size() == 0:
			print("Texturas ainda não foram postas em "+caminho_res)
			return
		
		for i in nodes.size():
			var p = nodes[i]
			
			if res_equip.z_indexes.size() > 0:
				p.z_index = res_equip.z_indexes[i]
			
			if res_equip.texturas[i]:
				var caminho_textura = "res://Assets/Texturas/Partes/"+p.name+"/"+res_equip.texturas[i]+".png"
				
				if ResourceLoader.exists(caminho_textura):
					p.texture = load(caminho_textura)
					
				else:
					print(caminho_textura, " não encontrado!")
					p.texture = null
			else:
				p.texture = null
				
		if tipo_item == 0 && res_equip.z_indexes.size() > 0:
			cabeca.z_index = res_equip.z_indexes[-1]
	else:
		print(caminho_res, " não encontrado!")

func set_id_capacete(valor):
	id_capacete = valor
	if pronto && is_inside_tree():
		var caminho_res = "res://Assets/Items/Capacetes/"+str(valor)+".res"
		carregar_e_colocar(valor, caminho_res, partes_capacete, 0)
			
func set_id_armadura(valor):
	id_armadura = valor
	if pronto && is_inside_tree():
		var caminho_res = "res://Assets/Items/Armaduras/"+str(valor)+".res"
		carregar_e_colocar(valor, caminho_res, partes_armadura, 1)
		
func set_tipo_cabeca(valor):
	tipo_cabeca = valor
	if pronto && is_inside_tree():
		var caminho_textura = "res://Assets/Texturas/Partes/"+cabeca.name+"/"+str(tipo_cabeca).pad_zeros(3)+".png"
		if ResourceLoader.exists(caminho_textura):
			cabeca.texture = load(caminho_textura)
		else:
			print(caminho_textura, " não encontrado!")
			cabeca.texture = null

func set_id_arma(valor):
	id_arma = valor
	if pronto && is_inside_tree():
		var caminho_res = "res://Assets/Items/Armas/"+str(valor)+".res"
		if ResourceLoader.exists(caminho_res):
			var res_equip = ResourceLoader.load("res://Assets/Items/Armas/"+str(valor)+".res")
			
			if res_equip.textura:
				var caminho_textura = "res://Assets/Texturas/Armas/"+res_equip.textura+".png"
				
				if ResourceLoader.exists(caminho_textura):
					arma.texture = load(caminho_textura)
					arma.z_index = res_equip.z_index
					arma.transform = res_equip.transform
					arma.offset = res_equip.offset
				else:
					print(caminho_textura, " não encontrado!")
					arma.texture = null
			else:
				arma.texture = null
		else:
			print(caminho_res, " não encontrado!")

func _auto_set_cabeca(valor):
	auto_set_cabeca = valor
	if Engine.is_editor_hint() && is_inside_tree():
		set_tipo_cabeca(valor)

func _auto_set_capacete(valor):
	auto_set_capacete = valor
	if Engine.is_editor_hint() && is_inside_tree():
		for p in partes_capacete:
			var caminho_textura = "res://Assets/Texturas/Partes/"+p.name+"/"+str(valor).pad_zeros(3)+".png"
			if ResourceLoader.exists(caminho_textura):
				p.texture = load(caminho_textura)
			else:
				p.texture = null
				print(caminho_textura," não encontrada!")

func _auto_set_armadura(valor):
	auto_set_armadura = valor
	if Engine.is_editor_hint() && is_inside_tree():
		for p in partes_armadura:
			var caminho_textura = "res://Assets/Texturas/Partes/"+p.name+"/"+str(valor).pad_zeros(3)+".png"
			if ResourceLoader.exists(caminho_textura):
				p.texture = load(caminho_textura)
			else:
				p.texture = null
				print(caminho_textura," não encontrada!")

func _auto_set_arma(valor):
	auto_set_arma = valor
	if Engine.is_editor_hint()&& is_inside_tree():
		var caminho_textura = "res://Assets/Texturas/Armase/"+str(valor)+".png"
		if ResourceLoader.exists(caminho_textura):
			arma.texture = load(caminho_textura)
		else:
			arma.texture = null
			print(caminho_textura," não encontrada!")
