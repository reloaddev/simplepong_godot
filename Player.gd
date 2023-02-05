extends Area2D

var screen_size
var height
var speed = 400


func _ready():
	screen_size = get_viewport_rect().size
	height = $ColorRect.rect_size.y


func _process(delta):
	var velocity = get_velocity_from_user_input()
	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x / 2)
	position.y = clamp(position.y, 0, screen_size.y - height)


func get_velocity_from_user_input():
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
#	if Input.is_action_pressed("move_right"):
#		velocity.x += 1
#	if Input.is_action_pressed("move_left"):
#		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	return velocity
