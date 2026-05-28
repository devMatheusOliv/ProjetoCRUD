# 🛒 Sistema de Produtos e Vendas (CRUD Java Web NoSQL)

Este projeto é uma aplicação acadêmica de gestão de estoque e vendas de calçados, desenvolvida para demonstrar a utilização prática de Java Web com JSP integrada a um banco de dados NoSQL na nuvem (**Firebase Realtime Database**).

O objetivo principal é construir uma solução completa de CRUD de produtos e controle de vendas, mantendo o código organizado, de fácil compreensão e alinhado aos princípios estudados na disciplina de Engenharia de Software / Padrões de Projetos.

Toda a persistência de dados (tanto o estoque de produtos quanto o histórico de vendas) é realizada no Firebase Realtime Database através de requisições HTTP REST com `HttpURLConnection`.

---

## 🎯 O que este projeto entrega

- **Autenticação:** Sistema simples de login para controle de acesso às funcionalidades.
- **Gerenciamento de Produtos:** Cadastro, consulta por ID, listagem de todos, atualização de dados e exclusão de produtos no Firebase.
- **Registro de Vendas:** Registro de pedidos calculados dinamicamente com opcionais e descontos aplicados.
- **Consulta de Estoque:** Atualização automática do estoque disponível de produtos após a realização de uma venda.
- **Banco de Dados 100% NoSQL:** Persistência escalável e na nuvem usando Firebase Realtime Database.

---

## 🧩 Padrões de projeto aplicados

O projeto foi estruturado com base em padrões de projeto (Design Patterns) clássicos para garantir flexibilidade e manutenibilidade:

- **MVC (Model-View-Controller)**
  - `model/`: contém as entidades de domínio (`Produto`, `Venda`, `ItemVenda`) e suas regras.
  - `controller/`: servlets (`ControleProduto`, `ControleVenda`) que capturam as requisições HTTP e as encaminham para a camada correspondente.
  - `web/`: páginas em JSP (JavaServer Pages) para a interface do usuário.

- **DAO (Data Access Object)**
  - `ProdutoDAO` e `VendaDAO`: separam toda a mecânica de acesso a dados da lógica de controle e do domínio, convertendo e persistindo informações no Firebase NoSQL.

- **Command**
  - Cada operação no sistema (como cadastrar produto, deletar ou realizar venda) é isolada em sua própria classe de ação (`CadastraProdutoAction`, `DeletaProdutoAction`, etc.) que implementa a interface `ICommand`. O Servlet do Controller apenas mapeia as rotas dinamicamente, mantendo o código limpo.

- **Builder**
  - Utilizado na construção dos objetos `Produto`, `Venda` e `ItemVenda` (`ProdutoBuilder`, `VendaBuilder` e `ItemVendaBuilder`), garantindo maior flexibilidade e fluidez na criação dessas entidades sem sobrecarregar construtores.

- **Decorator**
  - Implementado de forma clássica no pacote `decorator` (`Calcado`, `Tenis`, `PromocaoOpcionalDecorator`, `Desconto`, `Meia`, `EmbalagemPresente`) para calcular dinamicamente a descrição e o preço final de um calçado de acordo com os adicionais selecionados no checkout da venda.

---

## 🧭 Estrutura do projeto

### `src/java/`

- `command/` — as ações específicas do sistema (implementações de `ICommand`).
- `controller/` — servlets que centralizam as requisições HTTP.
- `DAO/` — isolamento da persistência e parsing de dados do Firebase.
- `decorator/` — estrutura do padrão de projeto Decorator para opcionais do produto.
- `model/` — entidades do domínio e seus Builders.
- `util/` — ajudantes de requisição REST HTTP do Firebase e manipulação manual de JSON.

### `web/`

- Páginas JSP que compõem a interface visual do sistema.
- Folhas de estilo CSS para formatação visual e responsiva.

---

## ⚙️ Tecnologias usadas

- Java Web (Servlets + JSP)
- Apache Tomcat
- Firebase Realtime Database (REST API)
- NetBeans IDE / Ant build structure
- Railway (Configuração pronta de deploy em `railway.toml`)
