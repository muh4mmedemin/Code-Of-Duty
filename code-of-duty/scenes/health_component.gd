class_name HealthComponent
extends Node3D

@export var health: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_dead() -> bool:
	if health <= 0:
		return true
	else:
		return false
	
func take_damage(damage: int) -> void:
	health -= damage
	if is_dead():
		get_parent().queue_free()
	print(health)
