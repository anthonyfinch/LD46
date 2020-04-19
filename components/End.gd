extends Label


const required_money = 1000

func _ready():
	var money = SharedData.money

	if money < required_money:
		text = "Oh dear, you needed " + String(required_money) + " but you only got " + String(money)
	else:
		text = "You earned enough money, and pay off your debts. Or something."
