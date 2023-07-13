extends CharacterBody2D

var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_dir = 0
	if Input.is_action_pressed("move_right"):
		input_dir = 1	
	elif Input.is_action_pressed("move_left"):
		input_dir = -1
	else :
		input_dir = 0
		
	velocity = Vector2(input_dir, 0) * speed

func _physics_process(delta):
	move_and_slide()

func _input(event):
	if event.is_action_pressed("shoot"):
		print("shoot")
	if event.is_action_pressed("ui_cancel"):
		print("Quitting...")
		get_tree().quit()