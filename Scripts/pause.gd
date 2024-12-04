extends CanvasLayer
class_name Pause
@onready var menu: PackedScene = load("res://Scenes/menu.tscn")
@export var world: Node2D
@onready var parallax: ParallaxBackground = $ParallaxBackground
@onready var player_name_label: Label = $Player/Name
@onready var player_class_label: Label = $Player/Class
@onready var player_portrait: Sprite2D = $"Player/Player Portrait"
@onready var resume_button: Button = $"Buttons/Resume Button"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var message_label: Label = $"Text Box/Message"
@onready var programming_certificate: Sprite2D = $Certificates/Programming
@onready var database_certificate: Sprite2D = $"Certificates/Data Base"
@onready var cybersecurity_certificate: Sprite2D = $"Certificates/Cyber Security"
@onready var hardware_certificate: Sprite2D = $Certificates/Hardware 

func _ready():
	player_name_label.set_text(DataManager.player_stats[0]["player_name"])
	player_portrait.set_texture(DataManager.player_portrait)
	player_class_label.set_text(str(DataManager.player_stats[0]["player_class"]))
	
func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 1) * 150 * delta_time

func _process(delta):
	_get_certificates()
	parallax_bg(delta)
	

func _on_exit_button_pressed():
	get_tree().paused = false
	AudioManager.play_sound("Discard.wav")
	Transition.load_scene(menu, "transition")

func _on_resume_button_pressed():
	world.swap_pause_state()

func _on_save_button_pressed():
	AudioManager.play_sound("Equip.wav")
	DataManager._save_game()
	


func _get_certificates():
	if DataManager.player_stats[0]["hardware_certificate"]:
		hardware_certificate.show()
	else:
		hardware_certificate.hide()
	
	if DataManager.player_stats[0]["database_certificate"]:
		database_certificate.show()
	else:
		database_certificate.hide()
		
	if DataManager.player_stats[0]["programming_certificate"]:
		programming_certificate.show()
	else:
		programming_certificate.hide()
		
	if DataManager.player_stats[0]["cybersecurity_certificate"]:
		cybersecurity_certificate.show()
	else:
		cybersecurity_certificate.hide()
