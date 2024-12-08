extends Node2D
var transition: bool
@onready var player_pos: Marker2D = $"Player Position"
@onready var pause_screen: Pause = $"Pause Screen"
@onready var player = $Player

func _ready():
	pause_screen.hide()
	pause_screen.parallax.hide()
	AudioManager.play_music("Grind.mp3")
	_get_player_pos()
	_set_player_pos()

func _input(event):
	if event.is_action_pressed("ui_cancel") && !Transition.in_transition && !DialogueManager.visible:
		swap_pause_state()
		
func _get_player_pos():
	player_pos.global_position.x = DataManager.player_stats[0]["player_position_x"]
	player_pos.global_position.y = DataManager.player_stats[0]["player_position_y"]

func _set_player_pos():
	player.global_position.x = player_pos.global_position.x
	player.global_position.y = player_pos.global_position.y

func swap_pause_state():
	
	if not pause_screen.visible:
		get_tree().paused = true
		Transition.play_transition("crossfade")
		await get_tree().create_timer(0.25).timeout
		pause_screen.visible = true
		pause_screen.parallax.show()
		
	elif pause_screen.visible:
		get_tree().paused = false
		Transition.play_transition("crossfade")
		await get_tree().create_timer(0.25).timeout
		pause_screen.visible = false
		pause_screen.parallax.hide()
