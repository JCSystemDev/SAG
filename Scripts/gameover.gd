extends Node2D
@onready var button_menu: Button = $Menu

func _ready():
	AudioManager.play_music("Curiosity.mp3")

func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 1) * 250 * delta_time	

func _process(delta):
	parallax_bg(delta)

func _on_menu_pressed():
	DataManager._new_game()
	AudioManager.play_sound("Equip.wav")
	Transition.load_scene(DataManager.menu_scene, "transition")
	button_menu.hide()
