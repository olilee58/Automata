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
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
		if not placing:
			if Global.choice != null:
				placing = true
				Global.placing = 1
				current_towers_index = Global.choice
				var new_tower = towers[current_towers_index].instantiate()
				add_child(new_tower)
				current = new_tower
		else:
			if Global.can_place == 1:
				placing = false
				Global.placing = 0
	elif event.is_action_pressed("Rotate"):
		if placing:
			current.rotate(deg_to_rad(90))
	elif event.is_action_pressed("Cancel"):
		if placing:
			placing = false
			Global.placing = 0
			current.queue_free()
