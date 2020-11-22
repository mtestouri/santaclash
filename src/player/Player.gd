extends KinematicBody2D


# TODO
# faudrait implementer un meilleure switch states plutot que'avoir les switch
# FALL state pas toujours enclenché


# orientation
const O_RIGHT = 1
const O_LEFT = -1
# states
const S_IDLE = 0
const S_MOVE = 1
const S_JUMP = 2
const S_FALL = 3
# actions
const A_NONE = 0
const A_MOVE = 1
const A_JUMP = 2
# motion
const SPEED = 400
const JUMP_SPEED = 500
const GRAVITY = 1000

# init
var orientation = O_RIGHT
var state = S_IDLE
var is_on_ground = true
var velocity = Vector2(0, 0)
var _end_animation_flag = false


func _switch_animation(animation):
	$AnimatedSprite.stop()
	$AnimatedSprite.animation = animation
	$AnimatedSprite.flip_h = (orientation == O_LEFT)
	$AnimatedSprite.play()


func _curr_animation():
	return $AnimatedSprite.animation


func _update_anim_orientation():
	$AnimatedSprite.flip_h = (orientation == O_LEFT)


func _animation_finished():
	_end_animation_flag = true


func _fsm(action):
	#print("STATE " + str(state))
	#print("VELOCITY " + str(velocity))
	#print("GROUND " + str(is_on_ground))

	var n_velocity = Vector2()
	_update_anim_orientation()

	if state == S_IDLE:
		if (action == A_NONE) and !is_on_ground:
			state = S_FALL
			_switch_animation("fall")

		if (action == A_MOVE) and is_on_ground:
			state = S_MOVE
			n_velocity.x = SPEED
			_switch_animation("move")

		if (action == A_MOVE) and !is_on_ground:
			state = S_MOVE
			n_velocity.x = SPEED
			_switch_animation("jump")

		if action == A_JUMP:
			state = S_JUMP
			n_velocity.y = JUMP_SPEED
			_end_animation_flag = false
			_switch_animation("jump")

	elif state == S_MOVE:
		if (action == A_NONE) and is_on_ground:
			state = S_IDLE
			_switch_animation("idle")

		if (action == A_NONE) and !is_on_ground:
			state = S_FALL
			_switch_animation("fall")

		if (action == A_MOVE):
			n_velocity.x = SPEED
			
			if is_on_ground and (_curr_animation() != "move"):
				_switch_animation("move")
		
			if !is_on_ground and (_curr_animation() != "jump"):
				_switch_animation("jump")

		if (action == A_JUMP):
			state = S_JUMP
			n_velocity.y = JUMP_SPEED
			_end_animation_flag = false
			_switch_animation("jump")

	elif state == S_JUMP:
		if (action == A_NONE) and is_on_ground:
			state = S_IDLE
			_switch_animation("idle")

		if (action == A_NONE) and (velocity.y < 0):
			state = S_FALL
			_switch_animation("fall")

		if (action == A_MOVE) and !is_on_ground:
			state = S_MOVE
			n_velocity.x = SPEED
			_switch_animation("move")

		if (action == A_MOVE) and is_on_ground:
			state = S_MOVE
			n_velocity.x = SPEED
			_switch_animation("move")

		if (action == A_JUMP):
			n_velocity.y = JUMP_SPEED
			_switch_animation("jump")

		if (_end_animation_flag):
			_end_animation_flag = false
			_switch_animation("idle")

	elif state == S_FALL:
		if (action == A_NONE) and is_on_ground:
			state = S_IDLE
			_switch_animation("idle")

		if (action == A_MOVE) and is_on_ground:
			state = S_MOVE
			n_velocity.x = SPEED
			_switch_animation("move")

		if (action == A_MOVE) and !is_on_ground:
			state = S_MOVE
			n_velocity.x = SPEED
			_switch_animation("jump")

		if action == A_JUMP:
			state = S_JUMP
			n_velocity.y = JUMP_SPEED
			_end_animation_flag = false
			_switch_animation("jump")

	# new velocity
	if orientation == O_LEFT:
		n_velocity.x = -1 * n_velocity.x
	
	# update velocity
	velocity.x = n_velocity.x
	velocity.y += n_velocity.y


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.connect("animation_finished", self, "_animation_finished")
	#pass # Replace with function body.


func _physics_process(delta):
	# detect action
	var action = A_NONE
	if Input.is_action_pressed("ui_right"):
		orientation = O_RIGHT
		action = A_MOVE
	if Input.is_action_pressed("ui_left"):
		orientation = O_LEFT
		action = A_MOVE
	if Input.is_action_just_pressed("ui_up"):
		action = A_JUMP

	# update finite state machine
	_fsm(action)

	# apply gravity
	velocity.y -= GRAVITY * delta

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

