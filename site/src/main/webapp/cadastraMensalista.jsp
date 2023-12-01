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
    <link rel="stylesheet" href="css/style.css">
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
    <div class="main-login">
        <form id="form1" name="form1" method="post" action="" class="card-fut">
         <div align="center">
            <input type="button" name="voltar" id="voltar" value="Voltar" onClick="goBack('principal.jsp')">
            <input type="button" name="novo" id="novo" value="Novo" onClick="redireciona('cadMensalista.jsp');">
            </p>
         </div>
                <table width="748" border="1">
                    <tr>
                          <td bgcolor="#CCCCCC"><span class="textfield">ID</span></td>
                          <td bgcolor="#CCCCCC"><span class="textfield">Nome</span></td>
                          <td bgcolor="#CCCCCC"><span class="textfield">Posição</span></td>
                          <td align="center" bgcolor="#CCCCCC"><span class="textfield">Vlr Mensalidade</span></td>
                          <td bgcolor="#CCCCCC"><span class="textfield">Mês Pagamento</span></td>
                          <td bgcolor="#CCCCCC"><span class="textfield">Data Pagamento</span></td>
                          <td align="center" bgcolor="#CCCCCC"><span class="textfield">Situação</span></td>
                          <td align="center" bgcolor="#CCCCCC"><span class="textfield">Disponível</span></td>
                          <td align="center" bgcolor="#CCCCCC"><span class="textfield">Nível</span></td>
                          <td bgcolor="#CCCCCC"><span class="textfield">Excluir</span></td>
                          <td bgcolor="#CCCCCC"><span class="textfield">Alterar</span></td>
                  </tr>
<%
	try
	{	
		if(requisita("acessar")!= null){
			try{
				if (request.getParameter("acao") != null){
				
					String sqlacesso = "delete from mensalista where user_id = "+ request.getParameter("codigo");
					
					st.executeUpdate(sqlacesso);
				}
				
				String aSql = "SELECT user_id, "+
                                              "       nome, "+
                                              "       posicao, "+
                                              "       nivel, "+
                                              "       ret_vlr_padrao('M') as vlr_mensal, "+
                                              "       mes_pagamento, "+
                                              "       to_char(dt_pagamento, 'dd/mm/yyyy') dt_pagamento, "+
                                              "       situacao, "+
                                              "       available "+
                                              "  FROM mensalista "+ 
                                              " WHERE dt_cad BETWEEN date_trunc('month', CURRENT_DATE + interval '0 month - 0 day')::date "+
                                              "                  AND (date_trunc('MONTH', CURRENT_DATE) + INTERVAL '1 MONTH' - INTERVAL '1 DAY')::date "+
                                              "   and situacao in ('A','I')";
				rs = st.executeQuery(aSql);
				while(rs.next()){
%>
					<tr>
                                            <td><%=rs.getString("user_id")%></td>
                                            <td><%=rs.getString("nome")%></td>
                                            <td><%=rs.getString("posicao")%></td>
                                            <td>R$<%=rs.getString("vlr_mensal").replace('.', ',')%></td>
                                            <td><%=rs.getString("mes_pagamento")%></td>
                                            <td><%=rs.getString("dt_pagamento")%></td>
                                            <td><%=rs.getString("situacao")%></td>
                                            <td><%=rs.getString("available")%></td>
                                            <td><%=rs.getString("nivel")%></td>
                                            <td><div align="center"><a href="cadastraMensalista.jsp?acao=excluir&codigo=<%=rs.getString("user_id")%>"><img src="imagens/excluir.png" width="32" height="32"></a></div></td>
                                            <td><div align="center"><a href="updMensalista.jsp?codigo=<%=rs.getString("user_id")%>&nome=<%=rs.getString("nome")%>&posicao=<%=rs.getString("posicao")%>&nivel=<%=rs.getString("nivel")%>&vlr_mensal=<%=rs.getString("vlr_mensal")%>&mes_pagamento=<%=rs.getString("mes_pagamento")%>&dt_pagamento=<%=rs.getString("dt_pagamento")%>&situacao=<%=rs.getString("situacao")%>"><img src="imagens/editar.png" width="32" height="32"></a><a href="updMensalista1.jsp?codigo=<%=rs.getString("user_id")%>&nome=<%=rs.getString("nome")%>&nivel=<%=rs.getString("nivel")%>&vlr_mensal=<%=rs.getString("mes_pagamento")%>&dt_pagamento=<%=rs.getString("dt_pagamento")%>&situacao=<%=rs.getString("situacao")%>"></a></div></td></div>
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
</div>
</body>
</html>