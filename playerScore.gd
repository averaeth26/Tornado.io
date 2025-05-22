extends Node3D

func _process(delta: float) -> void:
	var player = $TornadoCharacterController  
	var scoreLabel = $GUI/Score/Points 
	var playerScore = player.scale.length() - 1
	print(playerScore)
	scoreLabel.text = "Score: %d" % int(playerScore * 1000)
	Leaderboard.score = scoreLabel.text
		
