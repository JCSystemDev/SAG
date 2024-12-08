extends Node2D
@onready var start_button: Button = $"Start Game"

func _process(delta):
	parallax_bg(delta)

func _on_start_game_pressed():
	AudioManager.play_sound("Equip.wav")
	Transition.load_scene(DataManager.world_scene, "transition")
	start_button.set_disabled(true)
	
func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 1) * 250 * delta_time	
