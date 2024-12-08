class_name Tweens extends Node

func _shake_tween(node: Node):
	var shake = create_tween()
	for times in 10:
		shake.tween_property(node,"position", Vector2(node.position.x + 10,node.position.y),0.025)
		shake.tween_property(node,"position", Vector2(node.position.x - 10,node.position.y),0.025)
	shake.tween_property(node,"position", Vector2(node.position.x,node.position.y),0.025)

func _bounce_tween(node: Node):
	var bounce = create_tween()
	for times in 10:
		bounce.tween_property(node, "scale", node.scale * 0.95, 0.1)
		bounce.tween_property(node, "position", Vector2(node.position.x, node.position.y - 3), 0.1)
		bounce.tween_property(node, "scale", node.scale * 1.05, 0.1)
		bounce.tween_property(node, "position", Vector2(node.position.x, node.position.y + 3), 0.1)

	bounce.tween_property(node, "scale", node.scale, 0.2)
	bounce.tween_property(node, "position", node.position, 0.2)

func _appear_tween(node: Node):
	var appear = create_tween()
	appear.tween_property(node, "scale", Vector2(0,1),0)
	appear.tween_property(node, "scale", Vector2(1,1),0.25)
	
func _attack_tween(node: Node, distance: Vector2, time:float):
	var attack = create_tween()
	attack.tween_property(node, "position", distance, time)
	
func _color_tween(node: ColorRect, dark_color: Color, light_color: Color):
	var color = create_tween()
	for times in 5:
		color.tween_property(node, "color", dark_color, 0)
		color.tween_property(node, "color", light_color, 0.25)
		color.tween_property(node, "color", dark_color, 0.5)
