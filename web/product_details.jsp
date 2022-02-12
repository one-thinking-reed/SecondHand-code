<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>Document</title>
    <link href='https://fonts.googleapis.com/css?family=Aclonica' rel='stylesheet'>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/input.css">

    <style>
        .bigPic{
            margin-left:20px;
            width:500px;
            cursor:pointer;
        }
        .bigPic img{
            width:500px;
            max-height: 700px;
        }
        #smallPic{
            padding:10px;
            width:504px;
            height:150px;
        }
        #smallPic ul{
            width:100%;
            margin:0;
            list-style:none;
        }
        #smallPic ul li{
            margin:10px;
            float:left;
            overflow: hidden;
            border:2px solid #EFEDEE;
            cursor:pointer;
        }
        #smallPic ul li img{
            width:130px;
            height:130px;
        }
        .box{
            display: inline-block;
            vertical-align: top;
            margin:20px;
        }
        .box td{
            max-width: 400px;
        }
        button {
            background-color: #4CAF50;
            border: 2px solid #4CAF50;
            border-radius: 10px;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 30px;
            cursor: pointer;
        }
       
    </style>
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
        <%
            if(session.getAttribute("uid")==null)
            {
        %>
        <a href="Login.jsp"><div class="nav_item"> Login </div></a>
        <a href="Register.jsp"><div class="nav_item"> Register </div></a>
        <%
        }
        else
        {
        %>
        <a href="profile.jsp?uid="<%=session.getAttribute("uid")%>><div class="nav_item"> [<%=session.getAttribute("username")%>] </div></a>
        <a href="LogoutServlet"><div class="nav_item"> Logout </div></a>
        <%
            }
        %>
    </div>
</div>
   <!-- background -->
   <div class="row" style=" position:relative;z-index:1;">
        <img src="../images/detailed_product.jpg" style="width:100%; opacity:0.5 ;filter: alpha(opacity=60);padding:0px;"/>
        <div style="width:1200px; margin:auto; position:absolute;z-index:2; top:15%; left:17%;
                    background-color: white;">
            <!-- pictures -->
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn=
                        DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/secondhand","root","838180"
                        );
                Statement stm= conn.createStatement();
                String sql="select * from product where product.id="+request.getParameter("pid");
                ResultSet rs=stm.executeQuery(sql);
                rs.next();
                String str=rs.getString("image");
                String[] temp;
                String delimeter = ";";  // 指定分割字符
                temp = str.split(delimeter); // 分割字符串
            %>
            <div class="box">
                <div class="bigPic">
                    <img src="<% out.print(temp[0]); %>" alt="Big picture" id="image">
                </div>
                <div id="smallPic">
                    <ul>
                        <%
                            for(int i =0; i < temp.length ; i++)
                            {
                        %>
                        <li>
                            <a href="<% out.print(temp[i]); %>">
                                <img src="<% out.print(temp[i]); %>" alt="">
                            </a>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </div>
            </div>
            <div class="box">
                <table style="margin:30px 70px 0px 70px; border-collapse:separate; border-spacing:0px 30px;">
                    <tr>
                        <td style="font-size:60px; font-weight: 900;"><%=rs.getString("productname")%></td>
                    </tr>
                    <tr>
                        <td style="font-size:40px; font-weight: 900; color:navy"><%=rs.getString("productprice")%></td>
                    </tr>
                    <tr>
                        <td style="font-size:30px; font-weight: 900; color:grey">Total number: <%=rs.getString("productnumber")%></td>
                    </tr>
                    <tr>
                        <td style="font-size:20px; font-weight: 900; color:grey"><%=rs.getString("productdetail")%></td>
                    </tr>
                    <tr>
                        <td>
                            <%
                                if(session.getAttribute("studentID")==null)
                                {
                            %>
                            <a href="Login.jsp">
                                <button>Contact the seller</button>
                            </a>
                            <%
                                }else{
                            %>
                            <a href="profile.jsp?uid=<%=rs.getString("user_id")%>&pid=<%=request.getParameter("pid")%>">
                                <button>Contact the seller</button>
                            </a>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

     <!--footer-->
     <div style="line-height: 25px; margin-top: 20px;text-align: center; background-color: black; padding: 15px; color: white;">
         Copyright 2020/09, Xiamen University Second-hand Website<br/>
         Hu Yuhang SWE1809351
    </div>
    <script>
        //aquire all "a" tags 
      var alA=document.getElementById("smallPic").getElementsByTagName("a");
      for(var i=0;i<alA.length;i++){
        alA[i].onclick=function(){
            document.getElementById("image").src=this.href;
            return false;
        }
      }
     </script>
</body>
</html>