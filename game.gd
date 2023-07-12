extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		print("moving right")
		
	if Input.is_action_pressed("move_left"):
		print("moving left")

func _input(event):
	if event.is_action_pressed("shoot"):
		print("shoot")
	if event.is_action_pressed("ui_cancel"):
		print("Quitting...")
		get_tree().quit()
