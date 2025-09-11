extends RigidBody2D

var speed = 300
var started = false

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(10)# Connect collision signal
	body_entered.connect(_on_body_entered)
	
	
func _physics_process(delta):
	if not started:
		if Input.is_action_just_pressed("ui_accept"):
			start_ball()

func start_ball():
	started = true
	# Launch ball upward at slight angle
	var direction = Vector2(randf_range(-0.5, 0.5), -1).normalized()
	linear_velocity = direction * speed

func _on_body_entered(body):
	print("Ball hit: ", body.name)  # Debug line
	
	if body.name == "Paddle":
		var hit_pos = (global_position.x - body.global_position.x) / 50.0
		var direction = Vector2(hit_pos, -abs(linear_velocity.y)).normalized()
		linear_velocity = direction * speed
	
	# Keep ball speed constant
	if linear_velocity.length() > 0:
		linear_velocity = linear_velocity.normalized() * speed
