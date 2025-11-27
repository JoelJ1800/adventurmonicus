extends Label

func ready():
	$"../../..".UpdatedGold.connect(_on_updated_gold)

func _on_updated_gold (gold : int):
	text = str(gold)
