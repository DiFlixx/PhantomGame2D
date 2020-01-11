extends KinematicBody2D


# This demo shows how to build a kinematic controller.

# Member variables
var GRAVITY = 150.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
var WALK_FORCE = 600
var WALK_MIN_SPEED = 10
var WALK_MAX_SPEED = 300
const STOP_FORCE = 1300
const JUMP_SPEED = 200
const JUMP_MAX_AIRBORNE_TIME = 0.2

var SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false
var stop = true
var prev_jump_pressed = false
var anim = ""
var www = 0

func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)
	
	var FiDe = Input.is_action_pressed("i_button")
	var Slowem = Input.is_action_pressed("r_button")
	var MR = Input.is_action_just_pressed("mouse_right")
	var Slow = Input.is_action_pressed("ctrl")
	var Sprint = Input.is_action_pressed("shift")
	var ML = Input.is_action_just_pressed("e_button")
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_pressed("ui_up")
	var Tonna = Input.is_action_pressed("z_button")
	stop = true
	if(Sprint==true):
		WALK_MAX_SPEED = 500
		WALK_FORCE = 1000
	elif(Slow==true):
		WALK_MAX_SPEED = 100
		WALK_FORCE = 300
	elif(Slowem==true):
		GRAVITY = -150.0
	elif(Tonna==true):
		GRAVITY = 15000.0
	elif(FiDe==true):
		GRAVITY = 20
	else:
		WALK_MAX_SPEED = 300
		WALK_FORCE = 600
		GRAVITY = 150.0
	var new_anim = "Idle"
	if(MR):
		var colliding = raycast (self.position,get_global_mouse_position() )
		if colliding:
			var cell = $"../TileMap".world_to_map(colliding.position - colliding.normal)
			$"../TileMap".set_cell(cell.x, cell.y, -1)
	if(ML):
		var colliding = raycast (self.position,get_global_mouse_position())
		if colliding:
			var cell = $"../TileMap".world_to_map(colliding.position + colliding.normal)
			$"../TileMap".set_cell(cell.x, cell.y, www)
	if walk_left:
		if  velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
			$Sprite.scale.x = -0.1
			new_anim = "Walk"
	if walk_right:
		if velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false
			$Sprite.scale.x = 0.1
			new_anim = "Walk"
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	# Integrate forces to velocity
	velocity += force * delta
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false
	
	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true
	
	on_air_time += delta
	prev_jump_pressed = jump
	
	if new_anim != anim:
		anim = new_anim
		$AnimationPlayer.play(anim)
func raycast(from, to):
	var space_state = get_world_2d().direct_space_state
	return space_state.intersect_ray(from, to, [self])

func _on_Button_pressed():
	www = 1
	pass # Replace with function body.


func _on_Button2_pressed():
	www = 2
	pass # Replace with function body.
	
func _on_Button3_pressed():
	www = 3
	pass # Replace with function body.


func _on_Button4_pressed():
	www = 4
	pass # Replace with function body.


func _on_Button5_pressed():
	www = 5
	pass # Replace with function body.


func _on_Button6_pressed():
	www = 6
	pass # Replace with function body.


func _on_Button7_pressed():
	www = 0
	pass # Replace with function body.
