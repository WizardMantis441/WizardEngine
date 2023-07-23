extends Node

var bpm:float = 100:
	get:
		return bpm
	set(value):
		onBPMChange.emit(value)
		bpm = value
		crochet = ((60 / bpm) * 1000)
		stepCrochet = crochet / 4
var crochet:float = ((60 / bpm) * 1000); # beats in ms
var stepCrochet:float = crochet / 4; # steps in ms
var songPosition:float;

var bpmChangeMap:Array = [];

var curStep:int = 0;
var curBeat:int = 0;
var curMeasure:int = 0;

# input stuff
var hitWindow:float = 250
var latePressWindow:float = 1
var earlyPressWindow:float = 0.5

signal stepHit(curStep:int);
signal beatHit(curBeat:int);
signal measureHit(curMeasure:int);
signal onBPMChange(newBPM:float);

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
	curMeasure = floor(curBeat / 4);
	
	var curScene = get_tree().current_scene
	
	if oldStep != curStep:
		stepHit.emit(curStep);
		for i in get_tree().current_scene.get_children():
			if i.has_method("stepHit"):
				i.call_deferred("stepHit", curStep)
			if curScene.has_method("stepHit"):
				curScene.call_deferred("stepHit", curStep)
			
		if curStep % 4 == 0:
			beatHit.emit(curBeat);
			for i in get_tree().current_scene.get_children():
				if i.has_method("beatHit"):
					i.call_deferred("beatHit", curBeat)
			if curScene.has_method("beatHit"):
				curScene.call_deferred("beatHit", curBeat)
				
		if curBeat % 4 == 0:
			measureHit.emit(curMeasure);
			for i in get_tree().current_scene.get_children():
				if i.has_method("measureHit"):
					i.call_deferred("measureHit", curMeasure)
			if curScene.has_method("measureHit"):
				curScene.call_deferred("measureHit", curMeasure)

var paused:bool = false;

func play() -> void: paused = false;
func pause() -> void: paused = true;
func reset() -> void: songPosition = 0;
