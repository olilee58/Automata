extends CharacterBody2D

const SPEED = 300.0
var old_position = null
var new_position = null

func _physics_process(delta: float) -> void:

	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var fix_direction = direction.normalized()
	if fix_direction == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = fix_direction * SPEED
		
	new_position = global_position
	Global.player = new_position
	if old_position:
		if new_position == old_position:
			$AnimatedSprite2D.set_frame_and_progress(0, 0)
			$AudioStreamPlayer.playing = false
		elif new_position.x > old_position.x:
			if $AnimatedSprite2D.animation != "right":
				$AnimatedSprite2D.play("right")
			if $AudioStreamPlayer.playing == false:
				$AudioStreamPlayer.play()
		elif new_position.x < old_position.x:
			if $AnimatedSprite2D.animation != "left":
				$AnimatedSprite2D.play("left")
			if $AudioStreamPlayer.playing == false:
				$AudioStreamPlayer.play()
		elif new_position.y < old_position.y:
			if $AnimatedSprite2D.animation != "up":
				$AnimatedSprite2D.play("up")
			if $AudioStreamPlayer.playing == false:
				$AudioStreamPlayer.play()
		elif new_position.y > old_position.y:
			if $AnimatedSprite2D.animation != "down":
				$AnimatedSprite2D.play("down")
			if $AudioStreamPlayer.playing == false:
				$AudioStreamPlayer.play()
	old_position = new_position

	move_and_slide()
