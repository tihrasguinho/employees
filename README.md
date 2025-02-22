# Teste Prático BeTalent (Flutter)

## 📱 Employees

Employees é um aplicativo desenvolvido em Flutter seguindo a nova arquitetura proposta pela equipe Flutter (MVVM). O objetivo deste projeto é demonstrar boas práticas de desenvolvimento mobile, aplicando a nova estrutura modularizada do Flutter. Nele é possível carregar uma lista de funcionários de uma api simulada e visualizar seus dados detalhados. Também é possível fazer busca por nome, cargo ou telefone no campo de pesquisas.

### 🏗 Arquitetura e Tecnologias

- **Arquitetura:** MVVM seguindo a [Proposta do Flutter](https://docs.flutter.dev/app-architecture)
- **Framework:** Flutter (Dart)
- **Gerenciamento de Estado:** (ex: Provider, ChangeNotifier)

### 📂 Estrutura do projeto

```bash
lib/
 ├── core/          # Configurações globais, estilos, temas e outros
 ├── data/          # Fontes de dados (APIs, banco de dados)
 ├── domain/        # Modelos e regras de negócio
 ├── routing/       # Definições de rotas
 ├── ui/            # Widgets, telas e gerenciamento de estado
 ├── main.dart      # Ponto de entrada do app
```

### 🧪 Testes

```bash
flutter test
```

### 🔧 Como rodar o projeto

```bash
# Clone o repositório
git clone https://github.com/tihrhasguinho/employees.git

# Entre na pasta do projeto
cd employees

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

### 📝 Observações

Dentro do diretório `.vscode` tem duas configurações, uma para rodar o projeto no emulador e outra para rodar na web.