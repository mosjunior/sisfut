<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="PageError.jsp" %>
<%@include file="conexao.jsp"%>
<%@include file="httpservletrequest.jsp"%>
<%@include file="valida.jsp"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
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
          		  <input type="button" name="voltar" id="voltar" value="Voltar" onClick="goBack('principal.jsp')">
           <label><input type="button" name="novo" id="novo" value="Imprimir Relatório" onClick="redireciona('impRelatorio.jsp');">
           <label><input type="button" name="novo" id="novo" value="Ajustes" onClick="redireciona('updtValores.jsp');">
          </p>
          </label></div>
          <table width="748" border="1">
            <tr>
              <td align="center" width="100" bgcolor="#CCCCCC"><span class="style2">Valor à receber</span></td>
              <td align="center" width="100" bgcolor="#CCCCCC"><span class="style2">Qtd Semanas</span></td>
              <td align="center" width="100" bgcolor="#CCCCCC"><span class="style2">Valor à pagar</span></td>
              <td width="100" align="center" bgcolor="#CCCCCC"><span class="style2">Valor recebido</span></td>
              <td width="70" align="center" bgcolor="#CCCCCC"><span class="style2">Em caixa</span></td>
              <td width="50" align="center" bgcolor="#CCCCCC" ><span class="style2">Saldo</span></td>
            </tr>
<%
	try
	{	
		if(requisita("acessar")!= null){
			try{
				
                            String aSql = "select ret_vlr_previsto_receber(CURRENT_DATE) vlr_a_receber,"+
                                                 "ret_qt_dia_semana(CURRENT_DATE) as qt_semana,"+
                                                 "ret_qt_dia_semana(CURRENT_DATE) * ret_vlr_padrao('L') as qt_a_pagar,"+
                                                 "ret_vlr_recebido(CURRENT_DATE) as vlr_recebido,"+
                                                 "ret_vlr_padrao('C') as vlr_em_caixa,"+
                                                 "(ret_vlr_recebido(CURRENT_DATE) + ret_vlr_padrao('C')) - (ret_qt_dia_semana(CURRENT_DATE) * ret_vlr_padrao('L')) as saldo";
                            rs = st.executeQuery(aSql);
                            while(rs.next()){
%>
                                <tr>
                                  <td align="center">R$<%=rs.getString("vlr_a_receber").replace('.', ',')%></td>
                                  <td align="center"><%=rs.getString("qt_semana")%></td>
                                  <td align="center">R$<%=rs.getString("qt_a_pagar").replace('.', ',')%></td>
                                  <td align="center">R$<%=rs.getString("vlr_recebido").replace('.', ',')%></td>
                                  <td align="center">R$<%=rs.getString("vlr_em_caixa").replace('.', ',')%></td>
                                  <td align="center" bgcolor="#66CDAA"><strong><%=rs.getString("saldo").replace('.', ',')%></strong></td>
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