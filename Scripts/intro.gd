extends Node2D
@onready var logo: Sprite2D = $Logo
@onready var intro_anim: AnimationPlayer = $AnimationPlayer
@onready var menu: PackedScene = load("res://Scenes/menu.tscn")

func _ready():
	AudioManager.play_music("Inacap Loop.mp3")
	intro_anim.play("fade_out")
	await intro_anim.animation_finished
	intro_anim.play("logo")
	AudioManager.play_sound("Equip.wav")
	await intro_anim.animation_finished
	intro_anim.play("fade_in")
	await intro_anim.animation_finished
	Transition.load_scene(menu, "transition")
	
	
