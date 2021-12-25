extends Spatial

var rng = RandomNumberGenerator.new()
var mapSize = Vector3(64,0,64) #Size of the level

func _ready():
	rng.randomize()
	for x in mapSize.x:
		for z in mapSize.z:
			var gridItem = rng.randi_range(0,7)
			get_node("GridMap").set_cell_item(x,0,z,gridItem)
	
	global.spawn(preload("res://Scenes/player.tscn"))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
