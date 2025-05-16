extends Node3D

var cityScene = load("res://TerrainScenes/CityBlock.tscn")
var forestScene = load("res://TerrainScenes/ParkBlock.tscn")
var desertScene = load("res://TerrainScenes/DesertBlock.tscn")
var mountainScene = load("res://TerrainScenes/MountainScene.tscn")
var islandScene = load("res://TerrainScenes/IslandScene.tscn")
var metroScene = load("res://TerrainScenes/MetroScene.tscn")

var terrainSceneList = [cityScene, forestScene, desertScene, mountainScene, islandScene, metroScene]
var rng = RandomNumberGenerator.new()

func _ready():
	for i in range(100):
		var randomScene = terrainSceneList.pick_random()
		var randomPos = Vector3.ZERO
		randomPos.x = rng.randi_range(-250, 250)
		randomPos.z = rng.randi_range(-250, 250)
		for child in self.find_children("*", "", true, false):
			if (child.position - randomPos).length() < 10:
				i -= 1
				continue
		var instance = randomScene.instantiate()
		instance.position = randomPos
		add_child(instance)
		
				
		
	
	
	
