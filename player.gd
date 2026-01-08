extends CharacterBody3D
@export var sensitivity = 75
#MOVE THE CAMERA AROUND WITH THE MOUSE
#MOVE THE PLAYER WITH THE KEYBOARD
#constrain the mouse
#we need to jump
#capture the mouse

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#rotate player
		rotation_degrees.y -= event.screen_relative.x * (sensitivity * .01)
		#rotate up and down
		$Camera3D.rotation_degrees.x -= event.screen_relative.y * (sensitivity * .01)
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x, -85, 85)


func _physics_process(delta: float) -> void:
	const SPEED = 5.5 #meters per second
	#walk
	var input_direction_2D = Input.get_vector("Move Left","Move Right","Move Forward","Move Backward")
	#make 2D vector into 3D vector
	var input_direction_3D = Vector3(input_direction_2D.x, 0, input_direction_2D.y)
	
	var direction = transform.basis * input_direction_3D
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	#jumping
	#gravity
	#y direction
	move_and_slide()
