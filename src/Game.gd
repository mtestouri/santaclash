extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var s

func _createNode():
	s = Sprite.new() # Create a new sprite!
	add_child(s) # Add it as a child of this node.

func _freeNode():
	s.queue_free() # Removes the node from the scene and frees it when it becomes safe to do so.

func _loadScene():
	#var scene = preload("res://myscene.tscn") # Will load when parsing the script.
	#var node = scene.instance()
	#add_child(node)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	# screen scaling
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, 
								  SceneTree.STRETCH_ASPECT_IGNORE, 
								  Vector2(1280, 720))
	var screen_size = get_viewport_rect().size

	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	
	
	# /!\ get_tree().get_root() and get_node("/root") are also possible /!\

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_node("DisplayAction").text = "JUMP"
	
#func _physics_process(delta):
   # This is called every physics frame.
   #pass

func _enter_tree():
	# When the node enters the Scene Tree, it becomes active
	# and  this function is called. Children nodes have not entered
	# the active scene yet. In general, it's better to use _ready()
	# for most cases.
	pass

func _exit_tree():
	# When the node exits the Scene Tree, this function is called.
	# Children nodes have all exited the Scene Tree at this point
	# and all became inactive.
	pass
