class_name Question
extends Node2D

@onready var question_node = $"."
@onready var questions_label = $"Questions"
@onready var question_label: Label = $Question
@onready var answer_a: Button = $"Button A"
@onready var answer_b: Button = $"Button B"
@onready var answer_c: Button = $"Button C"
@onready var answer_d: Button = $"Button D"
@onready var timeover = $TimeOver
@onready var correct = $Correct
@onready var incorrect = $Incorrect
@onready var time_label: Label = $Time
@onready var timer: Timer = $Time/Timer
@onready var game_zone: GameZone = $".."

var countdown_time: int = 15
var current_answer
var question_count: int

func _ready():
	if DataManager.npc_name == "Guardian TI":
		question_count = 15
	else:
		question_count = 8
	DataManager.question_list.shuffle()
	questions_label.hide()
	time_label.hide()
	_hide_question()
	get_tree().paused = false
	if DataManager.npc_name == "Guardian TI":
		AudioManager.play_music("Land with No Dragons.mp3")
	else:
		AudioManager.play_music("ReClaimed.mp3")
	timer.timeout.connect(_on_timer_tick)
	await get_tree().create_timer(3).timeout
	questions_label.show()
	_call_question()
	
func update_time_label():
	time_label.text = str("TIEMPO : ",countdown_time)

func update_questions_label():
	questions_label.text = str("PREGUNTAS : ",question_count)

func _on_timer_tick():
	countdown_time -= 1
	update_time_label()
	if countdown_time == 0:
		timer.stop()
		question_count -= 1
		update_questions_label()
		_hide_question()
		timeover.show()
		TweenManager._appear_tween(timeover)
		TweenManager._color_tween(timeover, Color(0.5, 0.0, 0.0), Color(1.0, 0.5, 0.5))
		AudioManager.play_sound("Down Stats.wav")
		await get_tree().create_timer(1).timeout
		timeover.hide()
		game_zone.player.current_hp -= 1
		DataManager.player_stats[0]["incorrect_questions"] += 1
		TweenManager._shake_tween(game_zone.player)
		game_zone.player.player_anim.play("player_damage")
		AudioManager.play_sound("Attack Phase.wav")
		await get_tree().create_timer(1).timeout
		if game_zone.player.current_hp <= 0 and question_count >= 0:
			DataManager.player_stats[0]["lose_battles"] += 1
			game_zone.player.player_anim.play("player_death")
			game_zone.player_battle.hide()
			_lose_time_over()
		elif question_count < 0 and game_zone.npc.current_hp > 0:
			DataManager.player_stats[0]["lose_battles"] += 1
			game_zone.notifications.lose_label.text = "Se acabaron las preguntas"
			_lose_time_over()
		else:
			_call_question()

func _on_button_a_pressed():
	current_answer = answer_a.text
	_check_answer()

func _on_button_b_pressed():
	current_answer = answer_b.text
	_check_answer()
	
func _on_button_c_pressed():
	current_answer = answer_c.text
	_check_answer()

func _on_button_d_pressed():
	current_answer = answer_d.text
	_check_answer()

func _call_question():
	update_questions_label()
	countdown_time = 15
	time_label.show()
	question_label.show()
	answer_a.show()
	answer_b.show()
	answer_c.show()
	answer_d.show()
	timer.start()
	update_time_label() 
	DataManager._get_question(DataManager.question_list[question_count])
	question_label.text = DataManager.current_question
	answer_a.text = DataManager.current_options[0]
	answer_b.text = DataManager.current_options[1]
	answer_c.text = DataManager.current_options[2]
	answer_d.text = DataManager.current_options[3]

