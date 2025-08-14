extends StaticBody2D

var base = Vector2(9472, 5184)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.player:
		$AnimatedSprite2D.look_at(base)
