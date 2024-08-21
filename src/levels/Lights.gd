extends Node3D

# Işıkları saklamak için bir Array
var lights = []

func _ready():
	randomize()
	# Işıkları kaydet
	for child in get_children():
		if child is OmniLight3D:
			lights.append(child)
	
	# Tek bir Timer node'u oluştur
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0 # 1 saniye aralıklarla
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()

# Timer'ın zaman aşımı fonksiyonu
func _on_Timer_timeout():
	# Tüm ışıkların durumunu değiştir
	for light in lights:
		light.visible = not light.visible
