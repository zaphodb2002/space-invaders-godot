extends Area2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	reparent(get_parent().get_parent())

func _process(delta):
	translate(Vector2(0,-speed * delta))


func _on_body_entered(body):
	queue_free()
