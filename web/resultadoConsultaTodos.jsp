<%-- 
    Document   : resultadoConsultaTodos.jsp
    Author     : mathe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Produto"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Estoque da Loja</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f5f5f4; color: #1c1917; min-height: 100vh; padding: 40px 0; }
        .page { max-width: 1000px; margin: 0 auto; padding: 0 24px; }
        .back { display: inline-flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 600; color: #78716c; text-decoration: none; margin-bottom: 24px; transition: color 0.15s; }
        .back:hover { color: #1c1917; }
        h1 { font-size: 1.1rem; font-weight: 600; color: #1c1917; margin-bottom: 20px; }
        .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 10px; padding: 22px; }
        .section-label { font-size: 0.68rem; font-weight: 600; color: #a8a29e; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 14px; }
        table { width: 100%; border-collapse: collapse; font-size: 0.82rem; }
        th, td { padding: 9px 12px; text-align: left; border-bottom: 1px solid #f0eeec; white-space: nowrap; }
        th { font-size: 0.70rem; font-weight: 600; color: #78716c; background: #fafaf9; }
        tbody tr:hover { background: #fafaf9; }
        tbody tr:last-child td { border-bottom: none; }
        .empty { font-size: 0.83rem; color: #a8a29e; }
    </style>
</head>
<body>
<div class="page">
    <a class="back" href="index.jsp">← Voltar ao Sistema</a>
    <h1>Estoque da Loja</h1>

    <div class="card">
        <p class="section-label">Estoque Atualizado</p>
        <%
            List<Produto> lista = (List<Produto>) request.getAttribute("listaProdutos");
        %>
        <% if (lista != null && !lista.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descrição</th>
                    <th>Preço</th>
                    <th>Fornecedor</th>
                    <th>Estoque</th>
                    <th>Cor</th>
                    <th>Marca</th>
                    <th>Tamanho</th>
                    <th>Material</th>
                    <th>Avaliação</th>
                </tr>
            </thead>
            <tbody>
            <% for (Produto p : lista) { %>
                <tr>
                    <td>#<%= p.getId() %></td>
                    <td><%= p.getDescricao() %></td>
                    <td>R$ <%= String.format("%.2f", p.getPreco()) %></td>
                    <td><%= p.getFornecedor() %></td>
                    <td><%= p.getQuantidadeEstoque() %></td>
                    <td><%= p.getCor() %></td>
                    <td><%= p.getMarca() %></td>
                    <td><%= p.getTamanho() %></td>
                    <td><%= p.getMaterial() %></td>
                    <td><%= p.getAvaliacao() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p class="empty">Nenhum produto encontrado.</p>
        <% } %>
    </div>
</div>
</body>
</html>
