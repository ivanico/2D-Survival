extends Node2D

@export var hp_component: Node
@export var sprite: Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var gpu_particles = $GPUParticles2D


func _ready():
	gpu_particles.texture = sprite.texture
	hp_component.died.connect(on_died)


func on_died():
	if owner == null || not owner is Node2D:
		return

	var spawn_position = owner.global_position

	var entities = get_tree().get_first_node_in_group("entities_layer")
	get_parent().remove_child(self)
	entities.add_child(self)
	global_position = spawn_position
	animation_player.play("default")
