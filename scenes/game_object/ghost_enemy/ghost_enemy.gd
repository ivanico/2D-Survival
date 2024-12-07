extends CharacterBody2D


@onready var sprite = $Sprite
@onready var velocity_component = $VelocityComponent

var is_moving = false

func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	if velocity.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true


func set_is_moving(moving: bool):
	is_moving = moving
