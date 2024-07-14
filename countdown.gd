extends Control

export (int) var minutes = 0
export (int) var seconds = 0
var dsec = 0


 #reference for countdown from Endrit Special Productions link: https://youtu.be/gYNgW3Z9zhU
func _physics_process(delta):
	#5 min countdown
	#i seperated the countdown so it's easy to tell
	if seconds > 0 and dsec <= 0:
		seconds -=1
		dsec = 0.09
	if minutes > 0 and seconds <= 0 :
		minutes -= 1
		seconds = 59 
	
	if seconds >= 10:
		$sec.set_text(":"+str(seconds))
	else:
		$sec.set_text(":0"+str(seconds))
	if dsec <= 0.09:
		$msec.set_text(":"+str(dsec*100))
	if minutes >= 10:
		$min.set_text(str(minutes))
	else:
		$min.set_text("0"+str(minutes))

func _on_Timer_timeout():
	dsec -= .01
	
	
	
