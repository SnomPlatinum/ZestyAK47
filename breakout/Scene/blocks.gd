extends StaticBody2D
class_name Block

signal block_destroyed(points)

var points = 10

func _ready():
	# Add collision detection
	var area = Area2D.new()
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	
	shape.size = Vector2(60, 20)
	collision.shape = shape
	area.add_child(collision)
	add_child(area)
	
	area.body_entered.connect(_on_area_entered)

func _on_area_entered(body):
	if body.name == "Ball":
		block_destroyed.emit(points)
		queue_free()

func create_visual():
	var rect = ColorRect.new()
	rect.size = Vector2(60, 20)
	rect.color = Color(randf(), randf(), randf())  # Random color
	add_child(rect)
