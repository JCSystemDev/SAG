class_name Player extends Node2D
var current_hp: int

@onready var player_portrait: Sprite2D = $"Stats Display/Portrait"
@onready var player_name: Label = $"Stats Display/HP/Player Name"
@onready var player_hp_bar: ProgressBar = $"Stats Display/HP/Health Bar/Player HP"
@onready var stats_display: Node2D = $"Stats Display"
@onready var player_anim: AnimationPlayer = $"Stats Display/AnimationPlayer"
@onready var game_zone: GameZone = $".."

func _get_values(): 
	current_hp = DataManager.player_stats[0]["player_hp"]

func _set_values():
	player_portrait.set_texture(DataManager.player_portrait)
	player_name.set_text(str(DataManager.player_stats[0]["player_name"]))
	player_hp_bar.set_max(float(DataManager.player_stats[0]["player_hp"]))
	player_hp_bar.set_value(float(current_hp))

func _ready():
	_get_values()
	_set_values()

func _process(_delta):
	_set_values()
