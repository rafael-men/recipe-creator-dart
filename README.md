# 📘 App de Receitas Culinárias
 Um aplicativo simples para gerenciar receitas, com:
 
✅ Autenticação por e-mail/senha (Firebase Auth)
✅ Armazenamento local rápido (Hive)
✅ Lista, criação e favoritos de receitas

## 🔧 Como Rodar o Projeto

Pré-requisitos:

- Flutter 
- Dart

### Passos
- Clone o repositório

```bash
git clone https://github.com/seu-usuario/app-receitas.git  
cd my_recipe_book
```
- Instale as dependências

```bash
flutter pub get
```

- Inicie o app

```bash
flutter run

2
```

- A aplicação iniciará numa guia do chrome.

## 🛠 Tecnologias Usadas
- Flutter – Interface do app
- Firebase Auth – Login/Cadastro
- Hive – Armazenamento offline
- Provider – Gerenciamento de estado

## 📂 Estrutura Básica
text
lib/  
├── main.dart          # Início do app  
├── models/            # Modelos (ex: Recipe)  
├── services/          # Firebase e Hive  
├── pages/           # Telas (login, home, etc.)  
└── widgets/           # Componentes reutilizáveis  


## 🤝 Quer Contribuir?

Faça um fork do projeto.
Crie uma branch (git checkout -b sua-feature).
Envie um Pull Request.

