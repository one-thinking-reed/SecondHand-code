<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <a href="Upload.jsp"><div class="nav_item"> Upload </div></a>
            <a href="Login.jsp"><div class="nav_item"> Login </div></a>
            <a href="Register.jsp"><div class="nav_item"> Register </div></a>
        </div>
    </div>
   <!-- background -->
   <div class="row" style=" position:relative;z-index:1;">
        <img src="../images/signup.jpg" style="width:100%; opacity:0.5 ;filter: alpha(opacity=60);padding:0px;"/>
        <div style="width:900px; margin:auto; position:absolute;z-index:2; top:15%; left:25%;
                    text-align:center;
                    background-color: wheat;">
            <div style="color:white; font-size: 70px; font-weight:900">Register</div>
            <form id="register" method="post" action="RegisterServlet">
                <table width="100%" Cellpadding="20px" style="font-size: 20px; font-weight: 900;">
                    <tr>
                        <td><input name="username" type="text"  placeholder="Nickname: "></td>
                    </tr>
                    <tr>
                        <td>
                            <label for="female" style="margin-right:100px;">
                                <input type="radio" name="gender" id="female"value="1" checked style="width: 10px; margin-right: 10px">Female
                            </label>
                            <label for="male" style="margin-left:50px">
                                <input type="radio" name="gender" id="male" value="2" style="width: 10px; margin-right: 10px;">Male
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><input name="studentID" type="text" placeholder="Student ID: "></td>
                    </tr>
                    <tr>
                        <td><input name="password" type="text" placeholder="Password: "></td>
                    </tr>
                    <tr>
                        <td><input name="con_password" type="password" placeholder="Confirm Password: "></td>
                    </tr>
                    <tr>
                        <td><input name="email" type="text" placeholder="E-mail: "></td>
                    </tr>
                    <tr>
                        <td><input name="phone" type="text" placeholder="Phone number: "></td>
                    </tr>
                    <tr style="text-align: center;">
                        <td>
                            <input style="width:150px; margin:0 50px 0 0" type="submit" name="Submit"  value="Submit" onclick="document.getElementById('register').submit();">
                            <input style="width:150px; margin:0 0 0 10px" type="reset" name="Reset"  value="Reset">
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