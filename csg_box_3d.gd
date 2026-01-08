extends CSGBox3D

var spin = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y+= .03
	spin += 1
	position.y= 10*sin(0.05*spin)+60
