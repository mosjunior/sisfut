<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="conexao.jsp"%>
<%@include file="httpservletrequest.jsp"%>
<%@include file="valida.jsp"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, max-scale=1.0">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SisFut</title>
    <link rel="stylesheet" href="css/main.css">
    <style type="text/css">
<!--
.style2 {font-size: 14}
-->
    </style>
</head>
<body>
<script>
	function goBack(param){
		location.href=param;
	}
	function redireciona(param){
  		location.href=param;
	}
</script>
<div class="page">
        <form id="form1" name="form1" method="post" action="" class="formLogin">
         <div align="center">
            <input type="button" name="voltar" id="voltar" value="Voltar" onClick="goBack('cadSorteio.jsp');">                          
            <input type="button" name="sortear" id="sortear" value="Sortear Times" onClick="redireciona('sorteiaTimes.jsp');">
            <div align="center">
              <input type="button" name="times" id="times" value="Qt Times"/>  
              <select name="qttimes" id="qttimes" style="width: 30px; height: 50px">
               <option value=1>1</option>            
               <option value=2 selected>2</option>            
               <option value=3>3</option>          
               <option value=4>4</option>
              </select>          
            </div>
          </p>
          </label></div>
          <table border="1">
            <tr>
              <td align="center" bgcolor="#CCCCCC"><span class="style2">Time</span></td>
              <td align="center" bgcolor="#CCCCCC"><span class="style2">Nome</span></td>
            </tr>
<%
	try
	{   
            if (request.getParameter("qttimes") == null){
                try{
                    String aSql = "select equipe, string_agg(upper(jogadores), ' - ' order by jogadores) as jogadores "+
                                  "  from get_sotear_times(3) "+
                                  "  group by equipe";
                    //out.println(aSql);
                    rs = st.executeQuery(aSql);
                    while(rs.next()){
%>
                        <tr>
                          <td align="center"><%=rs.getString("equipe")%></td>
                          <td class="uppercase" align="center"><%=rs.getString("jogadores")%></td>
                        </tr>  		 		
<%
                        } 
                    }catch(Exception e){
                            out.println("Erro: "+e);
                    }
		}
	}catch(Exception e){
		out.println("Erro ao listar mensalistas: "+e);
	}
%>
      </table>
  </form>
</div>
</body>
</html>