extends StaticBody2D

@export var ore : PackedScene
var current = null
var go = 0
var stop = 0
var delete = 0
var old_position = null
var new_position = null

func _ready() -> void:
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("new_animation")
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX
	modulate.a = 0.5
	while Global.placing == 1:
		if $Destroy.has_overlapping_areas():
			Global.can_place = 0
			$AnimatedSprite2D.play("bad")
		else:
			Global.can_place = 1
			$AnimatedSprite2D.play("new_animation")
		await get_tree().create_timer(0.000000001).timeout
	$AnimatedSprite2D.play("default")
	modulate.a = 1
	$Check.add_to_group("Conveyor")
	$Destroy.add_to_group("Destroy")
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX - 3
	$CollisionShape2D.disabled = false
	mining()

func mining():
	while true:
		var number = randf_range(4.0, 6.0)
		await get_tree().create_timer(number).timeout
		var new_ore = ore.instantiate()
		add_child(new_ore)
		current = get_child(-1)
		go = 1
		while current and current.global_position != $Push/CollisionShape2D.global_position:
			await get_tree().create_timer(0.0000000000000000000001).timeout
			if not current:
				pass
		go = 0

func _process(delta: float) -> void:
	if go == 1:
		if current:
			current.global_position = current.global_position.move_toward($Push/CollisionShape2D.global_position, 0.64 * delta * 75)
			if old_position:
				old_position = new_position
				new_position = current.global_position
				if old_position == new_position:
					go = 0
					current = null
			else:
				old_position = current.global_position
		else:
			go = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Delete"):
		if delete == 1:
			if Global.placing == 0:
				Global.cash += 1
				queue_free()

func _on_mouse_entered() -> void:
	delete = 1
	

func _on_mouse_exited() -> void:
	delete = 0
