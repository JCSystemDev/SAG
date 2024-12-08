class_name NPC extends Node2D
var npc_hp: int
var current_hp: int
var sprite_texture: Texture2D
var exp_points: int

@onready var game_zone : GameZone = $".."
@onready var name_npc_label : Label = $"Enemy Name"
@onready var sprite_npc : Sprite2D = $"Enemy Sprite"
@onready var hp_npc : ProgressBar = $"Enemy Bar/Enemy HP"
@onready var npc_animation: AnimationPlayer = $AnimationPlayer

func _get_values(_npc_name: String):
	for npc in DataManager.npcs:
		if npc["npc_realname"] == _npc_name:
			npc_hp = npc["npc_hp"]
			current_hp = npc_hp
			sprite_texture = load(npc["npc_sprite"])
			if _npc_name == "Guardian TI":
				DataManager._get_question_final_list()
			else:
				DataManager._get_question_list(npc["npc_type"])

func _set_values():
	name_npc_label.set_text(game_zone.npc_name)
	hp_npc.set_max(npc_hp)
	hp_npc.set_value(current_hp)
	sprite_npc.set_texture(sprite_texture)

func _update_values(_hp):
	hp_npc.set_value(_hp)
	
func _ready():
	npc_animation.play("RESET")
	_get_values(game_zone.npc_name)
	_set_values()

func _process(_delta):
	_update_values(current_hp)
