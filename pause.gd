extends Control
# referenced from GDQuest (aug 14, 2018) https://youtu.be/Jf7F3JhY9Fg
#toggles pause on esc
func _input(event ):
	if event.is_action_pressed("pause"):
		
		var newState = not get_tree().paused
		
		get_tree().paused = newState
		visible = newState



func _on_quiTB_pressed():
	get_tree().quit()


func _on_ResmB_pressed():
	var newState = not get_tree().paused
	
	get_tree().paused = newState
	visible = newState
