<%
	try{
		if (acesso == null){
			acesso = "00";
	
%>	
			<jsp:forward page="login.jsp" />
<% 
		}
	} catch(Exception e){
		out.println("Erro ao validar: "+e);
	}
	
%>