extends Control


@export var description : NinePatchRect

func _ready() -> void:
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX

func set_description(item : Item):
	description.find_child("Name").text = item.title
	description.find_child("PreviewIcon").texture = item.icon
	description.find_child("Description").text = item.description

func selection(number):
	Global.choice = number
