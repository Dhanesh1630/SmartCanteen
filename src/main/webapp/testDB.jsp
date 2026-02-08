<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>

<%
    Connection con = DBConnection.getConnection();

    if(con != null){
        out.println("<h2 style='color:green;'>DB Connected Successfully!</h2>");
    } else {
        out.println("<h2 style='color:red;'>DB Not Connected!</h2>");
    }
%>
