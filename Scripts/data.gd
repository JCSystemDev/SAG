extends Node2D
class_name Data

# Data Base Access
var questions = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/question.json"))
var npcs = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/npcs.json"))

# Scenes
var world_scene: PackedScene = load("res://Scenes/world.tscn")
var menu_scene: PackedScene = load("res://Scenes/menu.tscn")
var tutorial_scene: PackedScene = load("res://Scenes/tutorial.tscn")
var new_game_scene: PackedScene = load("res://Scenes/new_game.tscn")
var gameover_scene: PackedScene = load("res://Scenes/gameover.tscn")

# Menu Variables
var in_game: bool = false

# Questions
var question_list: Array = []
var current_type
var current_question
var current_answer
var current_options

# Player Variables
var all_certificates: bool
var in_battle: bool
var move_speed: float
var player_sprite: Texture2D
var player_portrait: Texture2D
var player_stats
var player_stats_load
var player_stats_default = [{
	"player_name": "",
	"player_level": 1,
	"player_hp": 5,
	"player_exp": 0,
	"player_position_x": 480,
	"player_position_y": 460,
	"player_sprite":"",
	"player_portrait":"" ,
	"player_class":"",
	"win_battles":0,
	"lose_battles":0,
	"correct_questions":0,
	"incorrect_questions":0,
	"p_cert":false,
	"h_cert":false,
	"d_cert":false,
	"c_cert":false
	}]

# NPC Variables
var npc_summon: String
var npc_negative: String
var npc_question: String
var npc_win: String
var npc_lose: String
var npc_name: String
var npc_texture: Texture2D
var npc_type: String

# Build Questions
func _get_question(code_question: String):
	for question in questions:
		if question["question_code"] == code_question:
			current_question = question["question"]
			current_answer = question["answer"]
			current_options = question["options"]
			
func _get_question_list(type_question: String):
	current_type = type_question
	for question in questions:
		if question["question_type"] == type_question:
			question_list.append(question["question_code"])
	question_list.shuffle()

func _get_question_final_list():
	_get_question_list("HW")
	question_list.shuffle()
	_get_question_list("CS")
	question_list.shuffle()
	_get_question_list("DB")
	question_list.shuffle()
	_get_question_list("Code")
	question_list.shuffle()
	
func _clear_question_list():
	question_list = []
	
func _set_player_texture(player_texture: String, portrait_texture: String):
	player_stats[0]["player_sprite"] = player_texture
	player_stats[0]["player_portrait"] = portrait_texture

func _get_player_texture():
	player_sprite = load(player_stats[0]["player_sprite"])
	player_portrait = load(player_stats[0]["player_portrait"])
	
func _check_all_certificates():
	if player_stats[0]["c_cert"] and player_stats[0]["h_cert"] and player_stats[0]["p_cert"] and player_stats[0]["d_cert"]:
		all_certificates = true
	else:
		all_certificates = false		

# Data Functions

func _new_game():
	player_stats = player_stats_default

func _save_game():
	var player_stats_save = JSON.stringify(player_stats)
	var saved_file = FileAccess.open("user://player_stats_saved.json", FileAccess.WRITE)
	saved_file.store_string(player_stats_save)
	saved_file.close()

func _load_game():
	player_stats_load = JSON.parse_string(FileAccess.get_file_as_string("user://player_stats_saved.json"))
	player_stats = player_stats_load
	_get_player_texture()
	
func _save_file_exist():
	player_stats_load = FileAccess.get_file_as_string("user://player_stats_saved.json")
	if player_stats_load.is_empty():
		return false
	else:
		return true
