extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fighter.id = 0


func _physics_process(delta):
	# detect actions
	var actions = []
	if Input.is_action_pressed("ui_right"):
		actions.append($Fighter.A_MOVE_R)
	if Input.is_action_pressed("ui_left"):
		actions.append($Fighter.A_MOVE_L)
	if Input.is_action_just_pressed("ui_up"):
		actions.append($Fighter.A_JUMP)
	if Input.is_action_just_pressed("attack_basic"):
		actions.append($Fighter.A_ATTACK_BASIC)
	if Input.is_action_just_pressed("attack_smash"):
		actions.append($Fighter.A_ATTACK_SMASH)

	$Fighter.do_actions(actions, delta)
