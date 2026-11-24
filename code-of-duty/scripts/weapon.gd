extends Node

const BULLET_HOLE = preload("res://scenes/bullet_hole.tscn")

@export var data: WeaponData
@export var aim_ray: RayCast3D

@onready var w_magazine_capacity = data.magazine_size
@onready var w_total_ammo = data.total_ammo
@onready var w_magazine_ammo = data.magazine_size
@onready var w_fire_rate = data.fire_rate
var w_cool_down = 0.0
var w_reload_timer 

func _ready() -> void:
	w_reload_timer = $ReloadTimer
	w_reload_timer.wait_time = data.reload_time

func _physics_process(delta: float) -> void:
	w_cool_down = move_toward(w_cool_down, 0.0, 5.0 * delta)
	print(w_magazine_ammo, "\\", w_total_ammo)

func fire():
	if w_magazine_ammo > 0 and w_cool_down <= 0.0 and is_reloading():
		w_magazine_ammo += -1
		print(w_magazine_ammo, "\\", w_total_ammo)
		print("ATEŞ EDİLDİ")
		apply_hit()
		w_cool_down = w_fire_rate

func apply_hit():
	if aim_ray.is_colliding():
		var target = aim_ray.get_collider()
		var coll_point = aim_ray.get_collision_point()
		var hole = BULLET_HOLE.instantiate()
		target.add_child(hole)
		hole.global_position = coll_point
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
	
func is_reloading() -> bool:
	return w_reload_timer.is_stopped()
