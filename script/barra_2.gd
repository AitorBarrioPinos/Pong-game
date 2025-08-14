extends CharacterBody2D


var speed = Global.speed_player
var fixed_x_position
@onready var pelota: CharacterBody2D = $"../Pelota"
@onready var main_menu: Control = $"../MainMenu"
var dificultad = Global.CPU_dificulty



func _ready():
	fixed_x_position = global_position.x


func _physics_process(delta: float) -> void:
	if Global.modo == Global.PlayerMode.HUMAN:
		human_player(delta)
	else:
		CPU_player(delta)
	
func human_player(delta):
	position.x = clamp(position.x, fixed_x_position, fixed_x_position)
	var direction := Input.get_axis("player_2_UP", "player_2_DOWN")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
	move_and_slide()

func CPU_player(delta):
	# moverse por interpolacion. La condicion hace que solo se mueva si la pelota va hacia la pala
	var direccion_y
	position.x = clamp(position.x, fixed_x_position, fixed_x_position)
	
	if pelota.velocity.x > 0:
		direccion_y = lerp(global_position.y,pelota.global_position.y,0.6)
	else:
		direccion_y = lerp(global_position.y,get_viewport_rect().size.y/2,0.05)
		
	velocity.y = (direccion_y - global_position.y) * dificultad 
	
	move_and_slide()
	
