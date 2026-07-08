extends Node2D

func light_eyes():
	$Sprite2D.material.shader = load("res://main/splash_screen_eyes.gdshader")

func end():
	get_tree().change_scene_to_file("res://main/main.tscn")
