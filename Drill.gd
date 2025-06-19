extends StaticBody2D

@export var ore : PackedScene
var current = null
var go = 0
var stop = 0

func _ready() -> void:
	while Global.placing == 1:
		$AnimatedSprite2D.play("new_animation")
		await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.play("default")
	mining()

func mining():
	while true:
		await get_tree().create_timer(5).timeout
		var new_ore = ore.instantiate()
		add_child(new_ore)
		current = get_child(-1)
		go = 1
		await get_tree().create_timer(1.5).timeout
		stop = 1

func _process(_delta: float) -> void:
	if go == 1:
		if stop == 0:
			if current:
				current.global_position = current.global_position.move_toward($Push/CollisionShape2D.global_position, 0.64)
			else:
				await get_tree().create_timer(1.5).timeout
				go = 0
				stop = 0
		else:
			go = 0
			stop = 0
