<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="PageError.jsp" %>
<%@include file="conexao.jsp"%>
<%@include file="httpservletrequest.jsp"%>
<% 	
	if(requisita("acessar")!= ""){
		try{
			String sqlacesso = "select user_name, password, nivel_acesso from users where user_name = '"+requisita("usuario")+"' and password = '"+requisita("senha")+"'";
			
			rs = st.executeQuery(sqlacesso);
			//out.println(sqlacesso);
			
			if (rs.next()){
				session.setAttribute("users",rs.getString("nivel_acesso"));
%>
				<jsp:forward page="principal.jsp" />				
<%				
			}
		
		}catch(Exception e){
			out.println("Erro: "+e);
		}
	}
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/main.css">
</head>
	<body>
		<div class="page">
			<form id="form1" name="form1" method="post" action="login.jsp" class="formLogin">
				<h1 align="center">Login SistFut</h1>
			  <p align="center"><%= httpServletRequest.getParameter("acessar")==null?"Entre com usuário e senha":"Usuário ou senha inválidos"%></p>
				<label for="usuario">Usuário</label>
				<input type="text" name="usuario" id="usuario" placeholder="Digite se usuário" autofocus="true" />
				<label for="senha">Senha</label>
				<input type="password" name="senha" id="senha" placeholder="Digite sua senha" />
			   <!-- <a href="/">Esqueci minha senha</a> -->
				<div align="center">
					<input type="submit" name="acessar" id="acessar" value="Acessar" />
				</div>
			</form>
		</div>    
	</body>
</html>