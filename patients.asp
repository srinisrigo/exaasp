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
conn.Open "DRIVER={PostgreSQL Unicode(x64)};SERVER=192.168.1.217;UID=postgres;PWD=1q2w3e4r5t;PORT=5433;DATABASE=KM"
set rs = Server.CreateObject("ADODB.recordset")
sql="SELECT p.account_no,p.full_name, p.id as patient_id, p.phonogram_name, p.ideogram_name, p.birth_date::text, p.gender,'' as last_study_date, p.patient_info:: json As patient_info, nullif(p.patient_details->>'pat_comments', '') as pat_comments, p.stat, p.reception_dt,p.urgency,p.has_photo,p.photo_uploaded_dt, false as is_animal, p.reception_no, p.last_edit_dt FROM patients p order by p.id desc"
rs.Open sql, conn
%>
<span>
<%Response.Write(request.querystring("fname"))%>
</span>
<table border="1" width="100%">
<tr>
<%for each x in rs.Fields
response.write("<th>" & x.name & "</th>")
next%>
</tr>
<%do until rs.EOF%>
<tr>
<%for each x in rs.Fields%>
<td>
<%Response.Write(x.value)%>
</td>
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