<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="PageError.jsp" %>
<%@include file="conexao.jsp"%>
<%@include file="httpservletrequest.jsp"%>
<% 
    if(requisita("acessar")!= ""){
        try{
            String sqlacesso = "select user_name, password, nivel_acesso from users where user_name = '"+requisita("usuario")+"' and password = '"+requisita("password")+"'";

            rs = st.executeQuery(sqlacesso);
            //out.println(sqlacesso);

            if (rs.next()){
                session.setAttribute("user_name",rs.getString("user_name"));
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
      <img src="imagens/person-working.svg" class="left-login-image" alt="Pessoa trabalhando">
    </div>
    <div class="right-login">
      <form id="form1" name="form1" method="post" action="login.jsp" class="right-login">
        <div class="card-login">
        <h1>LOGIN</h1>
        <div class="textfield">
          <label for="usuario">Usuário</label>
          <input type="text" name="usuario" id="usuario" placeholder="Usuário">
        </div>
        <div class="textfield">
          <label for="password">Senha</label>
          <input type="password" name="password" id="password" placeholder="Senha">
        </div>
        <div align="center">
            <input type="submit" name="acessar" id="acessar" value="Acessar" class="btn-login"/>
	</div>
      </div>
      </form>
    </div>
  </div>
</body>
</html>