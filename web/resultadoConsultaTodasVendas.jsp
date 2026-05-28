<%-- 
    Document   : resultadoConsultaTodasVendas.jsp
    Created on : 10 de abr. de 2026
    Author     : mathe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Venda"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Todas as Vendas</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f5f5f4; color: #1c1917; min-height: 100vh; padding: 40px 0; }
        .page { max-width: 760px; margin: 0 auto; padding: 0 24px; }
        .back { display: inline-flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 600; color: #78716c; text-decoration: none; margin-bottom: 24px; transition: color 0.15s; }
        .back:hover { color: #1c1917; }
        h1 { font-size: 1.1rem; font-weight: 600; color: #1c1917; margin-bottom: 20px; }
        .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 10px; padding: 22px; }
        .section-label { font-size: 0.68rem; font-weight: 600; color: #a8a29e; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 14px; }
        table { width: 100%; border-collapse: collapse; font-size: 0.83rem; }
        th, td { padding: 10px 12px; text-align: left; border-bottom: 1px solid #f0eeec; }
        th { font-size: 0.72rem; font-weight: 600; color: #78716c; }
        tbody tr:hover { background: #fafaf9; }
        tbody tr:last-child td { border-bottom: none; }
        .link-detalhe { font-size: 0.75rem; font-weight: 600; color: #2563eb; text-decoration: none; }
        .link-detalhe:hover { text-decoration: underline; }
        .empty { font-size: 0.83rem; color: #a8a29e; }
    </style>
</head>
<body>
<div class="page">
    <a class="back" href="index.jsp">← Voltar ao Sistema</a>
    <h1>Todas as Vendas</h1>

    <div class="card">
        <p class="section-label">Histórico de Vendas</p>
        <%
            List<Venda> listaVendas = (List<Venda>) request.getAttribute("listaVendas");
        %>
        <% if (listaVendas != null && !listaVendas.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>ID da Venda</th>
                    <th>Nome do Tênis</th>
                    <th>Data</th>
                    <th>Forma Pgto</th>
                    <th>Opcionais (Decorator)</th>
                    <th>Valor Final</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody>
            <% for (Venda v : listaVendas) { %>
                <tr>
                    <td>#<%= v.getId() %></td>
                    <td><%= v.getNomeTenis() %></td>
                    <td><%= v.getDataVendaFormatada() %></td>
                    <td>
                        <% 
                            String f = v.getFormaPagamento();
                            String descPagamento = (f == null) ? "-" : (f.equals("pix") ? "PIX" : (f.equals("cartao") ? "Cartão" : f));
                            out.print(descPagamento);
                        %>
                    </td>
                    <td><%= v.getOpcionais() != null && !v.getOpcionais().isEmpty() ? v.getOpcionais() : "Nenhum" %></td>
                    <td><strong>R$ <%= String.format("%.2f", v.getValorFinal() > 0 ? v.getValorFinal() : v.getTotal()) %></strong></td>
                    <td>
                        <a class="link-detalhe"
                           href="ControleVenda?btnop=ConsultaVendaByIdAction&txtidvenda=<%= v.getId() %>">
                            Ver itens →
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p class="empty">Nenhuma venda registrada no sistema.</p>
        <% } %>
    </div>
</div>
</body>
</html>
