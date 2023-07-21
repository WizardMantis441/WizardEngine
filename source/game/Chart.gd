class_name Chart extends Node

static func parse(song:String, difficulty:String):
	var c:Dictionary = JSON.parse_string(FileAccess.open("res://assets/songs/" + song + "/charts/" + difficulty + ".json", FileAccess.READ).get_as_text())
	return c
