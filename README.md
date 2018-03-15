# Evotto - Ruby Test

### Objetivo

Crie um mini aplicativo (CLI) capaz de ler um arquivo CSV (data/users.csv), e classificar os dados. O aplicativo precisa:
- Listar os usuários
- Classificar os usuários pelos parâmetros
- Mostrar o total de um parâmetro por comando
- Exibir dados de um usuário especifico

Modo de uso esperado:

(com ordem)

```
ruby app.rb --source data/users.csv --order_by age desc

# Results (console output)
Name | Age | ProjectCount | TotalValue
John | 32 anos | 3 | 25
Maria | 27 anos | 4 | 49
...
```

Também pode exibir sem ordem:

```
ruby app.rb --source data/users.csv

# Results (console output)
Name | Age | ProjectCount | TotalValue
Maria | 27 anos | 4 | 49
John | 32 anos | 3 | 25
...
```

Exibir os resultados:

```
ruby app.rb --source data/users.csv --total TotalValue

# Results (console output)
TotalValue: 74
```

Encontrar usuário especifico:

```
ruby app.rb --source data/users.csv --find John

# Results (console output)
Name | Age | ProjectCount | TotalValue
John | 32 anos | 3 | 25
```

Prepare-se para alguns edge cases, por exemplo: O que acontece se não encontrar nenhum usuário? Posso selecionar mais de 2 usuários ao mesmo tempo?

### Requerimentos

- Escreva utilizando Ruby (2+, fique a vontade para escolher a versão, aconselhada é a 2.3.1), fique livre para usar quaisquer bibliotecas, base de dados a sua escolha e etc
- Escreva o máximo de testes possíveis
- Deve ser possível utilizar a biblioteca diretamente (Não apenas a CLI) para efetuar os testes
- Utilize dos príncipios do bom código, escreva com commits bem descritivos, utilize Design Patterns (DRY, SOLID, e etc)
- Atualize este documento com quaisquers informações pertinentes para rodar o projeto

### Como fazer o teste

- Faça um fork ou clone desse projeto no seu próprio repositório e faça o trabalho
- Quando terminar, envie o link do repositório para gustavo@evotto.com.br com quaisquer outras informações necessárias
