extends CanvasLayer

var texts = [
	"Öncelikle olacaklardan ben sorumlu değilim..."
]
var current_text = 0
var char_index = 0
var displayed_text = ""

@onready var label = $Label
@onready var timer = $Timer
@onready var char_timer = $CharTimer
@onready var start_button = $Button

func _ready():
	label.text = ""
	start_button.hide()
	timer.start()
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	char_timer.connect("timeout", Callable(self, "_on_CharTimer_timeout"))
	start_button.connect("pressed", Callable(self, "_on_Button_pressed"))
	char_timer.start(0.1) # Harflerin görünme aralığını belirler (0.1 saniye)

func _on_Timer_timeout():
	current_text += 1
	if current_text < texts.size():
		char_index = 0
		displayed_text = ""
		label.text = ""
		char_timer.start()
	else:
		start_button.show()
		timer.stop()

func _on_CharTimer_timeout():
	if char_index < texts[current_text].length():
		displayed_text += texts[current_text][char_index]
		label.text = displayed_text
		char_index += 1
	else:
		char_timer.stop()

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://src/levels/Level.tscn")
