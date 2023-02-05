extends Area2D

signal hit_player_side
signal hit_cpu_side

var screen_size
var screen_top_border
var screen_right_border
var screen_bottom_border
var screen_left_border

export var speed = 750
var velocity
var width = 32
var height = 32


func _ready():
	screen_size = get_viewport_rect().size
	screen_top_border = 16
	screen_bottom_border = screen_size.y - 16
	reset_ball()


func _process(delta):
	if (position.y + velocity.y * delta >= screen_bottom_border
		or position.y + velocity.y * delta <= screen_top_border):
			velocity.y = -velocity.y
	if position.x + velocity.normalized().x * delta <= 0:
		emit_signal("hit_player_side")
		reset_ball()
	if position.x + velocity.normalized().x * delta >= screen_size.x:
		emit_signal("hit_cpu_side")
		reset_ball()
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, screen_top_border, screen_bottom_border)


func bounce_ball():
	yield(get_tree().create_timer(1), "timeout")
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2
	var random = randi() % 4
	if random == 0:
		velocity = Vector2(3, 1)
	if random == 1:
		velocity = Vector2(3, -1)
	if random == 2:
		velocity = Vector2(-3, 1)
	if random == 3:
		velocity = Vector2(-3, -1)


func reset_ball():
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2
	velocity = Vector2.ZERO


func show_ball():
	$Sprite.show()


func hide_ball():
	$Sprite.hide()


func _on_Ball_area_entered(area):
#	$HitSound.play()
	var paddle_center = area.position.y + area.height / 2
	# Paddle bottom - bounce back to bottom
	if position.y >= paddle_center and velocity.y < 0: 
		velocity.y = -velocity.y
	# Paddle top - bounce ball back to top
	elif position.y < paddle_center and velocity.y > 0:
		velocity.y = -velocity.y
	velocity.x = -velocity.x
