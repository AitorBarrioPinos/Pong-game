extends CharacterBody2D
@onready var game_manager: Node = %GameManager
@onready var goal: Area2D = $"../Goal"

var lado = 0
var speed = 400.0
var direction = Vector2.ZERO
@onready var timer: Timer = $Timer
@onready var paddle_hit: AudioStreamPlayer2D = $Paddle_hit
@onready var wall_hit: AudioStreamPlayer2D = $Wall_hit
@onready var goal_hit: AudioStreamPlayer2D = $"../Goal_hit"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_ball(lado)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = direction * speed
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		direction = direction.bounce(collision_info.get_normal())
		if collision_info.get_collider().name in ["Barra 1", "Barra 2"]:
			speed += 50
			paddle_hit.play()
			direction = direction.rotated(randf_range(-0.10 * PI, 0.10 * PI)) 
		elif collision_info.get_collider().name in ["Techo", "Fondo"]:
			wall_hit.play()

func reset_ball(lado):
	global_position = get_viewport_rect().size / 2
	
	var horizontal
	if (lado == 1):
		horizontal = -1
	elif (lado == 2):
		horizontal = 1
	else:
		if randf() > 0.5:
			horizontal = 1
		else:
			horizontal = -1
	
	var angle = randf_range(-0.25 * PI, 0.25 * PI)
	
	direction = Vector2(horizontal, tan(angle)).normalized()


func _on_goal_body_entered(body: Node2D) -> void:
	if body.name == "Pelota":
		game_manager.add_point_P2()
		goal.get_node("Flash1").global_position = body.global_position
		goal.get_node("Flash1").play()
		goal_hit.play()
		
		lado = 1
		timer.start()
		wall_hit.volume_db = -100
		

func _on_timer_timeout() -> void:
	reset_ball(lado)
	speed = 400
	wall_hit.volume_db = 0.0


func _on_goal_2_body_entered(body: Node2D) -> void:
	if body.name == "Pelota":
		game_manager.add_point_P1()
		goal.get_node("Flash2").global_position = body.global_position
		goal.get_node("Flash2").play()
		goal_hit.play()
		
		lado = 2
		timer.start()
		wall_hit.volume_db = -100
