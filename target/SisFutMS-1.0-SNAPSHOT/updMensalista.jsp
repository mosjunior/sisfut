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
	function goBack(){
		window.history.back()
	}
	function formata_mascara(campo_passado, mascara){
		var campo = campo_passado.value.length;
		var saida = mascara.substring(0,1);
		var texto = mascara.substring(campo);
		
		if(texto.substring(0,1) != saida){
			campo_passado.value += texto.substring(0,1);
		}
	}
	function Numero(e){
		navegador = /msie/i.test(navigator.userAgent);
		if(navegador){
			var tecla = event.keyCode;
		}else{
			var tecla = e.which;
			
			if(tecla > 47 && tecla < 58){
				return true;
			}
			else{
				if(tecla != 8){
					return false;
				}
				else{
					return true;				
				}
			}
		}
				
	}
    function setaValores(){
        alert('1 - ' + '<%=request.getParameter("nivel")%>');
        var x = document.getElementById('<%=request.getParameter("nivel")%>').selected;
        alert('2 - ' + x);
        if (x === true){ 
            alert('Entrei if' + x);
            document.getElementById("nivel").innerHTML = "selected";
        }
        //document.getElementById("nivel").innerHTML = x;
        alert('3 - ' + x);
    }
    
    YAHOO.util.Event.onDOMReady(function () {
        setaValores();        
    });
</script>
<div class="page">
<% 
	if (request.getParameter("acao") == null){ 
	//out.println("não houve ação");
  
%>  
        <form id="form1" name="form1" method="post" action="../SisFutMS/updMensalista.jsp?acao=alterar" class="formLogin">
           <a align="justify">
             ID Mensalista:
             <input type="text" name="ID" id="ID" value="<%=request.getParameter("codigo")%>" size="3" maxlength="3" readonly="readonly">
           </a>
               <a align="justify">
                 Nome:
                 <input type="text" name="nome" id="nome" value="<%=request.getParameter("nome")%>"  size="10" maxlength="10">
                  </a>
                <a align="justify">
                  Posição:
                   <td id="posicao"> <select name="posicao" style="width: 150px;"> 
                    <option value="<%= request.getParameter("posicao")%>"><%= request.getParameter("posicao")%></option> 
                   </select></td></a>
               <a align="justify">
                Nível:
                <td  id="nivel"> <select name="nivel" style="width: 150px;">
                    <option value="<%= request.getParameter("nivel")%>"><%= request.getParameter("nivel")%></option>
       		     </select></td></a>
               <a align="justify">
               Mês Pagamento:
                <td id="mes_pagamento"> <select name="mes_pagamento" style="width: 150px;" value="<%=request.getParameter("mes_pagamento")%>">
                    <option value="<%=request.getParameter("mes_pagamento")%>"><%=request.getParameter("mes_pagamento")%></option>  
                    </select></td> </a>
                 </a>
               <a align="justify">
               Data Pagamento:
			   <input type="text" class="form-control" data-mask="00/00/0000" name="dt_pagamento" id="dt_pagamento" size="11" maxlength="11" value="<%=request.getParameter("dt_pagamento")%>">
                 </a>
               <a align="justify">
               Situação:
               <td id="situacao"> <select name="situacao" style="width: 150px;" value="<%=request.getParameter("situacao")%>">
                    <option value="A">Ativo</option>            
                    <option value="I">Inativo</option>           
            		</select></td>
                 </a>
               <a align="justify">
               Disponível:
               <td id="available"> <select name="available" style="width: 150px;" value="<%=request.getParameter("available")%>">
                    <option value="S">Sim</option>            
                    <option value="N">Não</option>           
            		</select></td>
                 </a>
               <p>
                 <label>
                 <input type="button" name="voltar" id="voltar" value="Voltar" onClick="goBack()">
                 
                 <input type="submit" name="salvar" id="salvar" value="Salvar">
                 </label>
               </p> 
  </form>
 <%} 
  else { 
	       if ((request.getParameter("ID").length() <= 0) || (request.getParameter("nome").length() <= 0) ||  (request.getParameter("posicao").length() <= 0)) 
		   {
				response.sendRedirect("updMensalista.jsp");
		   		
		    }else {
			   try
			   {	
					String sql = "";
					
					if (request.getParameter("dt_pagamento").length() < 7){
						sql = ("update mensalista set nome = upper('"+ request.getParameter("nome")+"'), posicao = '"+request.getParameter("posicao")+"', nivel = '" +request.getParameter("nivel")+"', mes_pagamento = '" +request.getParameter("mes_pagamento")+"', situacao = '" +request.getParameter("situacao")+"', available = '" +request.getParameter("available")+"',dt_pagamento = null , dt_alt = current_date, user_alt = '"+session.getAttribute("user_name")+"' where user_id = " + request.getParameter("ID")); 
					//out.println(sql);
					}else{
						sql = ("update mensalista set nome = upper('"+ request.getParameter("nome")+"'), posicao = '"+request.getParameter("posicao")+"', nivel = '" +request.getParameter("nivel")+"', mes_pagamento = '" +request.getParameter("mes_pagamento")+"', dt_pagamento = to_date('"+request.getParameter("dt_pagamento")+"','dd/mm/yyyy'),  situacao = '" +request.getParameter("situacao")+"', available = '" +request.getParameter("available")+"' , dt_alt = current_date, usu_alt = '"+session.getAttribute("user_name")+"' where user_id = " + request.getParameter("ID"));
					//out.println(sql); 					
					}
					st.executeUpdate(sql);
					response.sendRedirect("cadastraMensalista.jsp");
										
				}	
				catch(Exception e)
				{
					out.println("Erro ao atualizar mensalista: " + e);
				}
			}
  }
%>	
</div>
    
</body>
</html>