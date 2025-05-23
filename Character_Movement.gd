extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta: float) -> void:

	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var fix_direction = direction.normalized()
	if fix_direction == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = fix_direction * SPEED

	move_and_slide()
