extends Resource
class_name CapaceteRes

@export var id := 0
@export var nome := ""
@export var descricao = "" # (String, MULTILINE )
@export var custo_ouro:int = 10 
@export var custo_prata:int = 10 
@export var classes_equipaveis :Array = [-1]
@export var tipos_equipaveis :Array = [-1]

# Valores positivos acrescentam e valores negativos diminuem os atributos.
@export var att:int = 0
@export var mag:int = 0
@export var def:int = 5
@export var res:int = 5
@export var spd:int = 0 
@export var skl:int = 0
@export var lck:int = 0

# Apenas o nome das texturas, sem extensão.
# Ela será procurada com o indice no array
# 0: 
@export var texturas:Array = []

@export var z_indexes :Array = []

# Retorna um array com atributos na ordem
# at, mag, def, res, ski, spd, lck
func atrib_para_array()->PackedFloat32Array:
	return PackedFloat32Array([att, mag, def, res, skl, spd, lck])
