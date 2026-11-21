extends CharacterBody3D

@onready var player: CharacterBody3D = $"."
@onready var camera: Camera3D = $Head/Camera3D
@onready var player_head: Node3D = $Head
@onready var player_coll: CollisionShape3D = $CollisionShape3D
@onready var player_coll_mesh: MeshInstance3D = $CollisionShape3D/MeshInstance3D
@onready var crouch_checker_shape = ShapeCast3D.new()
@onready var aim_ray = $Head/Camera3D/AimRay
@onready var arms = $Head/Camera3D/WeaponHolder/Arms

@onready var player_current_weapon: Node3D

enum State {WALK, RUN, CROUCH, JUMP}
var player_status = State.WALK

const PLAYER_NORMAL_HEIGHT = 3.0
const PLAYER_CROUCH_HEIGHT = 2.0
const WALK_SPEED = 5.0
const CROUCH_SPEED = 2.5
const RUN_SPEED = 7.0

var player_speed = WALK_SPEED

const JUMP_VELOCITY = 4.5
@export var Sensivity: float = 0.1

func _ready() -> void:
	#$Head/Camera3D/WeaponHolder/Arms/Ak47.position = Vector3(0.3, -0.3, -0.6)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_coll.position.y = PLAYER_NORMAL_HEIGHT / 2.0
	
	player_head.position = Vector3(0.0, PLAYER_NORMAL_HEIGHT - 0.5, 0.0)
	var sphere = SphereShape3D.new()
	sphere.radius = 0.40
	
	crouch_checker_shape.shape = sphere
	crouch_checker_shape.enabled
	crouch_checker_shape.position.y = PLAYER_NORMAL_HEIGHT - sphere.radius
	crouch_checker_shape.target_position = Vector3.ZERO
	crouch_checker_shape.add_exception(self)
	add_child(crouch_checker_shape)
	
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
	handle_player_movement_state(delta)
	if Input.is_action_just_pressed("weapon_fire") and arms.get_child_count() >= 1:
		#$Head/Camera3D/WeaponHolder/Arms/Ak47.aim_ray = aim_ray
		#$Head/Camera3D/WeaponHolder/Arms/Ak47.fire()
		#var scene = preload("res://scenes/ak_47.tscn")
		#var ins = scene.instantiate()
		#ins.position = Vector3(0.3, -0.3, -0.6)
		#$Head/Camera3D/WeaponHolder/Arms.add_child(ins)
		#print("sa")
		player_current_weapon.fire()
	if Input.is_action_just_pressed("take_item") and arms.get_child_count() == 0 and aim_ray.is_colliding():
		var target = aim_ray.get_collider()
		var parent = target.get_parent()
		if parent.is_in_group("pickup"):
			print(parent.weapon_model)
			var weapon = parent.weapon_model
			var weapon_scene = weapon.instantiate()
			arms.add_child(weapon_scene)
			player_current_weapon = weapon_scene
			player_current_weapon.aim_ray = aim_ray
		else:
			print("grupta değilmi")
		
	#print(player_speed)
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
func handle_player_movement_state(delta):
	var was_player_status = player_status
	if crouch_checker_shape.is_colliding() == true:
		return
	 
	if State.CROUCH == player_status and PLAYER_CROUCH_HEIGHT != player_coll.shape.height:
		handle_player_height(PLAYER_CROUCH_HEIGHT, delta)
	elif State.CROUCH != player_status and PLAYER_NORMAL_HEIGHT != player_coll.shape.height:
		handle_player_height(PLAYER_NORMAL_HEIGHT, delta)
		
	if Input.is_action_pressed("player_crouch") and player_status != State.RUN:
		if player_status != State.CROUCH:
			handle_player_height(PLAYER_CROUCH_HEIGHT, delta)
			handle_player_speed(State.CROUCH)
			player_status = State.CROUCH
	elif Input.is_action_pressed("player_sprint") and player_status != State.CROUCH:
		if player_status != State.RUN:
			player_status = State.RUN
			handle_player_speed(State.RUN)
	elif player_status != State.WALK:
		player_status = State.WALK
		handle_player_speed(State.WALK)

	if was_player_status == player_status:
		return
	elif was_player_status == State.CROUCH:
		handle_player_height(PLAYER_NORMAL_HEIGHT, delta)

func handle_player_height(new_height, delta):
	player_coll_mesh.mesh.height = lerp(player_coll_mesh.mesh.height, new_height, 10.0 * delta)
	player_coll.shape.height = lerp(player_coll.shape.height, new_height, 10.0 * delta)
	player_coll.position.y = lerp(player_coll.position.y, new_height / 2.0, 10.0 * delta)
	player_head.position.y = lerp(player_head.position.y, new_height - 0.5, 10.0 * delta)
	

func handle_player_speed(player_state):
	if State.CROUCH == player_state:
		player_speed = CROUCH_SPEED
	elif State.RUN == player_state:
		player_speed = RUN_SPEED
	elif State.WALK == player_state:
		player_speed = WALK_SPEED
#endregion
