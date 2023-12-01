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
  <link rel="stylesheet" href="css/style.css">
  <title>SisFut</title>
</head>
<body>
  <div class="main-login">
    <div class="left-login">
      <h1>Faça login<br>E entre para o nosso time</h1>
      <img src="imagens/person-working.svg" class="left-login-image" alt="Pessoa trabalhando">
    </div>
    <div class="right-login">
      <div class="card-login">
        <form id="form1" name="form1" method="post" action="login.jsp" class="formLogin">
            <h1>LOGIN</h1>
            <div class="textfield">
              <label for="usuario">Usuário</label>
              <input type="text" name="usuario" placeholder="Usuário">
            </div>
            <div class="textfield">
              <label for="password">Senha</label>
              <input type="password" name="password" placeholder="Senha">
            </div>	
            <div align="center">
		<input type="submit" name="acessar" id="acessar" value="Acessar" />
            </div>
	</form>
      </div>
    </div>
  </div>
</body>
</html>