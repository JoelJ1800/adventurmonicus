class_name StatPanelItem
extends Panel

@onready var icon_texture: TextureRect = $StatIcon
@onready var name_label: RichTextLabel = $StatText

@export_enum(
	"DMG",
	"DEF",
	"SPEED",
	"SP.DMG",
	"SP.DEF"
)
var stat_name: String = "DMG":
	set(value):
		stat_name = value
		update_stat_ui()

func _ready():
	call_deferred("update_stat_ui")

func update_stat_ui():
	if not GameManager.STATS.has(stat_name):
		return
	if name_label == null:
		return

	var stat_data = GameManager.STATS[stat_name]

	# Tooltip
	name_label.tooltip_text = stat_data.tooltip

	# Icon
	if stat_data.icon != "":
		icon_texture.texture = load(stat_data.icon)

	# Auto-fit text
	_set_fitting_text(stat_name + " :     ")

# ------------------------------
# Auto-resize helper
# ------------------------------
func _set_fitting_text(text: String, max_size := 20, min_size := 12):
	name_label.clear()
	name_label.bbcode_enabled = true
	name_label.autowrap_mode = TextServer.AUTOWRAP_OFF

	for font_size in range(max_size, min_size - 1, -1):
		name_label.clear()
		name_label.append_text("[font_size=%d]%s[/font_size]" % [font_size, text])

		if name_label.get_content_width() <= name_label.size.x:
			return
