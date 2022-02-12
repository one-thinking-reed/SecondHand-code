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
    <link rel="stylesheet" href="../css/productDisplay.css">
    <style>

        .cat_item{
            display: inline-block;
            font-size: 1em;
            color: black; 
            font-family: 'Aclonica'; 
            font-weight: 500;
            text-align: center;

        }

        #pairflag{
            display: none;
        }
        #pairflag.show{
            overflow:hidden;
            display:block;
            position:absolute;
            top:800px;
            width:100%;
        }
        .f_l{float:left;}
        .f_r{float:right;}

        .category{
            border: 15px solid rgb(247,170,31);
            border-radius: 10%; 
            width:300px;
        }
        
    </style>
    <script type="text/JavaScript" src="../js/index.js"></script>
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
        <img src="../images/back3.jpg" style="width:100%; opacity:0.5 ;filter: alpha(opacity=60);padding:0px;"/>
        <div style="width:100%;position:absolute;z-index:2; top:50%; text-align:center;">
            <div style="color:black; font-size: 50px; font-weight:900">You can buy whatever you want here ! </div>
        </div>
    </div>
   
    <HR style="FILTER: alpha(opacity=100,finishopacity=0,style=2)" color=#987cb9 SIZE=10>

        <!-- sidebar -->
    <div id="pairflag" style="z-index:2">
        <div class="f_l" id="advLeft">
            <div class="category">
                <div style=" text-align:center; background-color: rgb(247,170,31); font-size: 1.5em; color:white; font-weight:900; padding:10px">
                    Category
                </div>
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn=
                            DriverManager.getConnection(
                                    "jdbc:mysql://localhost:3306/secondhand","root","838180"
                            );
                    Statement stm_cat= conn.createStatement();
                    String sql_cat="select category.id as cid, category.title as ctitle\n" +
                            "from category";
                    ResultSet rs_cat=stm_cat.executeQuery(sql_cat);
                %>
                <table Cellpadding=8px width=100% style="border-collapse: separate; border-spacing: 0px 0px">
                    <%
                        //the length of resultset
                        rs_cat.last();
                        int len = rs_cat.getRow();
                        rs_cat.beforeFirst();
                        int half=len/2;
                        for(int i=0;i<half;i++)
                        {
                            rs_cat.next();
                    %>
                    <tr style="background-color: #DDDDDD; text-align:center; font-weight: 800">
                        <td style="font-size:1.3em; color: white;">
                            <%=rs_cat.getString("ctitle")%>
                        </td>
                    </tr>
                    <%
                        Statement stm_sub= conn.createStatement();
                        String sql_sub="select subcategory.id as sid, subcategory.title as stitle\n" +
                                "from subcategory where subcategory.category_id="+ rs_cat.getString("cid");
                        ResultSet rs_sub=stm_sub.executeQuery(sql_sub);
                        while(rs_sub.next())
                        {
                    %>
                    <tr style=" text-align:center;background-color: white;">
                        <td style="font-size:1.1em; color: white;">
                            <a href="products.jsp?sid=<%=rs_sub.getString("sid")%>">
                                <div class="cat_item"> <%=rs_sub.getString("stitle")%> </div>
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                        }
                    %>
                </table>
                <div style="background-color: rgb(247,170,31);padding:10px">
                </div>
            </div>
        </div>
        <div class="f_r" id="advRight">
            <div class="category">
                <div style=" text-align:center; background-color: rgb(247,170,31); font-size: 1.5em; color:white; font-weight:900; padding:10px">
                    Category
                </div>
                <table Cellpadding=8px width=100% style="border-collapse: separate; border-spacing: 0px 0px">
                    <%
                        for(int i=half;i<len;i++)
                        {
                            rs_cat.next();
                    %>
                    <tr style="background-color: #DDDDDD; text-align:center; font-weight: 800">
                        <td style="font-size:1.3em; color: white;">
                            <%=rs_cat.getString("ctitle")%>
                        </td>
                    </tr>
                    <%
                        Statement stm_sub= conn.createStatement();
                        String sql_sub="select subcategory.id as sid, subcategory.title as stitle\n" +
                                "from subcategory where subcategory.category_id="+ rs_cat.getString("cid");
                        ResultSet rs_sub=stm_sub.executeQuery(sql_sub);
                        while(rs_sub.next())
                        {
                    %>
                    <tr style=" text-align:center;background-color: white;">
                        <td style="font-size:1.1em; color: white;">
                            <a href="products.jsp?sid=<%=rs_sub.getString("sid")%>">
                                <div class="cat_item"> <%=rs_sub.getString("stitle")%> </div>
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>
                <div style="background-color: rgb(247,170,31);padding:10px">
                </div>
            </div>
        </div>
    </div>	

   <div>
        <table width=1020 height=573 style="margin:auto">
            <tr>
                <td style="margin:auto">
                    <div>
                        <img src="../images/book_org.jpeg" alt="books" id="div1" />
                        <img src="../images/stationery_original.jpg" alt="stationery" id="div2" />
                        <img src="../images/MakeUp.jpg" alt="kitchenware" id="div3" />
                        <img src="../images/snack_org.jpg" alt="snacks" id="div4" />
                    </div>
                </td>
            </tr>
        </table>
        <HR width="80%" color=#987cb9 SIZE=10 style="FILTER:alpha(opacity=100,finishopacity=0,style=2)" >
        <!-- products -->
        <h1 style="padding:20px; text-align:center">
            New Arrival Products
        </h1>


        <div class="masonry" style="width: 1080px; margin:0px auto;">
            <%
                String sql_product="select product.productname as pname, product.productprice as pprice,product.productnumber as pnumber,product.id as pid, product.image as pimage\n" +
                        "from product order by id desc limit 10 ";
                ResultSet rs_product=stm_cat.executeQuery(sql_product);
                while (rs_product.next())
                {
            %>
            <div class="item">
                <ul>
                    <li>
                        <div class="item_content">
                            <%
                                String str=rs_product.getString("pimage");
                                String[] temp;
                                String delimeter = ";";  // 指定分割字符
                                temp = str.split(delimeter); // 分割字符串
                            %>
                            <a href="product_details.jsp?pid=<%=rs_product.getString("pid")%>">
                                <img src="<% out.print(temp[0]); %>" style="width:300px">
                            </a>
                        </div>
                        <h3>
                            <a href="product_details.jsp?pid=<%=rs_product.getString("pid")%>">
                                <%=rs_product.getString("pname")%>
                            </a>
                        </h3>
                        <p class="desc">number: <%=rs_product.getString("pnumber")%></p>
                        <p class="price">
                            <span><%=rs_product.getString("pprice")%></span>
                        </p>
                    </li>
                </ul>
            </div>
            <%
                }
            %>
        </div>
    
    </div>
     <!--footer-->
     <div style="line-height: 25px; margin-top: 20px;text-align: center; background-color: black; padding: 15px; color: white;">
         Copyright 2020/09, Xiamen University Second-hand Website<br/>
         Hu Yuhang SWE1809351
    </div>
</body>
</html>