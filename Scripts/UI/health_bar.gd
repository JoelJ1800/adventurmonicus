extends Panel

@onready var character: Character = $".."
@onready var fill: Control = $Fill
@onready var max_width: float = fill.size.x


func _ready():
	self.visible = false
	character.OnHealthChange.connect(_update_ui)
	call_deferred('_update_ui')


func _update_ui():
	var health_percent: float = float(character.cur_hp) / float(character.max_hp)
	fill.size.x = max_width * health_percent
	self.visible = true
	await get_tree().create_timer(2).timeout
	self.visible = false
