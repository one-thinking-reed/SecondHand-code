<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cookie[] cookies=request.getCookies();
    for(int i=0;i<cookies.length;i++)
    {
        if(cookies[i].getName()=="c_uid")
        {
            request.getSession().setAttribute("uid",cookies[i].getValue());
        }
        else if(cookies[i].getName()=="c_studentID")
        {
            request.getSession().setAttribute("studentID",cookies[i].getValue());
        }
    }
    if(request.getSession().getAttribute("uid")!=null)
    {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<head>
    <title>Document</title>
    <link href='https://fonts.googleapis.com/css?family=Aclonica' rel='stylesheet'>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/input.css">
</head>
<body>
    <!-- header -->
    <div style="background-color:white; height:190px">
        <div class="nav">
            <div style="margin-left: 100px; margin-top: 30px; display: inline-block;" >
                <img  src="../images/logo3.png" alt="logo">
            </div>
            <div style="font-size: 60px; color: rgb(247,170,31) ;
                        display: inline-block; vertical-align: top; 
                        padding: 50px 0 50px 50px;
                        font-family: 'Permanent Marker', cursive;" >
                Second Hand
            </div>
        </div>
        <div class="nav" style="margin: 80px auto; float: right; color: black;" >
            <a href="index.jsp"><div class="nav_item"> Home </div></a>
            <a href="Admin.jsp"><div class="nav_item"> Admin </div></a>
            <a href="#"><div class="nav_item"> Upload </div></a>
            <a href="Login.jsp"><div class="nav_item"> Login </div></a>
            <a href="Register.jsp"><div class="nav_item"> Register </div></a>
        </div>
   </div>
   <!-- background -->
   <div class="row" style=" position:relative;z-index:1;">
        <img src="../images/signin.jpg" style="width:100%; opacity:0.5 ;filter: alpha(opacity=60);padding:0px;"/>
        <div style="width:800px; margin:auto; position:absolute;z-index:2; top:30%; left:28%; 
                    text-align:center;
                    background-color: wheat;">
            <div style="color:white; font-size: 70px; font-weight:900">Login</div>
            <form method="post" action="LoginServlet" id="login">
                <table width="100%" Cellpadding="20px" style="font-size: 30px; font-weight: 900;">
                    <tr>
                        <td><input name="studentID" type="text" placeholder="Student ID: "></td>
                    </tr>
                    <tr>
                        <td><input name="password" type="password" placeholder="Password: "></td>
                    </tr>
                    <tr style="text-align: center;">
                        <td>
                            <input style="width:150px; margin:auto;" onclick="document.getElementById('login').submit();" type="submit" name="Login" value="Login">
                            <a href="Register.jsp"><input style="width:150px; margin:auto" type="button" name="Register" value="Register"></a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

     <!--footer-->
     <div style="line-height: 25px; margin-top: 20px;text-align: center; background-color: black; padding: 15px; color: white;">
         Copyright 2020/09, Xiamen University Second-hand Website<br/>
         Hu Yuhang SWE1809351
    </div>
</body>
</html>