<!DOCTYPE html>
<html>

<head>
    <title>ASP Form</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css" />
</head>

<body>
    <%
    firstname = request.querystring("f")
    lastname = request.querystring("l")
    if firstname<>"" then
        response.write(firstname)
    end if
    if lastname<>"" then
        response.write(lastname)
    end if
    %>
    <form method="post" action="forms.asp" >
        <input name="firstname" />
        <input name="lastname" />
        <input type="submit" value="post me" />
    </form>
    <%
    firstname = request.form("firstname")
    lastname = request.form("lastname")
    if firstname<>"" then
        response.write(firstname)
    end if
    if lastname<>"" then
        response.write(lastname)
    end if
    %>
</body>

</html>