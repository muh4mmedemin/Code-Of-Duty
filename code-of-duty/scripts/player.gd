extends CharacterBody3D

@onready var player: CharacterBody3D = $"."
@onready var camera: Camera3D = $Camera3D

var player_speed = WALK_SPEED
const WALK_SPEED = 5.0
const CROUCH_SPEED = 2.5
const RUN_SPEED = 7.0


const JUMP_VELOCITY = 4.5
@export var Sensivity: float = 0.1

enum state {WALK, RUN, CROUCH, JUMP}
var player_status = state.WALK


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CollisionShape3D.position.y = 3.0 / 2.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * player_speed
		velocity.z = direction.z * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.z = move_toward(velocity.z, 0, player_speed)

	move_and_slide()
	handle_player_movement_state()
	print(player_speed)
	
func _input(event):
	if event is InputEventMouseMotion:
		handle_camera_look(event)
		
# Bu fonksiyon oyuncunun kamerasını mouse ile yönlendirmesine yarıyor.
func handle_camera_look(event):
	var camera_rotation_deg
	camera_rotation_deg = camera.rotation_degrees.x - (event.relative.y * Sensivity)
	if camera_rotation_deg <= 80 and camera_rotation_deg >= -80:
		camera.rotation_degrees.x = camera_rotation_deg
	player.rotation_degrees.y -= event.relative.x * Sensivity

#region PLAYER_MOVEMENT_STATE
func handle_player_movement_state():
	var was_player_status = player_status
	if Input.is_action_pressed("player_crouch") and player_status != state.RUN:
		if player_status != state.CROUCH:
			$CollisionShape3D/MeshInstance3D.mesh.height = 2.0
			$CollisionShape3D.shape.height = 2.0
			$CollisionShape3D.position.y = 2.0 / 2.0
			player_status = state.CROUCH
			handle_player_speed(state.CROUCH)
	elif Input.is_action_pressed("player_sprint") and player_status != state.CROUCH:
		if player_status != state.RUN:
			player_status = state.RUN
			handle_player_speed(state.RUN)
	elif player_status != state.WALK:
		player_status = state.WALK
		handle_player_speed(state.WALK)

	if was_player_status == player_status:
		return
	elif was_player_status == state.CROUCH:
		$CollisionShape3D/MeshInstance3D.mesh.height = 3.0
		$CollisionShape3D.shape.height = 3.0
		$CollisionShape3D.position.y = 3.0 / 2.0

func handle_player_speed(player_state):
	if state.CROUCH == player_state:
		player_speed = CROUCH_SPEED
	elif state.RUN == player_state:
		player_speed = RUN_SPEED
	elif state.WALK == player_state:
		player_speed = WALK_SPEED
#endregion
