extends Node

const BULLET_HOLE = preload("res://scenes/bullet_hole.tscn")

@export var data: WeaponData
@export var aim_ray: RayCast3D

func fire():
	print("ATEŞ EDİLDİ")
	print(data.fire_rate)
	print(data.weapon_name)
	print(data.magazine_size)
	print(data.damage)
	apply_hit()

func apply_hit():
	if aim_ray.is_colliding():
		var target = aim_ray.get_collider()
		var coll_point = aim_ray.get_collision_point()
		var hole = BULLET_HOLE.instantiate()
		target.add_child(hole)
		hole.global_position = coll_point
		print(target.name)
