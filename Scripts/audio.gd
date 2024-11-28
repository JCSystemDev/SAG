class_name Audio extends Node2D

var path_sfx: String = "res://Assets/Audio/SFX/"
var path_music: String = "res://Assets/Audio/Music/"

func play_sound(sound_name: String):
	var sound = load(path_sfx+sound_name)
	$"SFX".stream = sound
	$"SFX".play()

func play_music(music_name: String):
	var music = load(path_music+music_name)
	$"Music".stream = music
	$"Music".play()
