class_name NPCBattle extends Node2D

var npc_name: String = DataManager.npc_summon
var player_class: String = DataManager.player_stats[0]["player_class"]
var sprite_frames: SpriteFrames = load("res://Animations/npc_battle.tres")
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var vfx: AnimatedSprite2D = $VFX
@export var is_npc: bool

func _ready():
	vfx.hide()
	if is_npc:
		vfx.scale.x = -1
		_get_values(npc_name)
		var frame_1: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"11.png")
		var frame_2: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"12.png")
		var animation_name: String = npc_name + "_battle"
		sprite_frames.add_animation(animation_name)
		sprite_frames.add_frame(animation_name, frame_1)
		sprite_frames.add_frame(animation_name, frame_2)
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.play(animation_name)
	else:
		var frame_1: Texture2D = load("res://Assets/Sprites/Player/"+player_class+"9.png")
		var frame_2: Texture2D = load("res://Assets/Sprites/Player/"+player_class+"10.png")
		var animation_name: String = "player_battle"
		sprite_frames.add_animation(animation_name)
		sprite_frames.add_frame(animation_name, frame_1)
		sprite_frames.add_frame(animation_name, frame_2)
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.play(animation_name)
		
func _get_values(real_name):
	for npc in DataManager.npcs:
		if npc["npc_realname"] == real_name:
			npc_name = npc["npc_name"]

	
