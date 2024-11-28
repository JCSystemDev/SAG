extends Camera2D

var screen_size: Vector2 = Vector2(960,540)
var current_screen: Vector2 = Vector2(0, 0) 
	
func _ready():
	top_level = true
	global_position = get_parent().global_position
	_update_screen(current_screen)

func _physics_process(_delta):
	var parent_screen: Vector2 = (get_parent().global_position / screen_size).floor()
	if not parent_screen.is_equal_approx(current_screen):
		Transition.play_transition("crossfade")
		await get_tree().create_timer(0.25).timeout
		_update_screen(parent_screen)
		
func _update_screen(new_screen: Vector2):
	current_screen = new_screen
	global_position = current_screen * screen_size + screen_size * 0.5
