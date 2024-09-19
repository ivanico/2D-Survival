extends Node

var current_exp = 0

func _ready():
	GameEvents.exp_vial_collected.connect(on_exp_vial_collected)
	

func increment_experience(number: float):
	current_exp += number
	print(current_exp)

func on_exp_vial_collected(number: float):
	increment_experience(number)
