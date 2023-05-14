extends CharacterBody2D

var action
var direction

@export var speed = 80 # How fast the player will move (pixels/sec).

# Called when the node enters the scene tree for the first time.
func _ready():
	action = "walk"
	direction = "down"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = 0
	velocity.y = 0 # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

	if velocity.y == 0 && (velocity.x != 0):
		if velocity.x > 0:
			direction = "right"
		else:
			direction = "left"

	if velocity.x == 0 && (velocity.y != 0):
		if velocity.y > 0:
			direction = "down"
		else:
			direction = "up"

	var direction_name = direction
	if direction == "left":
		direction_name = "side"
		$Sprite.flip_h = true
	elif direction == "right":
		direction_name = "side"
		$Sprite.flip_h = false
	$Sprite.animation = action + "_" + direction_name
	$Sprite.play()
	
	
	move_and_slide()
