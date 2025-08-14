extends Node
@onready var main_menu: Control = $"../MainMenu"
@onready var score_p_1: Label = $ScoreP1
@onready var score_p_2: Label = $ScoreP2
@onready var winner: Label = $Winner
@onready var new_game: Timer = $new_game
@onready var win_russia: Sprite2D = $Win_russia
@onready var russia_anthem: AudioStreamPlayer = $Russia_anthem
@onready var pelota: CharacterBody2D = $"../Pelota"
@onready var timer_win_russia: Timer = $Timer_win_russia
@onready var timer_win_eeuu: Timer = $Timer_win_EEUU
@onready var eeuu_anthem: AudioStreamPlayer = $EEUU_anthem
@onready var win_eeuu: Sprite2D = $Win_EEUU


enum PlayerMode {HUMAN, CPU}
var modo :PlayerMode

var score_P2 = 0
var score_P1 = 0

func add_point_P2():
	score_P2 += 1
	score_p_2.text = str(score_P2)
	if(score_P2 == 5):
		winner.text = 'WINNER \n PLAYER 2'
		Engine.time_scale = 0.5
		timer_win_eeuu.start()
	

func add_point_P1():
	score_P1 += 1
	score_p_1.text = str(score_P1)
	if(score_P1 == 5):
		winner.text = 'WINNER \n PLAYER 1'
		Engine.time_scale = 0.5
		timer_win_russia.start()


func _process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("game_menu"):
		if main_menu.visible:
			main_menu.visible = false
			get_tree().paused = false
		else:
			get_tree().paused = true
			main_menu.get_node("VBoxMenu/Resume").visible = true
			main_menu.get_node("VBoxMenu/Options").visible = false
			main_menu.get_node("VBoxMenu/Back_Menu").visible = true
			main_menu.visible = true


func _on_new_game_timeout() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_timer_win_eeuu_timeout() -> void:
	win_eeuu.visible = true
	winner.visible = true
	eeuu_anthem.play()
	#pelota.queue_free()
	pelota.set_physics_process(false)
	pelota.visible = false
	new_game.start(80)


func _on_timer_win_russia_timeout() -> void:
	win_russia.visible = true
	winner.visible = true
	russia_anthem.play(3.0)
	#pelota.queue_free()
	pelota.set_physics_process(false)
	pelota.visible = false
	new_game.start(213)
