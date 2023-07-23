class_name Stage
extends Node2D

@export_category("Camera")
@export var defaultCamZoom:float = 1.05

@export_category("Positioning")
@export var opponent:Vector2 = Vector2(100, 100)
@export var player:Vector2 = Vector2(770, 450)
@export var girlfriend:Vector2 = Vector2(400, 130)

@export_category("Camera Offset")
@export var opponentCam:Vector2 = Vector2.ZERO
@export var playerCam:Vector2 = Vector2.ZERO
@export var girlfriendCam:Vector2 = Vector2.ZERO
