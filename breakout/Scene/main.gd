extends Node
var score = 0
var blocks_remaining = 0

@onready var score_label = $GameArea/UI/ScoreLabel
@onready var game_over_label = $GameArea/UI/GameOverLabel
@onready var ball = $GameArea/Ball
@onready var blocks_container = $GameArea/Blocks

func _ready():
	create_blocks()

func create_blocks():
	var rows = 6
	var cols = 10
	var block_width = 60
	var block_height = 20
	var padding = 5
	var start_x = -300  # Relative to GameArea center
	var start_y = -200
	
	for row in range(rows):
		for col in range(cols):
			var block = preload("res://Scene/blocks.gd").new()
			var x = start_x + col * (block_width + padding)
			var y = start_y + row * (block_height + padding)
			
			block.position = Vector2(x, y)
			block.create_visual()
			block.block_destroyed.connect(_on_block_destroyed)
			blocks_container.add_child(block)
			blocks_remaining += 1

func _on_block_destroyed(points):
	score += points
	score_label.text = "Score: " + str(score)
	blocks_remaining -= 1
	
	if blocks_remaining <= 0:
		win_game()

func win_game():
	game_over_label.text = "You Win!"
	game_over_label.visible = true
	get_tree().paused = true

func _physics_process(delta):
	if ball.position.y > 350:
		game_over()

func game_over():
	game_over_label.text = "Game Over!"
	game_over_label.visible = true
	ball.linear_velocity = Vector2.ZERO
