user = User.create(name: "Gabriel", email: "bentogdev@gmail.com", password:"12345678")

variable_income = Category.find_or_create_by(name: "Renda Variável")
fixed_income = Category.find_or_create_by(name: "Renda Fixa")
tesouro_direto = Category.find_or_create_by(name: "Tesouro Direto")
bank = Category.find_or_create_by(name: "Banco")
crypt = Category.find_or_create_by(name: "Crypto")

stock = TransactionType.find_or_create_by(name: "Ações", category: variable_income)
fii = TransactionType.find_or_create_by(name: "Fundo Imobiliário", category: variable_income)
tesouro = TransactionType.find_or_create_by(name: "Tesouro Direto", category: tesouro_direto)
savings = TransactionType.find_or_create_by(name: "Poupança", category: bank)
emergency = TransactionType.find_or_create_by(name: "Reserva de Emergência", category: bank)
crpyt_coin = TransactionType.find_or_create_by(name: "Cripto Moeda", category: crypt)

user.transactions.create(item_name: "MXRF11", transaction_type: fii)
