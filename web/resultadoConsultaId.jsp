<%-- 
    Document   : resultadoConsultaId.jsp
    Author     : mathe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Produto"%>
<%
    Produto produto = (Produto) request.getAttribute("produto");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consulta Produto por ID</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f5f5f4; color: #1c1917; min-height: 100vh; padding: 40px 0; }
        .page { max-width: 560px; margin: 0 auto; padding: 0 24px; }
        .back { display: inline-flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 600; color: #78716c; text-decoration: none; margin-bottom: 24px; transition: color 0.15s; }
        .back:hover { color: #1c1917; }
        h1 { font-size: 1.1rem; font-weight: 600; color: #1c1917; margin-bottom: 20px; }
        .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 10px; padding: 22px; }
        .section-label { font-size: 0.68rem; font-weight: 600; color: #a8a29e; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 14px; }
        table { width: 100%; border-collapse: collapse; font-size: 0.84rem; }
        th, td { padding: 9px 12px; text-align: left; border-bottom: 1px solid #f0eeec; }
        th { font-size: 0.72rem; font-weight: 600; color: #78716c; width: 40%; }
        tr:last-child td { border-bottom: none; }
        .msg { font-size: 0.85rem; padding: 12px 16px; border-radius: 7px; background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; }
    </style>
</head>
<body>
<div class="page">
    <a class="back" href="index.jsp">← Voltar ao Sistema</a>
    <h1>Consulta de Produto por ID</h1>

    <% if (produto != null) { %>
    <div class="card">
        <p class="section-label">Dados do Produto</p>
        <table>
            <tr><th>ID</th><td>#<%= produto.getId() %></td></tr>
            <tr><th>Descrição</th><td><%= produto.getDescricao() %></td></tr>
            <tr><th>Preço</th><td>R$ <%= String.format("%.2f", produto.getPreco()) %></td></tr>
            <tr><th>Fornecedor</th><td><%= produto.getFornecedor() %></td></tr>
            <tr><th>Qtd. Estoque</th><td><%= produto.getQuantidadeEstoque() %></td></tr>
            <tr><th>Cor</th><td><%= produto.getCor() %></td></tr>
            <tr><th>Marca</th><td><%= produto.getMarca() %></td></tr>
            <tr><th>Tamanho</th><td><%= produto.getTamanho() %></td></tr>
            <tr><th>Material</th><td><%= produto.getMaterial() %></td></tr>
            <tr><th>Avaliação</th><td><%= produto.getAvaliacao() %></td></tr>
        </table>
    </div>
    <% } else { %>
    <div class="msg">Produto não encontrado.</div>
    <% } %>
</div>
</body>
</html>
