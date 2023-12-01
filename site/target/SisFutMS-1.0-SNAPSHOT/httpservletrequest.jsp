<%!
	HttpServletRequest httpServletRequest;
	String requisita(String value){
		String temp = httpServletRequest.getParameter(value);
		if (temp == null){
			temp = "";
		}
		
		return temp;
	}
%>

<%
	httpServletRequest = request;
%>