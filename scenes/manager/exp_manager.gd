extends Node

signal exp_updated(current_exp: float, target_exp: float)
signal lvl_up(new_lvl: int)

const TARGET_EXP_GROWTH = 5

var current_exp = 0
var current_lvl = 1
var target_exp = 1

func _ready():
	GameEvents.exp_vial_collected.connect(on_exp_vial_collected)
	

func increment_experience(number: float):
	current_exp = min(current_exp + number, target_exp)
	exp_updated.emit(current_exp, target_exp)
	if current_exp == target_exp:
		current_lvl += 1
		target_exp += TARGET_EXP_GROWTH
		current_exp = 0 
		exp_updated.emit(current_exp, target_exp)
		lvl_up.emit(current_lvl)

func on_exp_vial_collected(number: float):
	increment_experience(number)
