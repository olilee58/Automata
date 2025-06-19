extends Node2D
@export var drill : PackedScene
@export var towers : Array[PackedScene]
var placing = false
var nodeSelf = null
var current = null
var current_towers_index = 0
var frame = 0
var frame_progress = 0
var cash = 0
 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Conveyor/AnimatedSprite2D.play("default")

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	frame_progress = $Conveyor/AnimatedSprite2D.frame_progress
	frame = $Conveyor/AnimatedSprite2D.frame
	$Conveyor/AnimatedSprite2D.set_frame_and_progress(frame, frame_progress)
	if placing:
		current.global_position = current.global_position.move_toward(get_global_mouse_position(), 9999999999999)
		current.global_position = current.global_position.snapped(Vector2.ONE * 64)
	if Input.is_mouse_button_pressed(1):
		placing = false
		Global.placing = 0
	if Input.is_action_just_pressed("Rotate"):
		if placing:
			current.rotate(deg_to_rad(90))
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Buy"):
		if not placing:
			placing = true
			Global.placing = 1
			var new_tower = towers[current_towers_index].instantiate()
			add_child(new_tower)
			current = new_tower
	elif event.is_action_pressed("Cancel"):
		if placing:
			placing = false
			Global.placing = 0
			current.queue_free()
	elif event.is_action_pressed("1"):
		current_towers_index = 0
	elif event.is_action_pressed("2"):
		current_towers_index = 1
	elif event.is_action_pressed("3"):
		current_towers_index = 2
	elif event.is_action_pressed("4"):
		current_towers_index = 3
	elif event.is_action_pressed("5"):
		current_towers_index = 4
	elif event.is_action_pressed("6"):
		current_towers_index = 5
	elif event.is_action_pressed("7"):
		current_towers_index = 6
	elif event.is_action_pressed("8"):
		current_towers_index = 7
	elif event.is_action_pressed("9"):
		current_towers_index = 8
