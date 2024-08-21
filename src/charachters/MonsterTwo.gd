extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

# Karakter node'unuzu saklayacak bir değişken
var player: CharacterBody3D

var navigation_ready = false

func _ready() -> void:
	player = get_node("/root/LevelTwo/Player")  # Oyuncu node'unuzun sahne yolunu buraya yazın

func _process(_delta: float) -> void:
	if navigation_agent_3d.is_navigation_finished() and not navigation_ready:
		navigation_ready = true

func _physics_process(_delta: float) -> void:
	if player and navigation_ready:
		# Oyuncunun pozisyonunu hedef olarak belirleyin
		navigation_agent_3d.set_target_position(player.global_position)

		var destination = navigation_agent_3d.get_next_path_position()
		if destination != Vector3.ZERO:  # Hedef pozisyonun geçerli olup olmadığını kontrol edin
			var local_destination = destination - global_position
			var direction = local_destination.normalized()

			# Canavarı hareket yönüne doğru döndür
			var look_dir = (player.global_position - global_position).normalized()
			look_dir.y = 0  # Y ekseninde düz kalmasını sağlamak için

			var target_rotation = atan2(look_dir.x, look_dir.z)
			rotation.y = lerp_angle(rotation.y, target_rotation, 0.1)  # Dönüşü yumuşatmak için

			# Hareketi uygula
			velocity = direction * 3.0
			move_and_slide()
