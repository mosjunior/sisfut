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
</script>
<div class="page">
        <form id="form1" name="form1" method="post" action="" class="formLogin">
         <div align="center">
          		  <input type="button" name="voltar" id="voltar" value="Voltar" onClick="goBack('financeiro.jsp')">
           <label><input type="submit" name="salvar" id="salvar" value="Salvar">
                 
          </p>
          </label></div>
          <table width="748" border="1">
<%  
    if (request.getParameter("salvar") == null){
            try{                            
                String aSql = "select * from valores_padroes";
                rs = st.executeQuery(aSql);
                while(rs.next()){
%>                              
                    <tr>
                      <a align="justify">
                        ID:
                      <input type="text" name="id" id="id" value="<%=rs.getString("id")%>" size="2" maxlength="2" readonly="readonly"> 
                        Valor Mensalidade: R$
                      <input type="text" name="vlr_mensalidade" bgcolor="#DCDCDC" id="vlr_mensalidade" value="<%=rs.getString("vlr_mensalidade").replace('.', ',')%>" size="5" maxlength="5">
                        Valor Avulso: R$
                      <input type="text" name="vlr_avulso" bgcolor="#DCDCDC" id="vlr_avulso" value="<%=rs.getString("vlr_avulso").replace('.', ',')%>" size="5" maxlength="5">
                        Valor Aluguel: R$
                      <input type="text" name="vlr_locacao" bgcolor="#DCDCDC" id="vlr_locacao" value="<%=rs.getString("vlr_locacao").replace('.', ',')%>" size="5" maxlength="5">
                        Valor Caixa: R$
                      <input type="text" name="vlr_caixa" bgcolor="#DCDCDC" id="vlr_caixa" value="<%=rs.getString("vlr_caixa").replace('.', ',')%>" size="8" maxlength="8">
                      </a>
                    </tr>  		 		
<%	    		}
            }catch(Exception e){
                    out.println("Erro: "+e);
            }
    }else{
        try{
            String w_vlr_mensalidade = request.getParameter("vlr_mensalidade").replace(',', '.');
            String w_vlr_avulso = request.getParameter("vlr_avulso").replace(',', '.');
            String w_vlr_locacao = request.getParameter("vlr_locacao").replace(',', '.');
            String w_vlr_caixa = request.getParameter("vlr_caixa").replace(',', '.');

            String aSql = "update valores_padroes set vlr_mensalidade = "+w_vlr_mensalidade+", vlr_avulso = "+w_vlr_avulso+", vlr_locacao = "+w_vlr_locacao+", vlr_caixa = "+w_vlr_caixa+" where id = "+request.getParameter("id");

            //out.println(aSql);
            st.executeUpdate(aSql);
            response.sendRedirect("financeiro.jsp");

        }catch(Exception e){
            out.println("Erro ao listar mensalistas: "+e);
        }
    }
%>
      </table>
  </form>
</div>
</body>
</html>