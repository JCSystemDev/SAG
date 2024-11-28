extends CanvasLayer
@onready var world_scene: PackedScene = load("res://Scenes/world.tscn")
@onready var accept_button: Button = $"Choose Character/Accept"
@onready var player_name: LineEdit = $"Choose Character/LineEdit"
@onready var a_type: Button = $"Choose Character/A-Type"
@onready var b_type: Button = $"Choose Character/B-Type"
@onready var c_type: Button = $"Choose Character/C-Type"
@onready var d_type: Button = $"Choose Character/D-Type"

func _ready():
	player_name.grab_focus()
	player_name.set_text("")
	accept_button.set_disabled(true)
	a_type.set_disabled(true)
	b_type.set_disabled(true)
	c_type.set_disabled(true)
	d_type.set_disabled(true)

func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 1) * 250 * delta_time	

func _process(delta):
	parallax_bg(delta)
	if player_name.text and player_name.text.strip_edges() != "" :
		a_type.set_disabled(false)
		b_type.set_disabled(false)
		c_type.set_disabled(false)
		d_type.set_disabled(false)
	else:
		a_type.set_disabled(true)
		b_type.set_disabled(true)
		c_type.set_disabled(true)
		d_type.set_disabled(true)

func _on_accept_pressed():
	DataManager.player_stats[0]["player_name"] = player_name.text
	DataManager._new_game()
	AudioManager.play_sound("Equip.wav")
	Transition.load_scene(world_scene, "transition")
	accept_button.set_disabled(true)


func _on_a_type_pressed():
	AudioManager.play_sound("Accept.wav")
	DataManager.player_stats[0]["player_type"] = "Knight"
	DataManager._get_player_texture("res://Assets/Sprites/Player/Knight.png", "res://Assets/Sprites/Portraits/Knight.png")
	if player_name.text != "":
		accept_button.set_disabled(false)
	accept_button.grab_focus()


func _on_b_type_pressed():
	AudioManager.play_sound("Accept.wav")
	DataManager.player_stats[0]["player_type"] = "Wizard"
	DataManager._get_player_texture("res://Assets/Sprites/Player/Wizard.png", "res://Assets/Sprites/Portraits/Wizard.png")
	if player_name.text != "":
		accept_button.set_disabled(false)
	accept_button.grab_focus()


func _on_c_type_pressed():
	AudioManager.play_sound("Accept.wav")
	DataManager.player_stats[0]["player_type"] = "Viking"
	DataManager._get_player_texture("res://Assets/Sprites/Player/Viking.png", "res://Assets/Sprites/Portraits/Viking.png")
	if player_name.text != "":
		accept_button.set_disabled(false)
	accept_button.grab_focus()


func _on_d_type_pressed():
	AudioManager.play_sound("Accept.wav")
	DataManager.player_stats[0]["player_type"] = "Goblin"
	DataManager._get_player_texture("res://Assets/Sprites/Player/Goblin.png", "res://Assets/Sprites/Portraits/Goblin.png")
	if player_name.text != "":
		accept_button.set_disabled(false)
	accept_button.grab_focus()


func _on_line_edit_text_submitted(new_text):
	a_type.grab_focus()
