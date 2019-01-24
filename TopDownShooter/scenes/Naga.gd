extends KinematicBody2D

const SPEED = 100.0    

func _physics_process(delta):
    var direction = (get_parent().get_node("Player").position - position).normalized()
    var motion = direction * SPEED
    move_and_slide(motion)