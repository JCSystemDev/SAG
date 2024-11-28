extends CanvasLayer
@onready var avatar_sprite: Sprite2D = $"Character Avatar/Avatar"
@onready var avatar_name: Label = $"Character Avatar/Name"
@onready var avatar_dialogue: Label = $Dialogue
@onready var dialogue_animation: AnimationPlayer = $AnimationPlayer
@onready var dialogue_box: CanvasLayer = $"."
@onready var yes_button: Button = $"Yes Button"
@onready var no_button: Button = $"No Button"

var pressed_yes: bool
var pressed_no: bool
var in_dialogue: bool
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn")

func _ready():
	pressed_yes = false
	pressed_no = false
	in_dialogue = false
	dialogue_box.visible = false

func _load_dialogue_box(_line: String, _texture: Texture2D, _name: String):
	avatar_sprite.set_texture(_texture)
	avatar_name.set_text(_name)
	avatar_dialogue.set_text(_line)
	
func _input(event):
	if event.is_action_pressed("ui_accept") and pressed_no:
		_close_dialogue()

func _play_dialogue_box():
	in_dialogue = true
	AudioManager.play_sound("Click.wav")
	dialogue_animation.play("write_text")
	await dialogue_animation.animation_finished
	yes_button.grab_focus()
	
func _close_dialogue():
	AudioManager.play_sound("Discard.wav")
	in_dialogue = false
	dialogue_box.visible = false
	pressed_yes = false
	pressed_no = false
		
	
func _on_yes_button_pressed():
	await get_tree().create_timer(0.2).timeout
	AudioManager.play_sound("Equip.wav")
	in_dialogue = false
	dialogue_box.visible = false
	pressed_yes = true
	get_tree().paused = true
	DataManager.npc_summon = avatar_name.text
	DataManager.in_battle = true
	Transition.load_scene(game_zone, "transition")
	AudioManager.play_sound("Summon.wav")

func _on_no_button_pressed():
	AudioManager.play_sound("Discard.wav")
	yes_button.visible = false
	no_button.visible = false
	_load_dialogue_box(DataManager.npc_negative, DataManager.npc_texture, DataManager.npc_name)
	_play_dialogue_box()
	await dialogue_animation.animation_finished
	pressed_no = true
	
	
	
