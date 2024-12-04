class_name NPCCharacter extends Node2D

@export var npc_name: String
var sprite_frames: SpriteFrames = load("res://Animations/npc_idle.tres")
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: InteractionArea = $"Interaction Area"

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	var frame_1: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"5.png")
	var frame_2: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"6.png")
	var animation_name: String = npc_name + "_idle"
	sprite_frames.add_animation(animation_name)
	sprite_frames.add_frame(animation_name, frame_1)
	sprite_frames.add_frame(animation_name, frame_2)
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.play(animation_name)

func _on_interact():
	for npc in DataManager.npcs:
		if npc_name == npc["npc_name"]: 
			DataManager.npc_question = npc["question"]
			DataManager.npc_negative = npc["negative"]
			DataManager.npc_lose = npc["lose_game"]
			DataManager.npc_win = npc["win_game"]
			DataManager.npc_name = npc["npc_realname"]
			DataManager.npc_texture = load(npc["npc_sprite"])	
	DialogueManager._load_dialogue_box(DataManager.npc_question, DataManager.npc_texture, DataManager.npc_name)
	DialogueManager._play_dialogue_box()
	DialogueManager._show_buttons()
