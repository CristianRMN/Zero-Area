extends ProgressBar



func heal(amount:int):
	var tween = create_tween()
	tween.tween_property(self, "value", value + amount, 0.5)
	
	
func damage(amount:int):
	var tween = create_tween()
	tween.tween_property(self, "value", value - amount, 0.5)



	


