extends CharacterBody3D
@export var sensitivity = 75
#MOVE THE CAMERA AROUND WITH THE MOUSE
#MOVE THE PLAYER WITH THE KEYBOARD
#constrain the mouse
#we need to jump
#capture the mouse
@export var gravity:float = 250
@onready var animationPlayer = $AnimationPlayer
var jumps:int = 0
var max_jumps = 1

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)





func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#rotate player
		rotation_degrees.y -= event.screen_relative.x * (sensitivity * .01)
		#rotate up and down
		$Camera3D.rotation_degrees.x -= event.screen_relative.y * (sensitivity * .01)
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x, -85, 85)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("fullscreen"):
		var fs = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		if fs:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _physics_process(delta: float) -> void:
	const SPEED = 5.5 #meters per second
	#walk
	var input_direction_2D = Input.get_vector("Move Left","Move Right","Move Forward","Move Backward")
	#make 2D vector into 3D vector
	var input_direction_3D = Vector3(input_direction_2D.x, 0, input_direction_2D.y)
	
	var direction = transform.basis * input_direction_3D
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	### jumping ###
	#gravity
	velocity.y -= gravity *delta
	if Input.is_action_just_pressed("Jump") and jumps < max_jumps:#is_on_floor():
		velocity.y =10
		jumps += 1
	elif Input.is_action_just_released("Jump") and velocity.y > 0:
		velocity.y = velocity.y / 2.5
	
	
	if is_on_floor():
		jumps = 0
	#y direction
	move_and_slide()
	
	if Input.is_action_pressed("Shoot") and %BulletTimer.is_stopped():
		shoot_bullet()
		%BulletTimer.start()
		
	
	
	
func shoot_bullet():
	const BULLET_3D = preload("res://projectile.tscn")
	var new_bullet = BULLET_3D.instantiate()
	%ProjectileSpawn.add_child(new_bullet)
	new_bullet.transform = %ProjectileSpawn.global_transform
	animationPlayer.play("Recoil")
	#%"Muzzle Light".visible = true
	#await get_tree().create_timer(0.1).timeout
	#%"Muzzle Light".visible = false
