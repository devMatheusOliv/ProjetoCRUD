<%-- 
    Document   : resultadoConsultaVendaId.jsp
    Created on : 10 de abr. de 2026
    Author     : mathe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Venda"%>
<%@page import="model.ItemVenda"%>
<%
    Venda venda = (Venda) request.getAttribute("venda");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consulta Venda por ID</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f5f5f4; color: #1c1917; min-height: 100vh; padding: 40px 0; }
        .page { max-width: 700px; margin: 0 auto; padding: 0 24px; }
        .back { display: inline-flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 600; color: #78716c; text-decoration: none; margin-bottom: 24px; transition: color 0.15s; }
        .back:hover { color: #1c1917; }
        h1 { font-size: 1.1rem; font-weight: 600; color: #1c1917; margin-bottom: 20px; }
        .msg { font-size: 0.85rem; padding: 12px 16px; border-radius: 7px; background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; margin-bottom: 20px; }
        .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 10px; padding: 22px; margin-bottom: 16px; }
        .section-label { font-size: 0.68rem; font-weight: 600; color: #a8a29e; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 12px; }
        table { width: 100%; border-collapse: collapse; font-size: 0.83rem; }
        th, td { padding: 9px 12px; text-align: left; border-bottom: 1px solid #f0eeec; }
        th { font-size: 0.72rem; font-weight: 600; color: #78716c; }
        tbody tr:last-child td { border-bottom: none; }
        tfoot td { font-weight: 600; color: #1c1917; padding-top: 12px; border-top: 1px solid #e7e5e4; border-bottom: none; }
        .badge { display: inline-block; background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; border-radius: 5px; font-size: 0.72rem; font-weight: 600; padding: 2px 10px; }
    </style>
</head>
<body>
<div class="page">
    <a class="back" href="index.jsp">← Voltar ao Sistema</a>
    <h1>Consulta de Venda por ID</h1>

    <% if (venda != null) { %>
    <div class="card">
        <p class="section-label">Detalhes da Venda</p>
        <table>
            <tr><th>ID</th><td><span class="badge">#<%= venda.getId() %></span></td></tr>
            <tr><th>Nome do Tênis</th><td><%= venda.getNomeTenis() %></td></tr>
            <tr><th>Data</th><td><%= venda.getDataVendaFormatada() %></td></tr>
            <% 
                String f = venda.getFormaPagamento();
                String descPagamento = (f == null) ? "Não informada" : (f.equals("pix") ? "PIX" : (f.equals("cartao") ? "Cartão de Crédito/Débito" : f));
            %>
            <tr><th>Forma de Pagamento</th><td><%= descPagamento %></td></tr>
            <tr><th>Opcionais (Decorator)</th><td><%= venda.getOpcionais() != null && !venda.getOpcionais().isEmpty() ? venda.getOpcionais() : "Nenhum" %></td></tr>
            <tr><th>Total dos Itens</th><td>R$ <%= String.format("%.2f", venda.getTotal()) %></td></tr>
            <tr><th>Valor Final (com Opcionais)</th><td><strong style="color:#16a34a; font-size:1rem;">R$ <%= String.format("%.2f", venda.getValorFinal() > 0 ? venda.getValorFinal() : venda.getTotal()) %></strong></td></tr>
        </table>
    </div>

    <div class="card">
        <p class="section-label">Itens da Venda</p>
        <% if (venda.getItens() != null && !venda.getItens().isEmpty()) { %>
        <table>
            <thead>
                <tr><th>#</th><th>Produto</th><th>Qtd</th><th>Preço Unit.</th><th>Subtotal</th></tr>
            </thead>
            <tbody>
            <% int n = 1; for (ItemVenda item : venda.getItens()) { %>
                <tr>
                    <td><%= n++ %></td>
                    <td>#<%= item.getIdProduto() %> - <%= item.getNomeProduto() != null ? item.getNomeProduto() : "" %></td>
                    <td><%= item.getQuantidade() %></td>
                    <td>R$ <%= String.format("%.2f", item.getPrecoUnitario()) %></td>
                    <td>R$ <%= String.format("%.2f", item.getSubtotal()) %></td>
                </tr>
            <% } %>
            </tbody>
            <tfoot>
                <tr><td colspan="4">Total Geral (com Opcionais)</td><td><strong style="color:#16a34a;">R$ <%= String.format("%.2f", venda.getValorFinal() > 0 ? venda.getValorFinal() : venda.getTotal()) %></strong></td></tr>
            </tfoot>
        </table>
        <% } else { %>
        <p style="font-size:0.83rem; color:#a8a29e;">Nenhum item encontrado para esta venda.</p>
        <% } %>
    </div>

    <% } else { %>
    <div class="msg">Venda não encontrada.</div>
    <% } %>
</div>
</body>
</html>
