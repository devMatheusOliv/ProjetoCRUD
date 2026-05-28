<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("usuarioLogado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String usuarioLogado = (String) session.getAttribute("usuarioLogado");
%>
    <%@page import="DAO.ProdutoDAO" %>
        <%@page import="model.Produto" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
                <html lang="pt-BR">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Sistema de Loja</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Outfit:wght@400;500;600&display=swap"
                        rel="stylesheet">
                    <style>
                        *,
                        *::before,
                        *::after {
                            box-sizing: border-box;
                            margin: 0;
                            padding: 0;
                        }

                        body {
                            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                            background: linear-gradient(135deg, #fdfbf7 0%, #f4f1ea 100%);
                            color: #333;
                            min-height: 100vh;
                            display: flex;
                            flex-direction: column;
                        }

                        .header {
                            height: auto;
                            padding: 22px 0;
                            background: transparent;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                        }

                        .header h1 {
                            font-size: 2.0rem;
                            font-weight: 800;
                            letter-spacing: -0.5px;
                            color: #2d3a33;
                            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.8);
                        }

                        .main-wrapper {
                            max-width: 1200px;
                            width: 95%;
                            margin: 0 auto 24px;
                        }

                        .card {
                            background: white;
                            border-radius: 12px;
                            transition: border-radius 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                            padding: 24px;
                        }

                        .shadow {
                            box-shadow: inset 0 -3em 3em rgba(0, 0, 0, 0.03),
                                0 0 0 2px rgba(255, 255, 255, 0.8),
                                0.3em 0.3em 1em rgba(0, 0, 0, 0.08);
                        }

                        .workspace {
                            display: flex;
                            gap: 32px;
                            flex: 1;
                        }

                        .divider-v {
                            width: 1px;
                            background: #e5e5e0;
                        }

                        .painel {
                            flex: 1;
                            display: flex;
                            flex-direction: column;
                        }

                        .painel-head {
                            padding-bottom: 16px;
                            border-bottom: 2px solid #d1e0d7;
                            display: flex;
                            align-items: center;
                            gap: 10px;
                            margin-bottom: 16px;
                        }

                        .painel-head-icon {
                            font-size: 1.3rem;
                        }

                        .painel-head-title {
                            font-size: 1.2rem;
                            font-weight: 700;
                            color: #2d3a33;
                        }

                        .painel-tag {
                            display: none;
                        }

                        .painel-body {
                            flex: 1;
                        }

                        .section {
                            margin-bottom: 18px;
                        }

                        .section-label {
                            font-size: 0.8rem;
                            font-weight: 700;
                            color: #436d52;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                            margin-bottom: 12px;
                            border-bottom: 1px dashed #d1e0d7;
                            padding-bottom: 4px;
                        }

                        .form-grid {
                            display: grid;
                            grid-template-columns: 1fr 1fr;
                            gap: 12px;
                        }

                        .form-group label {
                            display: block;
                            font-size: 0.78rem;
                            font-weight: 600;
                            color: #647269;
                            margin-bottom: 4px;
                            text-transform: uppercase;
                        }

                        input[type="text"],
                        input[type="number"],
                        input[type="date"] {
                            width: 100%;
                            padding: 10px 14px;
                            font-family: 'Inter', sans-serif;
                            font-size: 0.9rem;
                            color: #2d3a33;
                            background: #fdfbf8;
                            border: 1px solid #d1e0d7;
                            border-radius: 6px;
                            transition: all 0.2s;
                        }

                        input:focus {
                            outline: none;
                            border-color: #6eb28f;
                            background: #fff;
                            box-shadow: 0 0 0 3px rgba(110, 178, 143, 0.15);
                        }

                        .sep {
                            height: 1px;
                            background: #e5e5e0;
                            margin: 20px 0;
                        }

                        .btn-row {
                            display: grid;
                            grid-template-columns: 1fr 1fr;
                            gap: 10px;
                        }

                        .pushable {
                            position: relative;
                            background: transparent;
                            padding: 0px;
                            border: none;
                            cursor: pointer;
                            outline-offset: 4px;
                            outline-color: #5c8f6f;
                            transition: filter 250ms;
                            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
                            width: 100%;
                        }

                        .btn-shadow {
                            position: absolute;
                            top: 0;
                            left: 0;
                            height: 100%;
                            width: 100%;
                            background: rgba(0, 0, 0, 0.1);
                            border-radius: 8px;
                            filter: blur(2px);
                            will-change: transform;
                            transform: translateY(2px);
                            transition: transform 600ms cubic-bezier(0.3, 0.7, 0.4, 1);
                        }

                        .btn-edge {
                            position: absolute;
                            top: 0;
                            left: 0;
                            height: 100%;
                            width: 100%;
                            border-radius: 8px;
                            background: linear-gradient(to right,
                                    #2d4a38 0%,
                                    #436b52 8%,
                                    #436b52 92%,
                                    #2d4a38 100%);
                        }

                        .btn-front {
                            display: block;
                            position: relative;
                            border-radius: 8px;
                            background: #5c8f6f;
                            padding: 10px 16px;
                            color: white;
                            font-weight: 500;
                            font-family: 'Outfit', sans-serif;
                            letter-spacing: 0.2px;
                            font-size: 0.9rem;
                            transform: translateY(-4px);
                            transition: transform 600ms cubic-bezier(0.3, 0.7, 0.4, 1);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            text-align: center;
                        }

                        .pushable:hover {
                            filter: brightness(110%);
                        }

                        .pushable:hover .btn-front {
                            transform: translateY(-6px);
                            transition: transform 250ms cubic-bezier(0.3, 0.7, 0.4, 1.5);
                        }

                        .pushable:active .btn-front {
                            transform: translateY(-2px);
                            transition: transform 34ms;
                        }

                        .pushable:hover .btn-shadow {
                            transform: translateY(4px);
                            transition: transform 250ms cubic-bezier(0.3, 0.7, 0.4, 1.5);
                        }

                        .pushable:active .btn-shadow {
                            transform: translateY(1px);
                            transition: transform 34ms;
                        }

                        .pushable:focus:not(:focus-visible) {
                            outline: none;
                        }

                        .header-bar {
                            display: flex;
                            align-items: center;
                            justify-content: space-between;
                            padding: 14px 24px;
                            background: white;
                            border-bottom: 2px solid #d1e0d7;
                            margin-bottom: 24px;
                            border-radius: 12px;
                            box-shadow: inset 0 -3em 3em rgba(0,0,0,0.02),
                                0 0 0 2px rgba(255,255,255,0.8),
                                0.3em 0.3em 1em rgba(0,0,0,0.06);
                        }

                        .header-left h1 {
                            font-size: 1.5rem;
                            font-weight: 800;
                            color: #2d3a33;
                            letter-spacing: -0.4px;
                        }

                        .header-right {
                            display: flex;
                            align-items: center;
                            gap: 14px;
                        }

                        .user-badge {
                            display: flex;
                            align-items: center;
                            gap: 6px;
                            font-size: 0.84rem;
                            font-weight: 600;
                            color: #436d52;
                            background: #edf5f0;
                            border: 1px solid #d1e0d7;
                            padding: 6px 12px;
                            border-radius: 20px;
                        }

                        .btn-logout {
                            display: flex;
                            align-items: center;
                            gap: 6px;
                            font-size: 0.83rem;
                            font-weight: 600;
                            font-family: 'Outfit', sans-serif;
                            color: #b91c1c;
                            background: #fff5f5;
                            border: 1px solid #fca5a5;
                            padding: 7px 14px;
                            border-radius: 8px;
                            cursor: pointer;
                            text-decoration: none;
                            transition: background 0.2s, border-color 0.2s;
                        }

                        .btn-logout:hover {
                            background: #fee2e2;
                            border-color: #f87171;
                        }

                        @media (max-width: 900px) {
                            .workspace {
                                flex-direction: column;
                            }

                            .divider-v {
                                width: 100%;
                                height: 1px;
                                margin: 20px 0;
                            }
                        }
                    </style>
                </head>

                <body>

                    <div class="main-wrapper header-bar">
                        <div class="header-left">
                            <h1>&#128465; Sistema de Loja</h1>
                        </div>
                        <div class="header-right">
                            <span class="user-badge">&#128100; <%= usuarioLogado %></span>
                            <a href="ControleLogin?acao=logout" class="btn-logout">&#128682; Sair</a>
                        </div>
                    </div>

                    <div class="main-wrapper card shadow">
                        <div class="workspace">
                            <div class="painel">
                                <div class="painel-head">
                                    <span class="painel-head-icon">📦</span>
                                    <span class="painel-head-title">Pesquisa em Loja</span>
                                    <span class="painel-tag tag-produto">Produtos</span>
                                </div>

                                <div class="painel-body">
                                    <form action="ControleProduto" method="GET">

                                        <div class="section">
                                            <p class="section-label">Dados do Produto</p>
                                            <div class="form-grid">
                                                <div class="form-group">
                                                    <label>ID</label>
                                                    <input type="text" name="txtid" id="txtid" placeholder="—">
                                                </div>
                                                <div class="form-group">
                                                    <label>Descrição</label>
                                                    <input type="text" name="txtdescricao" id="txtdescricao"
                                                        placeholder="Nome do produto">
                                                </div>
                                                <div class="form-group">
                                                    <label>Preço (R$)</label>
                                                    <input type="text" name="txtpreco" id="txtpreco"
                                                        placeholder="249.90">
                                                </div>
                                                <div class="form-group">
                                                    <label>Fornecedor</label>
                                                    <input type="text" name="txtfornecedor" id="txtfornecedor"
                                                        placeholder="Ex: Nike Brasil">
                                                </div>
                                                <div class="form-group">
                                                    <label>Qtd. Estoque</label>
                                                    <input type="text" name="txtQuantidadeEstoque"
                                                        id="txtQuantidadeEstoque" placeholder="50">
                                                </div>
                                                <div class="form-group">
                                                    <label>Cor</label>
                                                    <input type="text" name="txtcor" id="txtcor"
                                                        placeholder="Ex: Preto">
                                                </div>
                                                <div class="form-group">
                                                    <label>Marca</label>
                                                    <input type="text" name="txtmarca" id="txtmarca"
                                                        placeholder="Ex: Nike">
                                                </div>
                                                <div class="form-group">
                                                    <label>Tamanho</label>
                                                    <input type="text" name="txttamanho" id="txttamanho"
                                                        placeholder="42">
                                                </div>
                                                <div class="form-group">
                                                    <label>Material</label>
                                                    <input type="text" name="txtmaterial" id="txtmaterial"
                                                        placeholder="Ex: Couro">
                                                </div>
                                                <div class="form-group">
                                                    <label>Avaliação</label>
                                                    <input type="text" name="txtavaliacao" id="txtavaliacao"
                                                        placeholder="4.5">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="sep"></div>

                                        <div class="section">
                                            <p class="section-label">Ações</p>
                                            <div class="btn-row">
                                                <button type="submit" name="btnop" value="CadastraProdutoAction"
                                                    class="pushable">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> CADASTRAR </span>
                                                </button>
                                                <button type="submit" name="btnop" value="AtualizaProdutoAction"
                                                    class="pushable">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> ATUALIZAR </span>
                                                </button>
                                                <button type="submit" name="btnop" value="DeletaProdutoAction"
                                                    class="pushable">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> DELETAR </span>
                                                </button>
                                                <button type="submit" name="btnop" value="ConsultaByIdProdutoAction"
                                                    class="pushable">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> CONSULTAR ID </span>
                                                </button>
                                                <button type="submit" name="btnop" value="ConsultaTodosProdutoAction"
                                                    class="pushable" style="grid-column: span 2;">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> CONSULTAR TODOS </span>
                                                </button>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>

                            <div class="divider-v"></div>

                            <div class="painel">
                                <div class="painel-head">
                                    <span class="painel-head-icon">🛒</span>
                                    <span class="painel-head-title">Gestão de Vendas</span>
                                    <span class="painel-tag tag-venda">Vendas</span>
                                </div>

                                <div class="painel-body">

                                    <div class="section">
                                        <p class="section-label">Registrar Venda</p>
                                        <form action="ControleVenda" method="POST">
                                            <div class="form-grid" style="margin-bottom:14px;">
                                                <div class="form-group">
                                                    <label>Nome do Tênis</label>
                                                    <select name="txtnometenis" id="txtnometenis" required
                                                        style="width: 100%; padding: 9px 12px; font-family: 'Inter', sans-serif; font-size: 0.88rem; color: #0f172a; background: #ffffff; border: 1px solid #94a3b8; border-radius: 6px; transition: all 0.15s ease;">
                                                        <option value="">-- Selecione o Tênis --</option>
                                                        <% ProdutoDAO guiDao=new ProdutoDAO(); List<Produto> ptStock =
                                                            guiDao.consultarTodos();
                                                            for(Produto pt : ptStock) {
                                                            %>
                                                            <option value="<%= pt.getDescricao() %>"
                                                                data-id="<%= pt.getId() %>"
                                                                data-preco="<%= pt.getPreco() %>">
                                                                <%= pt.getDescricao() %>
                                                            </option>
                                                            <% } %>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label>Data da Venda</label>
                                                    <input type="date" name="txtdatavenda" id="txtdatavenda">
                                                </div>
                                            </div>

                                            <div class="form-grid" style="margin-bottom:14px;">
                                                <div class="form-group">
                                                    <label>ID Produto</label>
                                                    <input type="number" name="txtidproduto" placeholder="1" min="1">
                                                </div>
                                                <div class="form-group">
                                                    <label>Quantidade</label>
                                                    <input type="number" name="txtquantidade" placeholder="1" min="1">
                                                </div>
                                                <div class="form-group">
                                                    <label>Preço Unitário (R$)</label>
                                                    <input type="text" name="txtprecounitario" placeholder="249.90">
                                                </div>
                                                <div class="form-group">
                                                    <label>Forma de Pagamento</label>
                                                    <select name="txtformapagamento" id="txtformapagamento" required
                                                        style="width: 100%; padding: 9px 12px; font-family: 'Inter', sans-serif; font-size: 0.88rem; color: #0f172a; background: #ffffff; border: 1px solid #94a3b8; border-radius: 6px; transition: all 0.15s ease;">
                                                        <option value="cartao">Cartão de Crédito/Débito</option>
                                                        <option value="pix">PIX</option>
                                                    </select>
                                                </div>
                                            </div>

                                            
                                            
                                            <div class="form-group" style="grid-column: span 2; margin-top: 10px; margin-bottom: 14px;">
                                                <label style="font-weight: 700; color: #436d52; margin-bottom: 8px;">&#127873; OPCIONAIS ADICIONAIS (DECORATOR)</label>
                                                <div style="display: flex; flex-direction: column; gap: 8px; background: #fdfbf8; border: 1px solid #d1e0d7; padding: 12px; border-radius: 6px;">
                                                    <label style="display: flex; align-items: center; gap: 8px; text-transform: none; font-size: 0.85rem; font-weight: normal; color: #333; margin-bottom: 0; cursor: pointer;">
                                                        <input type="checkbox" name="desconto2pares" value="on" style="cursor: pointer;">
                                                        Desconto de 2 pares (10% no pedido total)
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 8px; text-transform: none; font-size: 0.85rem; font-weight: normal; color: #333; margin-bottom: 0; cursor: pointer;">
                                                        <input type="checkbox" name="opcionalMeia" value="on" style="cursor: pointer;">
                                                        Meia (Adiciona R$ 19,90)
                                                    </label>
                                                    <label style="display: flex; align-items: center; gap: 8px; text-transform: none; font-size: 0.85rem; font-weight: normal; color: #333; margin-bottom: 0; cursor: pointer;">
                                                        <input type="checkbox" name="opcionalEmbalagem" value="on" style="cursor: pointer;">
                                                        Embalagem para presente (Adiciona R$ 10,00)
                                                    </label>
                                                </div>
                                            </div>

                                            <div class="btn-row" style="margin-top:12px;">
                                                <button type="submit" name="btnop" value="RegistraVendaAction"
                                                    class="pushable">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> REGISTRAR VENDA </span>
                                                </button>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="sep" style="margin: 16px 0;"></div>

                                    <div class="section">
                                        <p class="section-label">Consultas Rápidas</p>
                                        <div
                                            style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 12px;">
                                            <form action="ControleVenda" method="GET"
                                                style="display:flex; flex-direction:column; gap:8px;">
                                                <input type="number" name="txtidvenda" placeholder="ID da Venda" min="1"
                                                    required style="width:100%;">
                                                <button type="submit" name="btnop" value="ConsultaVendaByIdAction"
                                                    class="pushable">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> CONSULTAR </span>
                                                </button>
                                            </form>
                                            <form action="ControleVenda" method="GET"
                                                style="display:flex; flex-direction:column; gap:8px;">
                                                <input type="number" name="txtidprodutoestoque" placeholder="ID Produto"
                                                    min="1" required style="width:100%;">
                                                <button type="submit" name="btnop" value="ConsultaEstoqueAction"
                                                    class="pushable">
                                                    <span class="btn-shadow"></span>
                                                    <span class="btn-edge"></span>
                                                    <span class="btn-front"> VER ESTOQUE </span>
                                                </button>
                                            </form>
                                        </div>
                                        <form action="ControleVenda" method="GET">
                                            <button type="submit" name="btnop" value="ConsultaTodasVendasAction"
                                                class="pushable">
                                                <span class="btn-shadow"></span>
                                                <span class="btn-edge"></span>
                                                <span class="btn-front"> CONSULTAR TODAS AS VENDAS </span>
                                            </button>
                                        </form>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>

                    <script>
                        document.getElementById('txtnometenis').addEventListener('change', function () {
                            const opt = this.options[this.selectedIndex];
                            const id = opt.getAttribute('data-id');
                            const preco = opt.getAttribute('data-preco');
                            if (id && preco) {
                                const idInput = document.querySelector('input[name="txtidproduto"]');
                                const precoInput = document.querySelector('input[name="txtprecounitario"]');
                                if (idInput && precoInput) {
                                    idInput.value = id;
                                    precoInput.value = preco;
                                }
                            }
                        });

                        
                        const qtdInput = document.querySelector('input[name="txtquantidade"]');
                        const descontoCheckbox = document.querySelector('input[name="desconto2pares"]');
                        if (qtdInput && descontoCheckbox) {
                            function verificarDesconto() {
                                const qtd = parseInt(qtdInput.value) || 0;
                                if (qtd >= 2) {
                                    descontoCheckbox.checked = true;
                                } else {
                                    descontoCheckbox.checked = false;
                                }
                            }
                            qtdInput.addEventListener('input', verificarDesconto);
                            qtdInput.addEventListener('change', verificarDesconto);
                        }
                    </script>
                </body>

                </html>