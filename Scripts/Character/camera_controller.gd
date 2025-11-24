extends Camera2D

@export var target: Character
var shake_intensity: float = 0


func _ready():
	global_position = target.global_position
	target.OnTakeDamage.connect(_on_take_damage)


func _physics_process(delta):
	global_position = global_position.lerp(target.global_position, delta * 10)


func _on_take_damage(hit_force: Vector2):
	shake_intensity = 2


func _process(delta):
	if shake_intensity > 0:
		shake_intensity = lerpf(shake_intensity, 0, delta * 10)
		offset = _get_random_offset()


func _get_random_offset() -> Vector2:
	var x : float = randf_range(-shake_intensity, shake_intensity)
	var y : float = randf_range(-shake_intensity, shake_intensity)
	return Vector2(x, y)
