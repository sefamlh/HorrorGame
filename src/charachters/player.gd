extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var camera_pivot : Node3D
@onready var background_music = $BackgroundMusic  # Ses kaynağını tanımlıyoruz
@onready var breathing_sound = $BreathingSound  # Nefes sesi kaynağını tanımlıyoruz
@onready var step_sound = $StepSound  # Adım sesi kaynağını tanımlıyoruz

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera_pivot = get_node("CameraPivot")

	# Arka plan müziğini ayarla ve çal
	var audio_stream = load("res://src/soundEffects/background-horror-sound.mp3") as AudioStream
	background_music.stream = audio_stream
	background_music.play()

	# Nefes sesini ayarla ve çal
	var breathing_stream = load("res://src/soundEffects/breathing.mp3") as AudioStream
	breathing_sound.stream = breathing_stream
	breathing_stream.loop = true
	breathing_sound.play()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * 0.1))
		camera_pivot.rotate_x(deg_to_rad(-event.relative.y * 0.1))
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-75), deg_to_rad(75))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Adım sesini kontrol et
	if direction:
		if not step_sound.playing:
			var step_stream = load("res://src/soundEffects/step.mp3") as AudioStream
			step_sound.stream = step_stream
			step_sound.play()
	elif not direction:
		step_sound.stop()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
