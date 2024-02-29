extends Area2D

signal moved

@export var enemy_scene: PackedScene
@export var gap_size: int = 16
@export var move_size: int = 8
@export var width = 8
@export var height = 1

@onready var timer = get_node("Timer")
@onready var shape2d = get_node("CollisionShape2D")

var needs_move_down = false
var is_moving_right = true

var enemy_count = 0

var initialpos = Vector2()

func _ready():
	initialpos = position
	setup()


func _process(delta):
	pass

func move():
	if needs_move_down:
		position = Vector2(position.x, position.y + gap_size)
		needs_move_down = false
		return
	if is_moving_right:
		position = position + Vector2(move_size, 0)
	else:
		position = position - Vector2(move_size, 0)
	moved.emit()

func setup():
	position = initialpos
	enemy_count = width * height
	populate_enemies(width, height)
	resize_collision_shape(width, height)

func resize_collision_shape(w, h):
	shape2d.shape.size = Vector2(w * gap_size, h * gap_size)
	shape2d.position = Vector2((w * gap_size)/2, 0)

func populate_enemies(w, h):
	var nextpos = Vector2(0,0)
	for y in range(h):
		if y > 0:
			nextpos = Vector2(0, nextpos.y + gap_size)
		for x in range(w):
			var newEnemy = enemy_scene.instantiate()
			add_child(newEnemy)
			newEnemy.gridpos = Vector2(x,y)
			newEnemy.connect("died", _on_enemy_died)
			newEnemy.connect("touched_side", _on_enemy_touched_side)
			newEnemy.position = nextpos
			nextpos = Vector2(nextpos.x + gap_size, nextpos.y)
			

func next_level():
	width = randi_range(3,12)
	height = randi_range(1,4)
	setup()

func _on_enemy_died(gridpos):
	print("enemy died at {}", gridpos)
	enemy_count -= 1
	if enemy_count <= 0:
		next_level()

func _on_timer_timeout():
	move()
	for enemy in get_children():
		if enemy is Enemy:
			for child in enemy.get_children():
				if child is Sprite2D:
					var sprite = enemy.get_node("Sprite2D")
					if sprite.frame == 0:
						sprite.frame = 1
					else:
						sprite.frame = 0 


func _on_enemy_touched_side():
	print("enemy touched side")
	needs_move_down = true
	is_moving_right = !is_moving_right

