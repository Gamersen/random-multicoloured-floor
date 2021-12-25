extends SpatialMaterial

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	set_albedo(Color(rng.randf_range(0, 1),rng.randf_range(0, 1),rng.randf_range(0, 1),1))
