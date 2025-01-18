extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@onready var player_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_collision: CollisionShape2D = $CollisionShape2D
var jump=false



func _physics_process(delta: float) -> void:
	if is_on_floor():
		jump=false
		if velocity.x<0 or velocity.x>0:
			player_animation.play("run")
		else:
			player_animation.play("idle")
	# Add the gravity.
	if not is_on_floor():
		if jump==false:
			player_animation.play("fall")
		velocity += get_gravity() * delta
	
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump=true
		player_animation.play("jump")
		velocity.y = JUMP_VELOCITY
	if velocity.y == -500.0:
		player_animation.play("fall")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction<0:
			player_animation.flip_h=true
			player_collision.position.x=25
		else :
			player_animation.flip_h=false
			player_collision.position.x=4.5
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
