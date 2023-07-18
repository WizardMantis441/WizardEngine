extends Node

var bpm:float = 100;
var crochet:float = ((60 / bpm) * 1000); # beats in ms
var stepCrochet:float = crochet / 4; # steps in ms
var songPosition:float;

var bpmChangeMap:Array = [];

var curStep:int = 0;
var curBeat:int = 0;
var curMeasure:int = 0;

func _process(elapsed:float) -> void:
	if not paused:
		songPosition += elapsed * 1000;
		
	var oldStep:int = curStep;
	
	var lastChange:Dictionary = {
		"stepTime": 0,
		"songTime": 0,
		"bpm": 0
	}

	for i in bpmChangeMap.size():
		if songPosition >= bpmChangeMap[i].songTime:
			lastChange = bpmChangeMap[i];
		
	curStep = lastChange["stepTime"] + floor((songPosition - lastChange["songTime"]) / stepCrochet);
	curBeat = floor(curStep / 4);
	
	if oldStep != curStep:
		stepHit();

var paused:bool = false;

func play() -> void:
	paused = false;

func pause() -> void:
	paused = true;

func reset() -> void:
	songPosition = 0;

func stepHit():
	if curStep % 4 == 0:
		beatHit();
	print("curStep ", curStep, ", curBeat ", curBeat, ", curMeasure ", curMeasure);

func beatHit():
	if curBeat % 4 == 0:
		measureHit();

func measureHit():
	# do literally nothing dumbass
	pass
