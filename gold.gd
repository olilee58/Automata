extends StaticBody2D

var target = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX
	global_rotation_degrees = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if target:
		global_position = global_position.move_toward(target.global_position, 0.64)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Conveyor"):
		var parent = area.get_parent()
		var push = parent.get_child(-1)
		target = push.get_child(0)
	if area.is_in_group("Sell"):
		Global.cash += 1
		print(Global.cash)
		queue_free()
	if area.is_in_group("Destroy"):
		queue_free()
