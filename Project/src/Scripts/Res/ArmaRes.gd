extends Resource
class_name ArmaRes

enum TipoDeDano {NORMAL, MAGICO}

@export var id := 0
@export var nome := ""
@export var descricao = "" # (String, MULTILINE )
@export var custo_ouro:int = 10 
@export var custo_prata:int = 10 
# Dano tipo NORMAL: considera o atributo att do atacante e o atributo
# def do defensor no cálculo do dano.
# Dano tipo MAGICO: considera o atributo mag do atacante e o atributo
# res do defensor no cálculo do dano.
@export var tipo_de_dano: TipoDeDano = TipoDeDano.NORMAL
@export var classes_equipaveis :Array
@export var tipos_equipaveis :Array

# Valores positivos acrescentam e valores negativos diminuem os atributos.
@export var att:int = 5
@export var mag:int = 5
@export var def:int = 0
@export var res:int = 0
@export var spd:int = 0 
@export var skl:int = 0
@export var lck:int = 0

# Animações que irão sobrescrever as animações padrões durante uma ação.
# Deve se deixado vazio se quiser que a animação padrão seja executada.
@export var anim_item :String= ""
@export var anim_ataque :String= ""
@export var anim_skill :String= ""
@export var anim_escape :String= ""
@export var nome_efeito :String= ""

@export var transform:Transform2D = Transform3D.IDENTITY
@export var offset:Vector2 = Vector2.ZERO
# Apenas o nome da textura, sem extensão.
# Ela será procurada na pasta res://Assets/Texturas/Armas/
@export var textura:String = ""
@export var z_index:int = 0

# Retorna um array com atributos na ordem
# at, mag, def, res, ski, spd, lck
func atrib_para_array()->PackedFloat32Array:
	return PackedFloat32Array([att, mag, def, res, skl, spd, lck])
