extends StaticBody2D

var target = null
var old_position = null
var new_position = null
var bar = 0
var check = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX - 2
	global_rotation_degrees = 0
	$AnimatedSprite2D.rotation_degrees = randf_range(0, 359)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		global_position = global_position.move_toward(target.global_position, .64 * delta * 60)
	if old_position:
		old_position = new_position
		new_position = global_position
		if old_position == new_position:
			if check == 5:
				queue_free()
			check += 1
		else:
			check = 0
	else:
		old_position = global_position


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Conveyor"):
		var parent = area.get_parent()
		var push = parent.get_child(-1)
		target = push.get_child(0)
	if area.is_in_group("Sell"):
		if bar == 1:
			Global.cash += 5
		else:
			Global.cash += 1
		queue_free()
	if area.is_in_group("Destroy"):
		queue_free()
	if area.is_in_group("Smelt"):
		$AnimatedSprite2D.play("new_animation")
		bar = 1
