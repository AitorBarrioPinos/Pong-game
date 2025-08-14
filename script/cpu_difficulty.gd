extends ItemList


func _on_item_selected(index: int) -> void:
	if index == 0:
		Global.CPU_dificulty = 4
	elif index == 1:
		Global.CPU_dificulty = 8
	elif index == 2:
		Global.CPU_dificulty = 12
	elif index == 3:
		Global.CPU_dificulty = 16
	elif index == 4:
		Global.CPU_dificulty = 20
	elif index == 5:
		Global.CPU_dificulty = 24
