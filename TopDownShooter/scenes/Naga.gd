extends KinematicBody2D

const SPEED = 100.0    

func _physics_process(delta):
    var direction = ($Player.position - position).normalized()
    var motion = direction * SPEED * delta
    position += motion