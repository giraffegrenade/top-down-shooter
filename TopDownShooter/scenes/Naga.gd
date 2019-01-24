extends KinematicBody2D

const SPEED = 100.0

var health = 1000  

func _physics_process(delta):
	var direction = (get_parent().get_node("Player").position - position).normalized()
    
	if direction.x > 0:
		$Sprite.set_flip_h(false)
	else:
		$Sprite.set_flip_h(true)
	
	var motion = direction * SPEED
	move_and_slide(motion)