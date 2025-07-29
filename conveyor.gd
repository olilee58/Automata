extends StaticBody2D

@onready var world = $".."
var delete = 0

# Called when the node enters the scene tree for the first time.
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
		await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.set_frame_and_progress(world.frame, world.frame_progress)
	$Check.add_to_group("Conveyor")
	$Destroy.add_to_group("Destroy")
	modulate.a = 1
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX - 3
	$CollisionShape2D.disabled = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Delete"):
		if delete == 1:
			if Global.placing == 0:
				queue_free()

func _on_mouse_entered() -> void:
	delete = 1

func _on_mouse_exited() -> void:
	delete = 0
