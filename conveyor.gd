extends StaticBody2D

@onready var world = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
	$AnimatedSprite2D.set_frame_and_progress(world.frame, world.frame_progress)
