extends Node2D


@onready var label = $Label


func _ready():
	pass


func start (text: String):
	label.text = text
	
	var tween = create_tween()
	tween.set_parallel()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)

	tween.chain()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 48), 0.5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "scale", Vector2.ONE, 0.5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.chain()

	tween.tween_callback(queue_free)
	
	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ONE * 1.5, 0.15)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, 0.15)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
