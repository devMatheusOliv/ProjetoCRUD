<%--
    Document   : resultadocadastrar.jsp
    Author     : mathe
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Resultado</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f5f5f4; color: #1c1917; min-height: 100vh; padding: 40px 0; }
        .page { max-width: 500px; margin: 0 auto; padding: 0 24px; }
        .back { display: inline-flex; align-items: center; gap: 6px; font-size: 0.78rem; font-weight: 600; color: #78716c; text-decoration: none; margin-bottom: 24px; transition: color 0.15s; }
        .back:hover { color: #1c1917; }
        h1 { font-size: 1.1rem; font-weight: 600; color: #1c1917; margin-bottom: 20px; }
        .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 10px; padding: 22px; }
        .msg-ok   { font-size: 0.85rem; padding: 12px 16px; border-radius: 7px; background: #f0fdf4; border: 1px solid #bbf7d0; color: #15803d; }
        .msg-erro { font-size: 0.85rem; padding: 12px 16px; border-radius: 7px; background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; }
    </style>
</head>
<body>
<div class="page">
    <a class="back" href="index.jsp">← Voltar ao Sistema</a>
    <h1>Resultado da Operação</h1>
    <div class="card">
        <%
            String msg = (String) request.getAttribute("msg");
            boolean isErro = (msg != null && msg.toLowerCase().contains("erro"));
        %>
        <p class="<%= isErro ? "msg-erro" : "msg-ok" %>">
            <%= msg != null ? msg : "Operação concluída." %>
        </p>
    </div>
</div>
</body>
</html>
