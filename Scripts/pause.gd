extends CanvasLayer
class_name Pause
@onready var menu: PackedScene = load("res://Scenes/menu.tscn")
@export var world: Node2D
@onready var parallax: ParallaxBackground = $ParallaxBackground
@onready var player_name_label: Label = $Player/Name
@onready var player_portrait: Sprite2D = $"Player/Player Portrait"
@onready var player_level_label: Label = $Player/Level
@onready var player_hp_label: Label = $Player/HP
@onready var player_exp_label: Label = $"Player/Exp"
@onready var resume_button: Button = $"Buttons/Resume Button"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var message_label: Label = $"Text Box/Message"

func _ready():
	player_name_label.set_text(DataManager.player_stats[0]["player_name"])
	player_portrait.set_texture(DataManager.player_portrait)
	player_level_label.set_text(str("LV: ",DataManager.player_stats[0]["player_level"]))
	player_hp_label.set_text(str("HP: ",DataManager.player_stats[0]["player_hp"],"/",DataManager.player_stats_default[0]["player_hp"]))
	player_exp_label.set_text(str("EXP: ",DataManager.player_stats[0]["player_exp"]))
	
func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 1) * 150 * delta_time	

func _process(delta):
	parallax_bg(delta)

func _on_exit_button_pressed():
	get_tree().paused = false
	AudioManager.play_sound("Discard.wav")
	Transition.load_scene(menu, "transition")

func _on_resume_button_pressed():
	world.swap_pause_state()

func _on_options_button_pressed():
	pass
