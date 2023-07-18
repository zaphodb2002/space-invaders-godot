extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	reparent(get_parent().get_parent())

func _process(delta):
	translate(Vector2(0,-1))
	if(position.y < 0):
		queue_free()
