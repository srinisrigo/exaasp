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
conn.Open "DRIVER={PostgreSQL Unicode(x64)};SERVER=192.168.1.104;UID=postgres;PWD=1q2w3e4r5t;PORT=5433;DATABASE=KM"
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