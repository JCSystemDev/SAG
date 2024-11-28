class_name Notifications extends Node2D
@onready var world: PackedScene = load("res://Scenes/world.tscn")
@onready var endgame_label: Label = $"Endgame Notification/Label"
@onready var win_buttons = $"Endgame Notification/Win Buttons"
@onready var lose_buttons = $"Endgame Notification/Lose Buttons"
@onready var animation_player = $AnimationPlayer
@onready var win_label = $"Endgame Notification/Win Buttons/Win Message"
@onready var lose_label = $"Endgame Notification/Lose Buttons/Lose Message"

func _on_exit_button_pressed():
	AudioManager.play_sound("Discard.wav")
	Transition.load_scene(world, "transition")

func _on_retry_button_pressed():
	AudioManager.play_sound("Equip.wav")
	Transition.reaload_scene("transition")

func _on_end_button_pressed():
	AudioManager.play_sound("Discard.wav")
	Transition.load_scene(world, "transition")	
