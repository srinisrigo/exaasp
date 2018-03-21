<!DOCTYPE html>
<html>

<head>
    <title>ASP PostgreSQL</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css" />
</head>

<body>

<%
Server.ScriptTimeout = 300
set conn=Server.CreateObject("ADODB.Connection")
set err = Server.CreateObject("ADODB.Error")
conn.Open "DRIVER={PostgreSQL Unicode(x64)};SERVER=192.168.1.217;UID=postgres;PWD=1q2w3e4r5t;PORT=5433;DATABASE=KM"
set rs = Server.CreateObject("ADODB.recordset")
sql="WITH max_ins AS (SELECT study_id , max(study_series_instances.id) AS max_ins_id FROM study_series_instances GROUP BY study_id),Study_status_UNR AS (SELECT status_desc FROM study_status WHERE status_code = 'UNR') SELECT studies.id as study_id, studies.patient_id, studies.study_uid,'' as character_set, patients.account_no, patients.full_name, patients.phonogram_name, patients.ideogram_name, patients.birth_date::text,patients.gender,'' as last_study_date,patient_info->'owner_full_name' as owner_full_name, patient_info->'owner_phonogram_name' as owner_phonogram_name,patient_info->'owner_ideogram_name' as owner_ideogram_name, patient_info->'species' as species,patient_info->'bleed' as bleed, false as is_animal, studies.patient_age, studies.accession_no, studies.study_dt, studies.cpt_codes, studies.study_description,studies.orientation, studies.body_part, studies.modalities, studies.study_details, studies.no_of_series, studies.no_of_instances FROM max_ins INNER JOIN studies ON studies.id = max_ins.study_id INNER JOIN patients ON (studies.patient_id = patients.id AND studies.no_of_instances > 0 AND studies.no_of_series > 0) order by studies.no_of_instances desc"
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
<%loop%>
</table>
<%
for each errobj in rs.ActiveConnection.Errors
response.write "Description: " & errobj.Description & Chr(10) & Chr(13) & _ "Number: " & Hex(errobj.Number)
next
rs.close
conn.close
%>
</body>

</html>