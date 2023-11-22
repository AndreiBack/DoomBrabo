extends Control

var timer

func _ready():
	# Cria um Timer e o adiciona como filho do controle
	timer = Timer.new()
	add_child(timer)
	
	# Conecta o sinal "timeout" do timer à função que muda de cena
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	# Define o tempo de espera do timer em segundos (4 segundos neste caso)
	timer.wait_time = 4
	
	# Inicia o timer
	timer.start()

# Chamado quando o timer atinge zero
func _on_Timer_timeout():
	# Carrega a cena desejada (substitua "CenaDesejada.tscn" pelo nome do seu arquivo de cena)
	get_tree().change_scene("res://MainMenu.gd")
