extends Camera2D

@export var target: Character
var shake_intensity: float = 0


func _ready():
	GameManager.scene_changed.connect(set_camera_limit)
	
	if GameManager.camera and GameManager.camera != self:
		queue_free()
		return

			
	
	GameManager.camera = self
	reparent.call_deferred(get_tree().root)
	
	global_position = target.global_position
	target.OnTakeDamage.connect(_on_take_damage)


func _physics_process(delta):
	global_position = global_position.lerp(target.global_position, delta * 10)


func _on_take_damage(_hit_force: Vector2):
	shake_intensity = 2

func set_camera_limit(scene_path):
	scene_path = str(scene_path)
	print(scene_path)
	if "Overworld" in scene_path :
		limit_enabled = true
		limit_left = 0
		limit_top = 0
		limit_right = 1720
		limit_bottom = 1000
	elif "Blacksmith" in scene_path :
		limit_enabled = true
		limit_left = 0
		limit_top = 0
		limit_right = 230
		limit_bottom = 65
	elif "DungeonTeleport" in scene_path :
		limit_enabled = false


func _process(delta):
	if shake_intensity > 0:
		shake_intensity = lerpf(shake_intensity, 0, delta * 10)
		offset = _get_random_offset()


func _get_random_offset() -> Vector2:
	var x : float = randf_range(-shake_intensity, shake_intensity)
	var y : float = randf_range(-shake_intensity, shake_intensity)
	return Vector2(x, y)
