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
        <form id="form1" name="form1" method="post" action="../SisFutMS/cadMensalista.jsp?acao=alterar" class="formLogin">
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
                    <option width:"150" height:"150px" value="GOLEIRO">Goleiro</option>            
                    <option width:"150" height:"150px" value="ZAGUEIRO">Zagueiro</option>            
                    <option width:"150" height:"150px" value="ATACANTE">Atacante</option>
            		</select></td></a>
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
               Mês Pagamento:
                 <td id="mes_pagamento"> <select name="mes_pagamento" style="width: 150px;" onChange="mes_pagamento">
                    <option value="JANEIRO">Janeiro</option>            
                    <option value="FEVEREIRO">Fevereiro</option>            
                    <option value="MARÇO">Março</option>
                    <option value="ABRIL">Abril</option>            
                    <option value="MAIO">Maio</option>            
                    <option value="JUNHO">Junho</option>
                    <option value="JULIO">Julio</option>            
                    <option value="AGOSTO">Agosto</option>            
                    <option value="SETEMBRO">Setembro</option>
                    <option value="OUTUBRO">Outubro</option>            
                    <option value="NOVEMBRO">Novembro</option>            
                    <option value="DEZEMBRO">Dezembro</option>
                    </select></td> </a>
               <a align="justify">
               Data Pagamento:
               <input type="date" class="form-control date-mask" name="dt_pagamento" id="dt_pagamento" size="11" maxlength="11">
                </a>
               <a align="justify">
               Situação:
                 <td id="situacao"> <select name="situacao" style="width: 150px;" onChange="situacao">
                    <option value="A">Ativo</option>            
                    <option value="I">Inativo</option>           
            		</select>
                 </a>
               <a align="justify">
               Disponível:
                 <td id="available"> <select name="available" style="width: 150px;" onChange="situacao">
                    <option value="S">Sim</option>            
                    <option value="N">Não</option>           
            		</select>
                 </a>
               <p>
                 <label>                 
                 <input type="button" name="voltar" id="voltar" value="Voltar" onClick="redireciona('cadastraMensalista.jsp')">
                 <input type="submit" name="salvar" id="salvar" value="Salvar">
                 </label>
               </p> 
  </form>
 <%} 
  else { 
	       if ((request.getParameter("nome").length() <= 0) ||  (request.getParameter("posicao").length() <= 0)) 
		   {
				response.sendRedirect("SisFutMS/cadMensalista.jsp");
		   		
		   }else {
			   try
			   {	
					String aSql = ("insert into mensalista (nome,posicao,nivel,mes_pagamento,dt_pagamento,situacao,available, dt_cad, usu_cad) values ('"+ request.getParameter("nome")+"','"+request.getParameter("posicao")+"','"+request.getParameter("nivel")+"','"+request.getParameter("mes_pagamento")+"',to_date('"+request.getParameter("dt_pagamento")+"','yyyy-mm-dd'),'"+request.getParameter("situacao")+"','"+request.getParameter("available")+"', current_date, '"+session.getAttribute("user_name")+"')"); 
					
					
					st.executeUpdate(aSql);
					response.sendRedirect("cadastraMensalista.jsp");
                                        //out.println(aSql);
					
				}	
				catch(Exception e)
				{
					out.println("Erro ao cadastrar: " + e);
				}
			}
  }
%>	
</div>
    
</body>
</html>