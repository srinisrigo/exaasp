<!DOCTYPE html>
<html>
<head>
    <title>ASP PostgreSQL</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css" />
</head>
<body>

<%
set conn=Server.CreateObject("ADODB.Connection")
conn.Open "DSN=PostgreSQL35W"
set rs = Server.CreateObject("ADODB.recordset")
sql="select username, first_name, last_name from users"
rs.Open sql, conn
%>

<table border="1" width="100%">
<tr>
<%for each x in rs.Fields
    response.write("<th>" & x.name & "</th>")
next%>
</tr>
<%do until rs.EOF%>
    <tr>
    <%for each x in rs.Fields%>
       <td><%Response.Write(x.value)%></td>
    <%next
    rs.MoveNext%>
    </tr>
<%loop
rs.close
conn.close
%>
</table>

</body>
</html>