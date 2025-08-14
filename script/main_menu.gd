extends Control
@onready var main_menu: Control = $"."
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var opciones_menu: Control = $opciones_menu
@onready var v_box_menu: VBoxContainer = $VBoxMenu



func _ready() -> void:
	opciones_menu.get_node("Volver").pressed.connect(_on_button_back_pressed)

func _on_play_pressed() -> void:
	Engine.time_scale = 1
	v_box_menu.visible = false
	h_box_container.visible = true

func _on_button_back_pressed():
	opciones_menu.visible = false
	v_box_menu.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	main_menu.visible = false
	get_tree().paused = false


func _on_player1_pressed() -> void:
	Global.modo = Global.PlayerMode.CPU
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/game.tscn")


func _on_player2_pressed() -> void:
	Global.modo = Global.PlayerMode.HUMAN
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/game.tscn")


func _on_options_pressed() -> void:
	v_box_menu.visible = false
	opciones_menu.visible = true
	

func _on_back_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
