<!DOCTYPE html>
<html>

<head>
    <title>ASP PostgreSQL</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css" />
</head>

<body>
<%
Dim propobj, prop
set conn=Server.CreateObject("ADODB.Connection")
conn.Open "DRIVER={PostgreSQL Unicode(x64)};SERVER=192.168.1.217;UID=postgres;PWD=1q2w3e4r5t;PORT=5433;DATABASE=KM"
set rs = Server.CreateObject("ADODB.recordset")
sql="select username, first_name, last_name from users"
rs.Open sql, conn
prop=Null
propobj=Null
do until rs.EOF
    for each x in rs.Fields
        If IsNull(prop) Then
            prop = ""
        Else
            prop = prop & ","
        End If
         prop = prop & ("\""" & x.name & "\"":\""" & x.value & "\""")
    next
    If IsNull(propobj) Then
        propobj = ""
    Else
        propobj = propobj & ","
    End If
    propobj = propobj & "{" & prop & "}"
    prop=Null
    rs.MoveNext
loop
rs.close
conn.close
//Response.ContentType = "application/json"
Response.Write("[" & propobj & "]")
%>

</body>

</html>