extends CSGBox3D
var starting_position = Vector3(position.x,position.y,position.z)
var spin = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y+= .03
	spin += 1
	position.x = starting_position.x
	position.y = starting_position.y + sin(spin*0.1)/2
	position.z = starting_position.z
