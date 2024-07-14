extends Node2D

#scene changing
func _on_Button_pressed():

	get_tree().change_scene("res://main menu.tscn")
	queue_free()
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://main menu.tscn")
		queue_free()
		
		
