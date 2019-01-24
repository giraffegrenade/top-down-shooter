extends Area2D

#const BULLET_SCENE = preload("res://scenes/bullet.tscn")

func _ready():
	pass
	
func _process(delta):
	var clone = BULLET_SCENE.instance()
    clone.start(position, grenade_charge, get_global_mouse_position())
    get_parent().add_child(clone)