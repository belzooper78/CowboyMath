extends Position2D
onready var label = get_node("Label")
onready var tween = get_node("Tween")
var amount = 0
#https://youtu.be/UlvBqz8bhCo reference from Game Development Center
#shows how many points the player is getting after every round one
func _ready():
	label.set_text("+ "+str(amount))

	tween.interpolate_property(self, 'scale', scale, Vector2(2,2), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', Vector2(2,2), Vector2(0.1,0.1), 0.7,Tween.TRANS_LINEAR, Tween.EASE_OUT,0.3)
	tween.start()


func _on_Tween_tween_all_completed():
	self.queue_free()
