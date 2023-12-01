<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
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
          		  <input type="button" name="voltar" id="voltar" value="Voltar" onClick="goBack('financeiro.jsp')">
         </div>
<%
    try
    {	
        if(requisita("acessar")!= null){
                try{	
%>
                    <table  width="748" border="1">
                      <td align="center" width="100" bgcolor="#CCCCCC"><span class="style2">Valor à receber</span></td>
                      <td align="center" width="100" bgcolor="#CCCCCC"><span class="style2">Qtd Semanas</span></td>
                      <td align="center" width="100" bgcolor="#CCCCCC"><span class="style2">Valor à pagar</span></td>
                      <td width="100" align="center" bgcolor="#CCCCCC"><span class="style2">Valor recebido</span></td>
                      <td width="70" align="center" bgcolor="#CCCCCC"><span class="style2">Em caixa</span></td>
                      <td width="50" align="center" bgcolor="#CCCCCC" ><span class="style2">Saldo</span></td> 
<%
                    String xSql = "select ret_vlr_previsto_receber(CURRENT_DATE) vlr_a_receber,"+
                                         "ret_qt_dia_semana(CURRENT_DATE) as qt_semana,"+
                                         "ret_qt_dia_semana(CURRENT_DATE) * ret_vlr_padrao('L') as qt_a_pagar,"+
                                         "ret_vlr_recebido(CURRENT_DATE) as vlr_recebido,"+
                                         "ret_vlr_padrao('C') as vlr_em_caixa,"+
                                         "(ret_vlr_recebido(CURRENT_DATE)+ ret_vlr_padrao('C')) - (ret_qt_dia_semana(CURRENT_DATE) * ret_vlr_padrao('L')) as saldo";
                    rs = st.executeQuery(xSql);
                    while(rs.next()){
%>                  
                    <tr>
                        <td align="center">R$<%=rs.getString("vlr_a_receber")%></td>
                        <td align="center"><%=rs.getString("qt_semana")%></td>
                        <td align="center">R$<%=rs.getString("qt_a_pagar")%></td>
                        <td align="center">R$<%=rs.getString("vlr_recebido")%></td>
                        <td align="center">R$<%=rs.getString("vlr_em_caixa")%></td>
                        <td align="center">R$<%=rs.getString("saldo")%></td>
                    </tr>
                    </table>
<%
                    }
%>             
                    <table>
                      <tr><td align="center" bgcolor="#CCCCCC">PAGAMENTOS MENSALISTA</td></tr> 
                    </table>

                  <table width="748" border="1">
                    <tr>
                      <td width="46" bgcolor="#CCCCCC"><span class="style2">Nome</span></td>
                      <td width="118" align="center" bgcolor="#CCCCCC"><span class="style2">Vlr Mensalidade</span></td>
                      <td width="120" bgcolor="#CCCCCC"><span class="style2">Mês Pagamento</span></td>
                      <td width="121" bgcolor="#CCCCCC"><span class="style2">Data Pagamento</span></td>
                    </tr>
<%
                    String aSql = "SELECT upper(nome) as nome, "+
                                  "       ret_vlr_padrao('M') as vlr_mensal, "+
                                  "       mes_pagamento, "+
                                  "       to_char(dt_pagamento, 'dd/mm/yyyy') dt_pagamento "+
                                  "  FROM mensalista "+ 
                                  " WHERE dt_cad BETWEEN date_trunc('month', CURRENT_DATE + interval '0 month - 1 day')::date "+
                                  "                  AND (date_trunc('MONTH', CURRENT_DATE) + INTERVAL '1 MONTH' - INTERVAL '1 DAY')::date "+
                                  "   and situacao = 'A'"+
                                  "   and dt_pagamento > '0001-01-01'"+
                                  "  order by dt_pagamento asc";
                    rs = st.executeQuery(aSql);
                    while(rs.next()){
%>
                    <tr>
                      <td><%=rs.getString("nome")%></td>
                      <td>R$<%=rs.getString("vlr_mensal").replace('.', ',')%></td>
                      <td><%=rs.getString("mes_pagamento")%></td>
                      <td><%=rs.getString("dt_pagamento")%></td>
                    </tr> 
<%
                    }
%>
                    </table>
                    <table>
                      <tr><td align="center" bgcolor="#CCCCCC">PAGAMENTOS AVULSO</td></tr> 
                    </table>
                    <table width="748" border="1"> 	
                    <tr>
                      <td width="46" bgcolor="#CCCCCC"><span class="style2">Nome</span></td>
                      <td width="118" align="center" bgcolor="#CCCCCC"><span class="style2">Vlr Avulso</span></td>
                      <td width="121" bgcolor="#CCCCCC"><span class="style2">Mês Pagamento</span></td>
                      <td width="121" bgcolor="#CCCCCC"><span class="style2">Data Pagamento</span></td>
                    </tr>	 		
<%                             

                    String bSql = "SELECT upper(f.nome) as nome, "+
                                  "       ret_vlr_padrao('A') as vlr_mensal, "+
                                  "        ret_mes_corrente(f.dt_cad) mes_pagamento, "+          
                                  "       to_char(f.dt_cad, 'dd/mm/yyyy') dt_pagamento "+
                                  "  from futebol f "+ 
                                  " where f.tipo = 'A' "+
                                  "   and f.dt_cad between date_trunc('month', CURRENT_DATE + interval 'month - 1 day')::date "+  
                                  "                    and date_trunc('MONTH', CURRENT_DATE) + INTERVAL '1 MONTH' - INTERVAL '1 DAY' "+
                                  "   and f.situacao = 'A' "+
                                  "   and f.real_pagamento = 'S' "+
                                  "  order by f.dt_cad asc";
                    rs = st.executeQuery(bSql);
                    while(rs.next()){
%>
                        <tr>
                          <td><%=rs.getString("nome")%></td>
                          <td>R$<%=rs.getString("vlr_mensal").replace('.', ',')%></td>
                          <td><%=rs.getString("mes_pagamento")%></td>
                          <td><%=rs.getString("dt_pagamento")%></td>
                        </tr>  		 	

<%
                        }
%>
      </table>
<%
                        }catch(Exception e){
                            out.println("Erro: "+e);
                        }
            }
    }catch(Exception e){
            out.println("Erro ao listar mensalistas: "+e);
    }
%>
  </form>
</div>
</body>
</html>