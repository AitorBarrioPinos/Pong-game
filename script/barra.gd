extends CharacterBody2D


var speed = Global.speed_player
var fixed_x_position

func _ready():
	fixed_x_position = global_position.x



func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	position.x = clamp(position.x, fixed_x_position, fixed_x_position)
	var direction := Input.get_axis("player_1_UP", "player_1_DOWN")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