func _check_answer():
	timer.stop()
	question_count -= 1
	update_questions_label()
	_hide_question()
	
	if current_answer == DataManager.current_answer:
		correct.show()
		TweenManager._appear_tween(correct)
		TweenManager._color_tween(correct, Color(0.0, 0.5, 0.0), Color(0.5, 1.0, 0.5))
		AudioManager.play_sound("Magic.wav")
		await get_tree().create_timer(1).timeout
		correct.hide()
		game_zone.npc.current_hp -= 1
		DataManager.player_stats[0]["correct_questions"] += 1
		
		#PLAYER ATTACK ENEMY SEQUENCE
		AudioManager.play_sound("Discard.wav")
		TweenManager._attack_tween(game_zone.player_battle,
			Vector2(game_zone.player_battle.position.x+160,game_zone.player_battle.position.y), 0.15)
		await get_tree().create_timer(0.2).timeout
		AudioManager.play_sound("Attack Phase.wav")
		game_zone.npc_battle.vfx.show()
		game_zone.npc_battle.vfx.play("impact")
		TweenManager._attack_tween(game_zone.npc_battle,
			Vector2(game_zone.npc_battle.position.x+40,game_zone.npc_battle.position.y), 0.15)
		await get_tree().create_timer(0.15).timeout
		game_zone.npc_battle.vfx.hide()
		TweenManager._attack_tween(game_zone.player_battle,
			Vector2(game_zone.player_battle.position.x-160,game_zone.player_battle.position.y), 0.15)
		TweenManager._attack_tween(game_zone.npc_battle,
			Vector2(game_zone.npc_battle.position.x-40,game_zone.npc_battle.position.y), 0.15)
		await get_tree().create_timer(0.15).timeout
		#END SEQUENCE
		
		TweenManager._shake_tween(game_zone.npc)
		game_zone.npc.npc_animation.play("damage_enemy")
		AudioManager.play_sound("Defense Phase.wav")
	
	else:
		incorrect.show()
		TweenManager._appear_tween(incorrect)
		TweenManager._color_tween(incorrect, Color(0.5, 0.0, 0.0), Color(1.0, 0.5, 0.5))
		AudioManager.play_sound("Down Stats.wav")
		await get_tree().create_timer(1).timeout
		incorrect.hide()
		game_zone.player.current_hp -= 1
		DataManager.player_stats[0]["incorrect_questions"] += 1
		
		#ENEMY ATTACK PLAYER SEQUENCE
		AudioManager.play_sound("Discard.wav")
		TweenManager._attack_tween(game_zone.npc_battle,
			Vector2(game_zone.npc_battle.position.x-160,game_zone.npc_battle.position.y), 0.15)
		await get_tree().create_timer(0.2).timeout
		AudioManager.play_sound("Attack Phase.wav")
		game_zone.player_battle.vfx.show()
		game_zone.player_battle.vfx.play("impact")
		TweenManager._attack_tween(game_zone.player_battle,
			Vector2(game_zone.player_battle.position.x-40,game_zone.player_battle.position.y), 0.15)
		await get_tree().create_timer(0.15).timeout
		game_zone.player_battle.vfx.hide()
		TweenManager._attack_tween(game_zone.npc_battle,
			Vector2(game_zone.npc_battle.position.x+160,game_zone.npc_battle.position.y), 0.15)
		TweenManager._attack_tween(game_zone.player_battle,
			Vector2(game_zone.player_battle.position.x+40,game_zone.player_battle.position.y), 0.15)
		await get_tree().create_timer(0.15).timeout
		#END SEQUENCE
		
		TweenManager._shake_tween(game_zone.player)
		game_zone.player.player_anim.play("player_damage")
		AudioManager.play_sound("Defense Phase.wav")
		
	await get_tree().create_timer(1).timeout
	if question_count <= 0 and game_zone.npc.current_hp > 0:
		DataManager.player_stats[0]["lose_battles"] += 1
		timer.stop()
		time_label.hide()
		game_zone.question.hide()
		AudioManager.play_music("Think About It.mp3")
		game_zone.notifications.lose_label.text = "Se acabaron las preguntas"
		game_zone.notifications.show()
		game_zone.notifications.lose_buttons.show()
		TweenManager._appear_tween(game_zone.notifications)
		DataManager._clear_question_list()
	elif game_zone.player.current_hp <= 0 and question_count >= 0:
		DataManager.player_stats[0]["lose_battles"] += 1
		game_zone.player_battle.hide()
		game_zone.player.player_anim.play("player_death")
		timer.stop()
		time_label.hide()
		game_zone.question.hide()
		AudioManager.play_music("Think About It.mp3")
		game_zone.notifications.show()
		game_zone.notifications.lose_buttons.show()
		TweenManager._appear_tween(game_zone.notifications)
		DataManager._clear_question_list()
	elif game_zone.npc.current_hp <= 0 and question_count >= 0:
		DataManager.player_stats[0]["win_battles"] += 1
		if DataManager.npc_name == "Guardian TI":
			game_zone.notifications.win_label.text = "DERROTASTE AL GUARDIAN TI"
			game_zone.notifications.certificate_sprite.hide()
		else:
			_get_certificate()
		game_zone.npc_battle.hide()
		game_zone.npc.npc_animation.play("death_enemy")
		timer.stop()
		time_label.hide()
		game_zone.question.hide()
		AudioManager.play_music("Crystal Clear.mp3")
		game_zone.notifications.show()
		game_zone.notifications.win_buttons.show()
		TweenManager._appear_tween(game_zone.notifications)		
		DataManager._clear_question_list()
	else:
		_call_question()
		
func _hide_question():
	question_label.hide()
	answer_a.hide()
	answer_b.hide()
	answer_c.hide()
	answer_d.hide()
	
func _lose_time_over():
	timer.stop()
	time_label.hide()
	game_zone.question.hide()
	AudioManager.play_music("Think About It.mp3")
	game_zone.notifications.show()
	game_zone.notifications.lose_buttons.show()
	TweenManager._appear_tween(game_zone.notifications)
	DataManager._clear_question_list()
		
func _get_certificate():
	var certificate_type: String
	var certificate_texture: Texture2D
	if DataManager.current_type == "HW":
		certificate_type = "Keyboard.png"
		DataManager.player_stats[0]["h_cert"] = true
	elif DataManager.current_type == "Code":
		certificate_type = "Document.png"
		DataManager.player_stats[0]["p_cert"] = true
	elif DataManager.current_type == "CS":
		certificate_type = "Locked.png"
		DataManager.player_stats[0]["c_cert"] = true
	elif DataManager.current_type == "DB":
		certificate_type = "Option.png"
		DataManager.player_stats[0]["d_cert"] = true
	certificate_texture = load("res://Assets/Sprites/Icons/"+certificate_type)
	game_zone.notifications.certificate_sprite.set_texture(certificate_texture)
