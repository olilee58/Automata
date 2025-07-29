@tool
extends PanelContainer
var number

@export var item : Item:
	set (value):
		item = value
		$Icon.texture = item.icon

func _on_mouse_entered() -> void:
	number = $"..".get_children().find(self)
	if item != null:
		owner.set_description(item)
		owner.selection(number)
		
func _on_mouse_exited() -> void:
	Global.choice = null
