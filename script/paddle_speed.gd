extends ItemList





func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index == 0:
		Global.speed_player = 500.0
	elif index == 1:
		Global.speed_player = 900.0
	elif index == 2:
		Global.speed_player = 1500.0
