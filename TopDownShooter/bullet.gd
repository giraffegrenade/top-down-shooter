extends RigidBody2D
export (float) var speed

func start(pos):
	position = pos
	apply_impulse((pos - get_global_mouse_position()), ((pos - get_global_mouse_position())).normalized() * speed * -1)