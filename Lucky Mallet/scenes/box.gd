extends RigidBody2D


@export var box_type := true ## TRUE FOR SMALL, FALSE FOR LARGE

@onready var refresh = $Refresh
@onready var indicator_color = $IndicatorColor

@export var size_small: Vector2
@export var size_large: Vector2


func _on_refresh_timeout():
	if box_type == true: # for small box
		indicator_color.color = Color(0, 1, 0)
		self.scale = size_small
		
	elif box_type == false: # for large box
		indicator_color.color = Color(1, 0.5, 0)
		self.scale = size_large
		
