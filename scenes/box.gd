extends RigidBody2D


## POSITIVE FOR SMALL, NEGATIVE FOR LARGE. 
@export var box_type := 1 

@onready var collision_shape_2d = $CollisionShape2D
@onready var indicator_color = $CollisionShape2D/Colors/IndicatorColor
@onready var colors = $CollisionShape2D/Colors

## SIZE MULTIPLIER FOR SMALL BOX
@export var size_small: Vector2

## SIZE MULTIPLIER FOR LARGE BOX
@export var size_large: Vector2

## DEFAULT SIZE
@export var size_default: Vector2 = Vector2(32, 32)

func _ready():
	Global.boxes_array.append(self)

func _on_area_2d_area_entered(_area):
	box_type *= -1
	#
	#print()
	#print(box_type, " ", collision_shape_2d.shape.size)
	if box_type >= 1: # for small box
		self.indicator_color.color = Color(0, 1, 0)
		self.colors.scale = size_small
		self.collision_shape_2d.shape.size = size_default * size_small
		
	elif box_type <= -1: # for large box
		self.indicator_color.color = Color(1, 0.5, 0)
		self.colors.scale = size_large
		self.collision_shape_2d.shape.size = size_default * size_large 
