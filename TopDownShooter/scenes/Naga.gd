extends KinematicBody2D

const SPEED = 100.0

var taking_damage = false
var health = 100
var last_player_pos

func _physics_process(delta):
	if health <= 0:
		queue_free()
	if taking_damage:
		$Sprite.modulate = Color(10, 10, 10)
		taking_damage = false
	else:
		$Sprite.modulate = Color(1,1,1,1)
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(get_parent().get_node("Player").position, position, [self])
	var direction
	print(result.shape)
	if result.shape == 0:
		last_player_pos = get_parent().get_node("Player").position
	direction = (last_player_pos - position).normalized()
		
	if direction.x > 0:
		$Sprite.set_flip_h(false)
	else:
		$Sprite.set_flip_h(true)
	
	var motion = direction * SPEED
	move_and_slide(motion)

func _on_Area2D_area_entered(area):
	taking_damage = true
	health -= 1