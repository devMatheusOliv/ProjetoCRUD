<%-- 
    Document   : resultadoVenda.jsp
    Created on : 10 de abr. de 2026
    Author     : mathe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Venda"%>
<%@page import="model.ItemVenda"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Resultado da Venda</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="estilos/stylesVenda.css" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f5f5f4; color: #1c1917; min-height: 100vh; padding: 40px 0; }
        .page { max-width: 700px; margin: 0 auto; padding: 0 24px; }
        .back { display: inline-flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 600; color: #78716c; text-decoration: none; margin-bottom: 24px; transition: color 0.15s; }
        .back:hover { color: #1c1917; }
        h1 { font-size: 1.1rem; font-weight: 600; color: #1c1917; margin-bottom: 20px; }
        .msg { font-size: 0.85rem; padding: 12px 16px; border-radius: 7px; background: #f0fdf4; border: 1px solid #bbf7d0; color: #15803d; margin-bottom: 20px; }
        .msg.erro { background: #fef2f2; border-color: #fecaca; color: #dc2626; }
        .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 10px; padding: 22px; margin-bottom: 16px; }
        .section-label { font-size: 0.68rem; font-weight: 600; color: #a8a29e; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 12px; }
        table { width: 100%; border-collapse: collapse; font-size: 0.83rem; }
        th, td { padding: 9px 12px; text-align: left; border-bottom: 1px solid #f0eeec; }
        th { font-size: 0.72rem; font-weight: 600; color: #78716c; }
        tbody tr:last-child td { border-bottom: none; }
        tfoot td { font-weight: 600; color: #1c1917; padding-top: 12px; border-top: 1px solid #e7e5e4; border-bottom: none; }
    </style>
</head>
<body>
<div class="page">
    <a class="back" href="index.jsp">← Voltar ao Sistema</a>
    <h1>Registro de Venda</h1>

    <%
        String msg = (String) request.getAttribute("msg");
        Venda venda = (Venda) request.getAttribute("venda");
        String infoPagamento = (String) request.getAttribute("infoPagamento");
        String pedidoValorFinal = (String) request.getAttribute("pedidoValorFinal");
        String pedidoDescricao  = (String) request.getAttribute("pedidoDescricao");
        boolean isErro = (msg != null && msg.toLowerCase().contains("erro"));
    %>

    <% if (msg != null && !msg.isEmpty()) { %>
        <div class="msg <%= isErro ? "erro" : "" %>"><%= msg %></div>
    <% } %>

    <% if (venda != null) { %>
    <div class="card">
        <p class="section-label">Detalhes</p>
        <table>
            <tr><th>ID da Venda</th><td>#<%= venda.getId() %></td></tr>
            <tr><th>Nome do Tênis</th><td><%= venda.getNomeTenis() %></td></tr>
            <tr><th>Data</th><td><%= venda.getDataVendaFormatada() %></td></tr>
            <% if (infoPagamento != null && !infoPagamento.isEmpty()) { %>
            <tr><th>Forma de Pagamento</th><td><%= infoPagamento %></td></tr>
            <% } %>
        </table>
    </div>

    <% if (venda.getItens() != null && !venda.getItens().isEmpty()) { %>
    <div class="card">
        <p class="section-label">Itens da Venda</p>
        <table>
            <thead>
                <tr><th>Produto</th><th>Qtd</th><th>Preço Unit.</th><th>Subtotal</th></tr>
            </thead>
            <tbody>
            <% for (ItemVenda item : venda.getItens()) { %>
                <tr>
                    <td>#<%= item.getIdProduto() %> - <%= item.getNomeProduto() != null ? item.getNomeProduto() : "" %></td>
                    <td><%= item.getQuantidade() %></td>
                    <td>R$ <%= String.format("%.2f", item.getPrecoUnitario()) %></td>
                    <td>R$ <%= String.format("%.2f", item.getSubtotal()) %></td>
                </tr>
            <% } %>
            </tbody>
            <tfoot>
                <tr><td colspan="3">Total (sem opcionais)</td><td>R$ <%= String.format("%.2f", venda.getTotal()) %></td></tr>
            </tfoot>
        </table>
    </div>
    <% } %>

    
    <% if (pedidoDescricao != null && pedidoValorFinal != null) { %>
    <div class="decorator-result">
        <p class="section-label">🎁 Opcionais Aplicados (Decorator)</p>
        <div class="decorator-descricao"><%= pedidoDescricao %></div>
        <div class="decorator-total">
            <span>Valor Final do Pedido</span>
            <span>R$ <%= pedidoValorFinal %></span>
        </div>
    </div>
    <% } %>
    

    <% } %>
</div>
</body>
</html>
