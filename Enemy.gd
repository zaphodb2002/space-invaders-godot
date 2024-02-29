class_name Enemy
extends Area2D

var gridpos = Vector2()

signal died(gridpos)
signal touched_side

func _ready():
	get_node("Sprite2D").frame = randi_range(0,1)

func die():
	died.emit(gridpos)
	queue_free()


func _on_body_entered(body):
	if body.collision_layer == 1:
		touched_side.emit()

func _on_area_entered(area):
	if area.collision_layer == 16:
		area.queue_free()
		die()
