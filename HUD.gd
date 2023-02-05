extends CanvasLayer

signal start_game


func _ready():
	$MessageLabel.hide()


func show_game_over():
	$StartButton.show()
	$MessageLabel.show()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func update_score(scorePlayer, scoreCPU):
	$ScoreLabel.text = str(scorePlayer) + " : " + str(scoreCPU)
	

func update_timer(seconds):
	$TimerLabel.text = str(seconds)


func update_message(message):
	$MessageLabel.text = str(message)
