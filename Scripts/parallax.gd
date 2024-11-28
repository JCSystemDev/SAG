class_name BackgroundParallax extends Node2D
var background_sprite: Texture2D
var speed: int = 250
@onready var game_zone : GameZone = $".."
@onready var sprite_background : Sprite2D = $ParallaxBackground/ParallaxLayer/Sprite

func _ready():
	pass

func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 1) * speed * delta_time	

func _process(delta) -> void:
	parallax_bg(delta)
