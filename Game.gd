extends Node2D

var current_path: PackedVector2Array
var astar = AStar2D.new()

func _ready():
	# Set cell size to 16
	var cell_size = 16
	for x in range(0, 100):
		for y in range(0, 100):
			var curr_point = $Map.get_cell_atlas_coords(0, Vector2i(x, y), false)
			if (curr_point == Vector2i(3, 17)):
				astar.add_point(x + y * 100, Vector2(x, y), 1.0)
				print("x: " + str(x) + ", y: " + str(y))

	for x in range(0, 100):
		for y in range(0, 100):
			if x < 99: astar.connect_points(x + y * 100, x + 1 + y * 100, true)
			if y < 99: astar.connect_points(x + y * 100, x + (y + 1) * 100, true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("spacebar"):
		var monster_point = astar.get_closest_point($Monster.position / 16, false)
		var player_point = astar.get_closest_point($Player.position / 16, false)
		var path = astar.get_id_path(monster_point, player_point)
		$Monster.chase(path)
		print($Player.position)
		print(monster_point)
		print(player_point)
		print(path)
