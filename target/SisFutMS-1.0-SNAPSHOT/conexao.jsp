<%!
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	
	String acesso;
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://db.eicxqsguamotigvmivjh.supabase.co:5432/postgres";
	String user = "postgres";
	String password = "108479Mos@#";
	
	public void jspInit(){
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,user,password);
			st = con.createStatement();
		}catch (Exception e) {
			System.out.print("Conexão falhou: "+e);			
		 }
	}
	
	public void jspDestroy(){
		try {
			st.close();
			con.close();
		} catch(Exception e) {
			System.out.print("Não foi possível encerrar a conexão: "+e);
		}
	}
%>
<%	
	acesso = (String) session.getAttribute("user_name");
%>