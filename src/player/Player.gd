extends KinematicBody2D


# states
const S_IDLE = 0
const S_MOVE = 1
const S_JUMP = 2
const S_ATTACK_BASIC = 3
const S_ATTACK_SMASH = 4
# actions
const A_NONE = 0
const A_MOVE_R = 1
const A_MOVE_L = 2
const A_JUMP = 3
const A_ATTACK_BASIC = 4
const A_ATTACK_SMASH = 5
# motion
const SPEED = 300
const JUMP_SPEED = 500
const GRAVITY = 1000

# init
var orientation = 1
var state = S_IDLE
var is_on_ground = true
var velocity = Vector2(0, 0)
var _end_animation_flag = false
var _lock_orientation = false

var _jump_counter = 0
var _attack_counter = 0

func _switch_animation(animation):
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
	$AnimatedSprite.animation = animation
	$AnimatedSprite.flip_h = (orientation == -1)
	$AnimatedSprite.play()


func _curr_animation():
	return $AnimatedSprite.animation


func _update_anim_orientation():
	$AnimatedSprite.flip_h = (orientation == -1)


func _animation_finished():
	_end_animation_flag = true


func _get_end_animation_flag():
	if _end_animation_flag:
		_end_animation_flag = false
		return true
	return false


func _switch_state(n_state, action):
	state = n_state
	_fsm_step(action)


func _fsm(actions, delta):
	velocity.x = 0

	if actions.empty():
		actions.append(A_NONE)
	
	for action in actions:
		_fsm_step(action)

	# update animation orientation
	_update_anim_orientation()
	
	# apply gravity
	velocity.y -= GRAVITY * delta


func _fsm_step(action):
	#if _curr_animation() == "fall":
		#print("STATE " + str(state))
		#print(action)
		#print("VELOCITY " + str(velocity))
		#print("GROUND " + str(is_on_ground))
		#print("ANIM " + str(_curr_animation()))
	
	if !_lock_orientation and (action == A_MOVE_R):
		orientation = 1
	if !_lock_orientation and (action == A_MOVE_L):
		orientation = -1

	if state == S_IDLE:
		if action == A_NONE:
			if (velocity.y >= 0) and (_curr_animation() != "idle"):
				_switch_animation("idle")
			
			if (velocity.y < 0) and (_curr_animation() != "fall"):
				_switch_animation("fall")

		if (action == A_MOVE_R) or (action == A_MOVE_L):
			_switch_state(S_MOVE, action)

		if action == A_JUMP:
			_switch_state(S_JUMP, action)

		if action == A_ATTACK_BASIC:
			_switch_state(S_ATTACK_BASIC, action)

		if action == A_ATTACK_SMASH:
			_switch_state(S_ATTACK_SMASH, action)

	elif state == S_MOVE:
		if (action == A_MOVE_R) or (action == A_MOVE_L):
			velocity.x = orientation * SPEED
			
			if is_on_ground and (_curr_animation() != "move"):
				_switch_animation("move")
			
			if (velocity.y > 0) and (_curr_animation() != "idle"):
				_switch_animation("idle")
			
			if (velocity.y < 0) and (_curr_animation() != "fall"):
				_switch_animation("fall")

		else:
			_switch_state(S_IDLE, action)

	elif state == S_JUMP:
		if is_on_ground:
			_jump_counter = 0

		if action == A_JUMP:
			if _jump_counter < 2:
				_jump_counter += 1
				velocity.y += JUMP_SPEED
				_get_end_animation_flag()
				_switch_animation("jump")
			else:
				_switch_state(S_IDLE, A_NONE)
		
		if !_get_end_animation_flag():
			if (action == A_MOVE_R) or (action == A_MOVE_L):
				velocity.x = orientation * SPEED
			
			if (action == A_ATTACK_BASIC) or (action == A_ATTACK_SMASH):
				_switch_state(S_IDLE, action)

		else:
			_switch_state(S_IDLE, action)

	elif state == S_ATTACK_BASIC:
		if (action == A_ATTACK_BASIC) and _attack_counter < 1:
			_attack_counter += 1
			_lock_orientation = true
			_get_end_animation_flag()
			_switch_animation("attack_basic")

		if action == A_MOVE_R:
			velocity.x = 100
		if action == A_MOVE_L:
			velocity.x = -100
		
		if _get_end_animation_flag():
			_attack_counter = 0
			_lock_orientation = false
			_switch_state(S_IDLE, action)

	elif state == S_ATTACK_SMASH:
		if (action == A_ATTACK_SMASH) and _attack_counter < 1:
			_attack_counter += 1
			_lock_orientation = true
			_get_end_animation_flag()
			_switch_animation("attack_smash")

		if (action == A_MOVE_R) and (orientation == 1):
			velocity.x = SPEED
		if action == A_MOVE_L and (orientation == -1):
			velocity.x = -SPEED

		if _get_end_animation_flag():
			_attack_counter = 0
			_lock_orientation = false
			_switch_state(S_IDLE, action)


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.connect("animation_finished", self, "_animation_finished")
	#pass # Replace with function body.


func _physics_process(delta):
	# detect actions
	var actions = []
	if Input.is_action_pressed("ui_right"):
		actions.append(A_MOVE_R)
	if Input.is_action_pressed("ui_left"):
		actions.append(A_MOVE_L)
	if Input.is_action_just_pressed("ui_up"):
		actions.append(A_JUMP)
	if Input.is_action_just_pressed("attack_basic"):
		actions.append(A_ATTACK_BASIC)
	if Input.is_action_just_pressed("attack_smash"):
		actions.append(A_ATTACK_SMASH)

	# finite state machine
	_fsm(actions, delta)

	# motion
	move_and_slide(Vector2(velocity.x, -velocity.y), Vector2(0, -1))
	#move_and_slide_with_snap()

	# check is on ground
	is_on_ground = is_on_floor()
	if is_on_ground:
		velocity.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

