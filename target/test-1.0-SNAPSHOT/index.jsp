<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 3/15/2018
  Time: 9:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="core.test" %>
<%@ page import="java.util.Map" language="java" %>
<%@ page import="java.util.Iterator" language="java" %>
<%@ page import="java.util.List" language="java" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" language="java" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>CAS Example Java Web App</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<h1>CAS Example Java Web App</h1>
<p>A sample web application that exercises the CAS protocol features via the Java CAS Client.</p>
<hr>
<% String sessionId = request.getParameter("JSESSIONID");
//  test t= new test();
%>
<%--<p><b>Authenticated User Id:</b> <%= t.getHello()%>--%>
<p><b>Authenticated User Id:</b> <%= session.getId() %>
<p><b>Authenticated User Id:</b> <%= request.getRemoteUser() %>

</p>
<p>
  <a href="https://local.baohiemxahoi.gov.vn:8443/login?service=http://testsso.gov.vn:8081/index.jsp" title="Click here to log in">Login</a>
</p>
<p>
  <a href="https://local.baohiemxahoi.gov.vn:8443/logout?service=http://testsso.gov.vn:8081/logout.jsp" title="Click here to log out">Logout</a>
</p>

<%
  if (request.getUserPrincipal() != null) {
      %>
<p>
  <a href="Hello.jsp" title="Click here to hello">Hello</a>
</p>
<%
    AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();

    final Map attributes = principal.getAttributes();

    if (attributes != null) {
      Iterator attributeNames = attributes.keySet().iterator();
      out.println("<b>Attributes:</b>");

      if (attributeNames.hasNext()) {
        out.println("<hr><table border='3pt' width='100%' class='table'>");
        out.println("<th colspan='2'>Attributes</th>");
        out.println("<tr><td><b>Key</b></td><td><b>Value</b></td></tr>");

        for (; attributeNames.hasNext(); ) {
          out.println("<tr class='success'><td>");
          String attributeName = (String) attributeNames.next();
          out.println(attributeName);
          out.println("</td><td>");
          final Object attributeValue = attributes.get(attributeName);

          if (attributeValue instanceof List) {
            final List values = (List) attributeValue;
            out.println("<strong>Multi-valued attribute: " + values.size() + "</strong>");
            out.println("<ul>");
            for (Object value : values) {
              out.println("<li>" + value + "</li>");
            }
            out.println("</ul>");
          } else {
            out.println(attributeValue);
          }
          out.println("</td></tr>");
        }
        out.println("</table>");
      } else {
        out.print("No attributes are supplied by the CAS server.</p>");
      }
    } else {
      out.println("<pre>The attribute map is empty. Review your CAS filter configurations.</pre>");
    }
  } else {
    out.println("<pre>The user principal is empty from the request object. Review the wrapper filter configuration.</pre>");
  }
%>
</div>
</body>
</html>

