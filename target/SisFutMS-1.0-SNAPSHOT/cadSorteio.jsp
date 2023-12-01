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
            <input type="button" name="voltar" id="voltar" value="Voltar" onClick="goBack('principal.jsp');">
            <input type="button" name="sortear" id="sortear" value="Sortear Times" onClick="redireciona('sorteiaTimes.jsp');">
           <label><input type="button" name="novo" id="novo" value="Novo" onClick="redireciona('cadAvulso.jsp');">
          </p>
          </label></div>
          <table border="1">
            <tr>
              <td align="center" bgcolor="#CCCCCC"><span class="style2">ID</span></td>
              <td align="center" bgcolor="#CCCCCC"><span class="style2">Nome</span></td>
              <td align="center" bgcolor="#CCCCCC"><span class="style2">Posição</span></td>
              <td align="center" align="center" bgcolor="#CCCCCC"><span class="style2">Nível</span></td>
              <td align="center" align="center" bgcolor="#CCCCCC"><span class="style2">Modalidade</span></td>
              <td align="center" bgcolor="#CCCCCC"><span class="style2">Excluir</span></td>
            </tr>
<%
	try
	{	
		if(requisita("acessar")!= null){
			try{
				if (request.getParameter("acao") != null){
				
					String sqlacesso = "delete from futebol where id = "+ request.getParameter("codigo");
					//out.println(sqlacesso);
					st.executeUpdate(sqlacesso);
				}
				
				String aSql = "select ROW_NUMBER() OVER () AS id, "+
                                              "       f.id as f_id, "+
                                              "       f.nome nome, "+ 
                                              "       f.posicao posicao, "+ 
                                              "       f.nivel nivel,  "+ 
                                              "       case when f.tipo = 'M' then null else 'A' end tipo, "+
                                              "       case when f.tipo = 'M' then 'Mensalista' else 'Avulso' end modalidade "+
                                              "  from futebol f  "+
                                              " where ((f.tipo = 'M' "+ 
                                              "   and f.dt_cad BETWEEN date_trunc('month', CURRENT_DATE + interval '0 month - 0 day')::date  "+
                                              "      and (date_trunc('MONTH', CURRENT_DATE) + INTERVAL '1 MONTH' - INTERVAL '1 DAY')::date   "+
                                              "      or (f.tipo = 'A' "+ 
                                              "        and f.dt_cad between  (CURRENT_DATE-2)::date "+  
                                              "                 and (CURRENT_DATE)::date )))      "+
                                              "   and f.situacao = 'A'"+
                                              "   and f.available = 'S'"+
                                              " order by ROW_NUMBER() OVER ()";
				//out.println(aSql);
                                rs = st.executeQuery(aSql);
				while(rs.next()){
%>
                                <tr>
                                  <td align="center"><%=rs.getString("id")%></td>
                                  <td align="center"><%=rs.getString("nome")%></td>
                                  <td align="center"><%=rs.getString("posicao")%></td>
                                  <td align="center"><%=rs.getString("nivel")%></td>
                                  <td align="center"><%=rs.getString("modalidade")%></td>
                                  <td align="center"><a href="cadSorteio.jsp?acao=excluir&codigo=<%=rs.getString("f_id")%>"><%= rs.getString("tipo")==null?"":"Excluir"%></a></td>
				</tr>  		 		
<%	    		}
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