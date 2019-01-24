extends KinematicBody2D

export (float) var acceleration
export (int) var max_speed
const BULLET_SCENE = preload("res://scenes/bullet.tscn")
var screensize  # Size of the game window.
var velocity = Vector2()

func _ready():
    screensize = get_viewport_rect().size
	
func _process(delta):
	var friction = false
	
	look_at(get_global_mouse_position())
	
	if Input.is_mouse_button_pressed(1):
		var clone = BULLET_SCENE.instance()
		clone.start(position, get_global_mouse_position())
		get_parent().add_child(clone)

	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + acceleration, max_speed)
	if Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - acceleration, -max_speed)
	if Input.is_action_pressed("ui_down"):
		velocity.y = min(velocity.y + acceleration, max_speed)
	if Input.is_action_pressed("ui_up"):
		velocity.y = max(velocity.y - acceleration, -max_speed)
	else:
		velocity.x = lerp(velocity.x, 0, 0.05)
		velocity.y = lerp(velocity.y, 0, 0.05)

	
	move_and_slide(velocity)
