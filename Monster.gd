extends Area2D

var speed = 60
var path = []
var screen_size
var direction = "down"
var wait = 10

func chase(path_astar):
	path = path_astar

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	wait = wait - 1
	var velocity = Vector2.ZERO
	if path.size() > 1:
		var target = convert_to_vector2(path[1])
		var direction = (target - position).normalized()

		# Calculate distance to target
		var distance_to_target = position.distance_to(target)

		# If close enough to target, remove first point from path
		if distance_to_target < speed * delta:
			path = path.slice(1, path.size())
		else:
			# Move towards the target
			var new_velocity = direction * speed
			velocity = new_velocity

		position += velocity * delta
		
	print(velocity)
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			print("right")
			direction = "right"
		else:
			direction = "left"
	elif abs(velocity.x) < abs(velocity.y):
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

	if velocity == Vector2(0,0):
		if wait < 1:
			direction_name = "idle"
	else:
		wait = 10

	$Sprite.animation = direction_name
	$Sprite.play()
		
		
func convert_to_vector2(num):
	var y = (num / 100) * 16
	var x = (num % 100) * 16 + 8
	var vec = Vector2(x, y)
#	print(position)
#	print(vec)
	return vec
