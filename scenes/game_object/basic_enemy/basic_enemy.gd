extends CharacterBody2D

@onready var sprite = $Sprite
@onready var velocity_component = $VelocityComponent


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	if velocity.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
