extends CanvasLayer

var in_transition: bool
@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer
@onready var transition_canvas = $"."

func _ready():
	transition_canvas.hide()
	color_rect.visible = false
	in_transition = false

func load_scene(target_scene: PackedScene, transition: String):
	transition_canvas.show()
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(target_scene)
	animation_player.play_backwards(transition)
	await animation_player.animation_finished
	color_rect.visible = false
	transition_canvas.hide()
	
func reaload_scene(transition: String):
	transition_canvas.show()
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards(transition)
	await animation_player.animation_finished
	color_rect.visible = false
	transition_canvas.hide()
	
func play_transition(transition: String):
	transition_canvas.show()
	in_transition = true
	animation_player.play(transition)
	await animation_player.animation_finished
	in_transition = false
	animation_player.play("RESET")
	transition_canvas.hide()

func quit_transition(transition: String):
	transition_canvas.show()
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().quit()
