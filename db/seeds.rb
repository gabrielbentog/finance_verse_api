variable_income = Category.create(name: "Renda Variável")
fixed_income = Category.create(name: "Renda Fixa")
tesouro_direto = Category.create(name: "Tesouro Direto")
savings = Category.create(name: "Poupança")

TransactionType.create(name: "Ações", category: variable_income)
TransactionType.create(name: "Fundo Imobiliário", category: fixed_income)
TransactionType.create(name: "Tesouro Direto", category: tesouro_direto)
TransactionType.create(name: "Poupança", category: savings)

