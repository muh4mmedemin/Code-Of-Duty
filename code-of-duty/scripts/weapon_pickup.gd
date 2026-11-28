extends Node3D

@export var weapon_model: PackedScene
@export var weapon_pick_model: PackedScene

# Mask ayarları yapılnca oyuncuya çarpmayacak

var total_ammo = -1
var magazine_ammo = -1
var auto_mode = false

func _ready() -> void:
	var model_holder = $RigidBody3D/model_holder
	var weapon = weapon_pick_model.instantiate()
	model_holder.add_child(weapon)
