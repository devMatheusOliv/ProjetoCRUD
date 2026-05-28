<%-- 
    Document   : resultadoEstoque.jsp
    Created on : 10 de abr. de 2026
    Author     : mathe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Estoque Disponível</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f5f5f4; color: #1c1917; min-height: 100vh; padding: 40px 0; }
        .page { max-width: 500px; margin: 0 auto; padding: 0 24px; }
        .back { display: inline-flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 600; color: #78716c; text-decoration: none; margin-bottom: 24px; transition: color 0.15s; }
        .back:hover { color: #1c1917; }
        h1 { font-size: 1.1rem; font-weight: 600; color: #1c1917; margin-bottom: 20px; }
        .msg { font-size: 0.85rem; padding: 12px 16px; border-radius: 7px; background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; margin-bottom: 20px; }
        .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 10px; padding: 22px; }
        .section-label { font-size: 0.68rem; font-weight: 600; color: #a8a29e; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 14px; }
        table { width: 100%; border-collapse: collapse; font-size: 0.85rem; }
        th, td { padding: 10px 12px; text-align: left; border-bottom: 1px solid #f0eeec; }
        th { font-size: 0.72rem; font-weight: 600; color: #78716c; }
        tr:last-child td { border-bottom: none; }
        .badge-ok   { display: inline-block; background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; border-radius: 5px; font-size: 0.8rem; font-weight: 600; padding: 3px 12px; }
        .badge-zero { display: inline-block; background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; border-radius: 5px; font-size: 0.8rem; font-weight: 600; padding: 3px 12px; }
    </style>
</head>
<body>
<div class="page">
    <a class="back" href="index.jsp">← Voltar ao Sistema</a>
    <h1>Estoque Disponível</h1>

    <%
        Integer estoque  = (Integer) request.getAttribute("estoqueDisponivel");
        Integer idProd   = (Integer) request.getAttribute("idProdutoConsultado");
        String  msg      = (String)  request.getAttribute("msg");
        String  desc     = (String)  request.getAttribute("descricaoProduto");
    %>

    <% if (msg != null && !msg.isEmpty()) { %>
        <div class="msg"><%= msg %></div>
    <% } %>

    <% if (estoque != null && idProd != null) { %>
    <div class="card">
        <p class="section-label">Resultado</p>
        <table>
            <tr>
                <th>ID do Produto</th>
                <td>#<%= idProd %></td>
            </tr>
            <tr>
                <th>Nome / Descrição</th>
                <td style="font-weight: 500;"><%= desc != null ? desc : "—" %></td>
            </tr>
            <tr>
                <th>Qtd. em Estoque</th>
                <td>
                    <% if (estoque > 0) { %>
                        <span class="badge-ok"><%= estoque %> unidade<%= estoque != 1 ? "s" : "" %></span>
                    <% } else { %>
                        <span class="badge-zero">Sem estoque</span>
                    <% } %>
                </td>
            </tr>
        </table>
    </div>
    <% } %>
</div>
</body>
</html>
