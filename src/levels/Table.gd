extends Node3D

@onready var player = get_node("../Player")  # Oyuncunun sahnedeki yolu
@onready var scream_sound = $HorrorSound  # Çığlık sesi
@onready var sprite = $Sprite3D  # Tablo resmi

func _ready():
	# Area3D'nin sinyalini manuel olarak bağla
	var area = get_node("Sprite3D/Area3D")
	area.connect("body_entered", Callable(self, "_on_body_entered"))
	
	# Çığlık sesini yükle
	var scream_stream = load("res://src/soundEffects/scream.mp3") as AudioStream
	scream_sound.stream = scream_stream

func _on_body_entered(body):
	if body == player:
		# Çığlık sesini çal
		scream_sound.play()
		# Tablonun görünürlüğünü kapatma, şarkıyı durdurma
