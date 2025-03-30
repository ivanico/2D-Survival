extends CharacterBody2D



@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var collision_area = $CollisionArea2D
@onready var hp = $HP
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var player = $Player
@onready var velocity_component = $VelocityComponent


var number_colliding_bodies = 0
var base_speed = 0

func _ready():
	
	base_speed = velocity_component.max_speed
	collision_area.body_entered.connect(on_body_entered)
	collision_area.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	update_hp()
	
func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	
	if movement_vector.x != 0 or movement_vector.y != 0:
		animation_player.play("walk")
		if movement_vector.x > 0:
			player.flip_h = false
		else:
			player.flip_h = true
	else:
		animation_player.play("RESET")

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)

#checking is something dealing dmg to us
func check_dmg():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()
	

func update_hp():
	hp.value = health_component.get_health_percent()


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_dmg()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_dmg()


func on_health_changed():
	GameEvents.emit_player_damaged()
	update_hp()


func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrade: Dictionary):
	if ability_upgrade is Ability:
		var ability = ability_upgrade as Ability
		abilities.add_child(ability.ability_controller_scene.instantiate())
	elif ability_upgrade.id == "player_speed":
		velocity_component.max_speed = base_speed + (base_speed * current_upgrade["player_speed"]["quantity"] * 1)
