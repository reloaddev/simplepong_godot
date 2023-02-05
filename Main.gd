extends Node


var score_player = 0
var score_cpu = 0
var seconds
var is_game_over = false


func _on_HUD_start_game():
	new_game()


func new_game():
	is_game_over = false
	reset_score()
	reset_countdown()
	$HUD.update_message("")
	$Music.play()
	$Ball.show_ball()
	$Ball.bounce_ball()


func game_over():
	is_game_over = true
	$Music.stop()
	$GameTimer.stop()
	$Ball.hide_ball()
	$Ball.reset_ball()
	$HUD.update_message("Player wins!" if score_player > score_cpu else "CPU wins!")
	$HUD.show_game_over()
	
	
func reset_score():
	score_player = 0
	score_cpu = 0
	$HUD.update_score(score_player, score_cpu)


func reset_countdown():
	seconds = 10
	$GameTimer.start()


func _on_GameTimer_timeout():
	seconds -= 1
	$HUD.update_timer(seconds)
	if (seconds <= 0):
		game_over()


func _on_Ball_hit_player_side():
	score_cpu += 1
	$HUD.update_score(score_player, score_cpu)
	if not is_game_over:
		$Ball.bounce_ball()


func _on_Ball_hit_cpu_side():
	score_player += 1
	$HUD.update_score(score_player, score_cpu)
	if not is_game_over:
		$Ball.bounce_ball()
