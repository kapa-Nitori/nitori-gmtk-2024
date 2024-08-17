extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 100
const MAX_PUSH_VELOCITY = 150

@onready var mallet = $Mallet
@onready var animation_player = $AnimationPlayer



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	report_to_global()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	mallet_utils()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_box = collision.get_collider()
		#print()
		#print(collision_box) 
		#collision_box.is_in_group("Boxes") 
		if Global.boxes_array.has(collision_box) and abs(collision_box.get_linear_velocity().x) < MAX_PUSH_VELOCITY:
			collision_box.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)

			
			
		

func jump():
	velocity.y += JUMP_VELOCITY

func mallet_utils():
	var direction = get_global_mouse_position()
	mallet.look_at(direction)
	
	if Input.is_action_just_pressed("mallet_use"):
		animation_player.play("mallet_attack")

func report_to_global(): # call this in process, updates global variables.
	Global.player_speed = velocity
	Global.player_direction = velocity.normalized()
	
	
	
