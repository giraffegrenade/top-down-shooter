extends KinematicBody2D

export (float) var acceleration
export (int) var max_speed
export (int) var shake_amount = 3
const BULLET_SCENE = preload("res://scenes/bullet.tscn")
var screensize  # Size of the game window.
var velocity = Vector2()
var timer
var bullet_delay = 0.1
var can_shoot = true

func _ready():
	screensize = get_viewport_rect().size
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(bullet_delay)
	timer.connect("timeout", self, "on_timeout_complete")
	
func screen_shake():
	$Camera2D.set_offset(Vector2( \
		rand_range(-1.0, 1.0) * shake_amount, \
		rand_range(-1.0, 1.0) * shake_amount \
	))
	
func _process(delta):
	var friction = false; print(str(timer.get_time_left()))
	
	look_at(get_global_mouse_position())
	
	if Input.is_mouse_button_pressed(1) and can_shoot:
		screen_shake()
		var clone = BULLET_SCENE.instance()
		clone.start(position, get_global_mouse_position())
		get_parent().add_child(clone)
		can_shoot = false
		add_child(timer)
		timer.start()

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

func on_timeout_complete():
	can_shoot = true