<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuarioLogado") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
    boolean erro = "1".equals(request.getParameter("erro"));
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Loja de Tenis</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #fdfbf7 0%, #e8f0eb 50%, #f4f1ea 100%);
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        body::before {
            content: '';
            position: fixed;
            top: -120px;
            right: -120px;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(92,143,111,0.18) 0%, transparent 70%);
            pointer-events: none;
        }
        body::after {
            content: '';
            position: fixed;
            bottom: -100px;
            left: -100px;
            width: 360px;
            height: 360px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(110,178,143,0.14) 0%, transparent 70%);
            pointer-events: none;
        }

        .login-wrapper {
            width: 100%;
            max-width: 420px;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .brand {
            text-align: center;
            margin-bottom: 32px;
        }

        .brand-icon {
            font-size: 2.8rem;
            display: block;
            margin-bottom: 10px;
            filter: drop-shadow(0 2px 6px rgba(92,143,111,0.3));
        }

        .brand h1 {
            font-family: 'Outfit', sans-serif;
            font-size: 1.9rem;
            font-weight: 800;
            color: #2d3a33;
            letter-spacing: -0.5px;
        }

        .brand p {
            font-size: 0.88rem;
            color: #647269;
            margin-top: 4px;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 36px 32px;
            box-shadow:
                inset 0 -3em 3em rgba(0,0,0,0.02),
                0 0 0 2px rgba(255,255,255,0.9),
                0.3em 0.3em 1.2em rgba(0,0,0,0.09);
        }

        .card-title {
            font-size: 1.05rem;
            font-weight: 700;
            color: #2d3a33;
            margin-bottom: 6px;
        }

        .card-sub {
            font-size: 0.82rem;
            color: #8a9e91;
            margin-bottom: 28px;
            padding-bottom: 20px;
            border-bottom: 2px solid #d1e0d7;
        }

        .alert-error {
            background: #fff3f3;
            border: 1px solid #fca5a5;
            border-radius: 8px;
            padding: 12px 16px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.86rem;
            color: #b91c1c;
            margin-bottom: 20px;
            animation: shake 0.4s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            20%       { transform: translateX(-6px); }
            40%       { transform: translateX(6px); }
            60%       { transform: translateX(-4px); }
            80%       { transform: translateX(4px); }
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 0.78rem;
            font-weight: 700;
            color: #436d52;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        .input-wrap {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 13px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1rem;
            pointer-events: none;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 11px 14px 11px 40px;
            font-family: 'Inter', sans-serif;
            font-size: 0.92rem;
            color: #2d3a33;
            background: #fdfbf8;
            border: 1px solid #d1e0d7;
            border-radius: 8px;
            transition: all 0.2s;
        }

        input:focus {
            outline: none;
            border-color: #6eb28f;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(110,178,143,0.18);
        }

        .btn-login {
            position: relative;
            background: transparent;
            padding: 0;
            border: none;
            cursor: pointer;
            outline-offset: 4px;
            outline-color: #5c8f6f;
            transition: filter 250ms;
            width: 100%;
            margin-top: 8px;
        }

        .btn-shadow {
            position: absolute;
            top: 0; left: 0;
            height: 100%; width: 100%;
            background: rgba(0,0,0,0.12);
            border-radius: 10px;
            filter: blur(2px);
            transform: translateY(2px);
            transition: transform 600ms cubic-bezier(0.3,0.7,0.4,1);
        }

        .btn-edge {
            position: absolute;
            top: 0; left: 0;
            height: 100%; width: 100%;
            border-radius: 10px;
            background: linear-gradient(to right,
                #2d4a38 0%, #436b52 8%, #436b52 92%, #2d4a38 100%);
        }

        .btn-front {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            position: relative;
            border-radius: 10px;
            background: #5c8f6f;
            padding: 13px 20px;
            color: white;
            font-weight: 600;
            font-family: 'Outfit', sans-serif;
            font-size: 0.95rem;
            letter-spacing: 0.3px;
            transform: translateY(-4px);
            transition: transform 600ms cubic-bezier(0.3,0.7,0.4,1);
            border: 1px solid rgba(255,255,255,0.1);
        }

        .btn-login:hover { filter: brightness(110%); }
        .btn-login:hover .btn-front { transform: translateY(-6px); transition: transform 250ms cubic-bezier(0.3,0.7,0.4,1.5); }
        .btn-login:active .btn-front { transform: translateY(-2px); transition: transform 34ms; }
        .btn-login:hover .btn-shadow { transform: translateY(4px); transition: transform 250ms cubic-bezier(0.3,0.7,0.4,1.5); }
        .btn-login:active .btn-shadow { transform: translateY(1px); transition: transform 34ms; }

        .footer-note {
            text-align: center;
            font-size: 0.78rem;
            color: #a0ada4;
            margin-top: 24px;
        }
    </style>
</head>
<body>

    <div class="login-wrapper">

        <div class="brand">
            <span class="brand-icon">👟</span>
            <h1>Loja de Tenis</h1>
            <p>Gestão de Produtos &amp; Vendas</p>
        </div>

        <div class="card">
            <p class="card-title">Acesso ao Sistema</p>
            <p class="card-sub">Entre com suas credenciais para continuar</p>

            <% if (erro) { %>
            <div class="alert-error">
                <span>Usuário ou senha incorretos. Tente novamente.</span>
            </div>
            <% } %>

            <form action="ControleLogin" method="POST">
                <div class="form-group">
                    <label for="txtUsuario">Usuário</label>
                    <div class="input-wrap">

                        <input type="text" name="txtUsuario" id="txtUsuario"
                               placeholder="Digite seu usuário" required autofocus>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtSenha">Senha</label>
                    <div class="input-wrap">

                        <input type="password" name="txtSenha" id="txtSenha"
                               placeholder="Digite sua senha" required>
                    </div>
                </div>

                <button type="submit" class="btn-login">
                    <span class="btn-shadow"></span>
                    <span class="btn-edge"></span>
                    <span class="btn-front">
                        ENTRAR
                    </span>
                </button>
            </form>
        </div>


    </div>

</body>
</html>
