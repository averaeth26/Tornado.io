extends Node3D

var cityScene = load("res://TerrainScenes/CityBlock.tscn")
var forestScene = load("res://TerrainScenes/ParkBlock.tscn")
var desertScene = load("res://TerrainScenes/DesertBlock.tscn")
var mountainScene = load("res://TerrainScenes/MountainScene.tscn")
var islandScene = load("res://TerrainScenes/IslandScene.tscn")
var metroScene = load("res://TerrainScenes/MetroScene.tscn")

var terrainSceneList = [cityScene, forestScene, desertScene, mountainScene, islandScene, metroScene]


func _ready():
	var rng = RandomNumberGenerator.new()
	var childList = self.find_children("*", "", true, false)
	rng.randomize()
	var numPlaced = 0
	
	while numPlaced < 80:
		var tooClose = false;
		var randomScene = terrainSceneList.pick_random()
		var randomPos = Vector3.ZERO
		randomPos.x = rng.randi_range(-500, 500)
		randomPos.z = rng.randi_range(-500, 500)
		for child in childList:
			print((child.position - randomPos).length())
			if (child.position - randomPos).length() < 80:
				tooClose = true
				break
		if not tooClose:
			var instance = randomScene.instantiate()
			instance.position = randomPos
			add_child(instance)
			childList.append(instance)
			numPlaced += 1
		
				
		
	
	
	
