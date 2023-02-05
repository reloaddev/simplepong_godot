extends Area2D

var screen_size
var height
var speed = 400
var ball


func _ready():
	screen_size = get_viewport_rect().size
	height = $ColorRect.rect_size.y


func _process(delta):
	ball = get_parent().get_node("Ball")
	var velocity
	if ball.position.x > screen_size.x * 0.45:
		if ball.position.y > position.y + height / 2:
			velocity = Vector2.DOWN
		elif ball.position.y < position.y + height / 2:
			velocity = Vector2.UP
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.y = clamp(position.y, 0, screen_size.y - height)
