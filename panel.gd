extends Panel
var time: float = 120.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

func _process(delta: float) -> void:
	time -= delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d." % seconds
	$Milliseconds.text = "%03d" % msec
	if time < 0:
		stop()
		#TODO: Add leaderboard and leaderboard scene and link it up here
		get_tree().change_scene_to_file("res://Leaderboard.tscn")

	
func stop() -> void:
	set_process(false)

	
	
