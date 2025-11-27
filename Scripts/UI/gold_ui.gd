extends Label

func ready():
	pass

func _on_updated_gold (gold : int):
	text = str(gold)
