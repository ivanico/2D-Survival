extends Node2D


func _ready():
	$Area2D.area_entered.connect(on_area_enterd)


func on_area_enterd(other_area: Area2D):
	GameEvents.emit_exp_vial_collected(1)
	queue_free()
