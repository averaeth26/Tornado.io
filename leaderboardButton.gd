extends Control

func _on_menu_button_pressed() -> void:
	Leaderboard.didReload = false
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	
func _ready() -> void:
	# grab the score the timer stored
	var final_score = Leaderboard.score

	# submit it
	if not Leaderboard.didReload:
		await Leaderboards.post_guest_score("tornadoio-tornadoio2-d59Z", final_score)
		get_tree().reload_current_scene()
		Leaderboard.didReload = true
