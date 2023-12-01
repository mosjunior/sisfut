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
.style3 {font-size: 36px}
-->
    </style>
</head>
<body>
<script>
	function redireciona(param){
  		location.href=param;
	}
</script>
<div class="page">
<% 
    if (request.getParameter("acao") == null){   
%>  
        <form id="form1" name="form1" method="post" action="../SisFutMS/cadAvulso.jsp?acao=alterar" class="formLogin">
           <a align="justify">
             ID Mensalista:
             <input type="text" name="ID" id="ID" size="3" maxlength="3" readonly="readonly">
           </a>
               <a align="justify">
                 Nome:
                 <input type="text" name="nome" id="nome" size="20" maxlength="30">
                  </a>
                <a align="justify">
                  Posição:
                 <td id="posicao"> <select name="posicao" style="width: 150px;" onChange="posicao">
                    <option value="GOLEIRO">Goleiro</option>            
                    <option value="ZAGUEIRO">Zagueiro</option>            
                    <option value="ATACANTE">Atacante</option>
            		</select></td>
                </a>
               <a align="justify">
                Nível:
                 <td id="nivel"> <select name="nivel" style="width: 150px;" onChange="nivel">
                    <option value="1">1 - Ruim</option>            
                    <option value="2">2 - Razoável</option>            
                    <option value="3">3 - Mediano</option>         
                    <option value="4">4 - Bom</option>       
                    <option value="5">5 - Excelente</option>
            		</select></td>
                 </a>
                <a align="justify">
               Realiza Pagamento:
                 <td id="rpagamento"> <select name="rpagamento" style="width: 150px;" onChange="situacao">
                    <option value="S">Sim</option>            
                    <option value="N">Não</option>           
            		</select>
                 </a>
               <p>
                 <label>                 
                 <input type="button" name="voltar" id="voltar" value="Voltar" onClick="redireciona('cadSorteio.jsp')">
                 <input type="submit" name="salvar" id="salvar" value="Salvar">
                 </label>
               </p> 
  </form>
 <%} 
    else { 
        if ((request.getParameter("nome").length() <= 0) ||  (request.getParameter("posicao").length() <= 0)) 
            {
                 response.sendRedirect("cadAvulso.jsp");
        }else {                
            try{	
                   String aSql = "insert into futebol (nome,posicao,nivel,dt_cad,real_pagamento,situacao,tipo,available) values (upper('"+ request.getParameter("nome")+"'),'"+request.getParameter("posicao")+"','"+request.getParameter("nivel")+"', CURRENT_DATE,'"+request.getParameter("rpagamento")+"','A','A','S')"; 

                   st.executeUpdate(aSql);
                   response.sendRedirect("cadSorteio.jsp");
                   //out.println(aSql);

                }catch(Exception e)
                    {
                        out.println("Erro ao cadastrar: " + e);
                    }
            }
    }
%>	
</div>
    
</body>
</html>