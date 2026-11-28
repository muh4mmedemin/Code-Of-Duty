extends Node

const BULLET_HOLE = preload("res://scenes/bullet_hole.tscn")

@export var data: WeaponData
@export var aim_ray: RayCast3D

@onready var w_magazine_capacity = data.magazine_size
@onready var w_total_ammo = data.total_ammo
@onready var w_magazine_ammo = data.magazine_size
@onready var w_fire_rate = data.fire_rate
@onready var w_damage = data.damage
@onready var w_auto_mode = data.auto_mod

@onready var max_spread = 4.0
@onready var spread_per_shot = 0.4
@onready var spread_recovery = 2.0
var current_spread = 0.0

var w_cool_down = 0.0
var w_reload_timer 

func _ready() -> void:
	w_reload_timer = $ReloadTimer
	w_reload_timer.wait_time = data.reload_time

func _physics_process(delta: float) -> void:
	w_cool_down = move_toward(w_cool_down, 0.0, 1.5 * delta)
	if current_spread != 0.0:
		current_spread = move_toward(current_spread, 0.0, spread_recovery * delta)
	elif aim_ray.rotation_degrees != Vector3(0.0, 0.0, 0.0):
		aim_ray.rotation_degrees = Vector3(0.0, 0.0, 0.0)
		
func fire():
	if w_magazine_ammo > 0 and w_cool_down <= 0.0 and is_reloading():
		w_magazine_ammo += -1
		print(w_magazine_ammo, "\\", w_total_ammo)
		print("ATEŞ EDİLDİ")
		aim_ray.rotation_degrees = make_spread()
		apply_hit()
		w_cool_down = w_fire_rate
		current_spread = min(current_spread + spread_per_shot, max_spread)

func apply_hit():
	if aim_ray.is_colliding():
		var target = aim_ray.get_collider()
		var coll_point = aim_ray.get_collision_point()
		var hole = BULLET_HOLE.instantiate()
		target.add_child(hole)
		hole.global_position = coll_point
		for child in target.get_children():
			if child is HealthComponent:
				child.take_damage(w_damage)
		print(target.name)


func reload():
	if is_reloading() and w_total_ammo > 0:
		print("RELOAD")
		var used_ammo
		w_reload_timer.start()
		used_ammo = w_magazine_capacity - w_magazine_ammo
		if used_ammo > w_total_ammo:
			w_magazine_ammo += w_total_ammo
			w_total_ammo = 0
		else:
			w_total_ammo -= used_ammo
			w_magazine_ammo += used_ammo

func change_fire_mode():
	if w_auto_mode == false:
		w_auto_mode = true
	else:
		w_auto_mode = false

func make_spread() -> Vector3:
	var spread_rate: Vector3
	spread_rate = Vector3(randf_range(-current_spread, current_spread), randf_range(-current_spread, current_spread), 0.0)
	return spread_rate

func is_reloading() -> bool:
	return w_reload_timer.is_stopped()
