extends Resource
class_name FaceRes 
enum TipoDeDano {NORMAL, MAGICO}

@export var id := 0
@export var nome := ""
@export var descricao = "" # (String, MULTILINE )
@export var custo_ouro:int = 0
@export var custo_prata:int = 0
# Dano tipo NORMAL: considera o atributo att do atacante e o atributo
# def do defensor no cálculo do dano.
# Dano tipo MAGICO: considera o atributo mag do atacante e o atributo
# res do defensor no cálculo do dano.
@export var tipo_de_dano: TipoDeDano = TipoDeDano.NORMAL
@export var classes_equipaveis :Array
@export var tipos_equipaveis :Array

# Valores positivos acrescentam e valores negativos diminuem os atributos.
@export var att:int = 0
@export var mag:int = 0
@export var def:int = 0
@export var res:int = 0
@export var spd:int = 0 
@export var skl:int = 0
@export var lck:int = 0


@export var transform:Transform2D = Transform3D.IDENTITY
@export var offset:Vector2 = Vector2.ZERO
@export var textura:String = ""
@export var z_index:int = 0

func atrib_para_array()->PackedFloat32Array:
	return PackedFloat32Array([att, mag, def, res, skl, spd, lck])
