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
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Concert+One&display=swap" rel="stylesheet">  
    <link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/category.css">
    <link rel="stylesheet" href="../css/productDisplay.css">

    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/product.js"></script>
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
        <img src="../images/study.jpg" style="width:100%; opacity:0.5 ;filter: alpha(opacity=60);padding:0px;"/>
       <%
           Class.forName("com.mysql.jdbc.Driver");
           Connection conn=
                   DriverManager.getConnection(
                           "jdbc:mysql://localhost:3306/secondhand","root","838180"
                   );
           Statement stm= conn.createStatement();
           String sql="select category.title as ctitle, subcategory.title as stitle, subcategory.id as sid\n" +
                   "from subcategory, category\n" +
                   "where category.id=subcategory.category_id and subcategory.id="+request.getParameter("sid");
           ResultSet rs=stm.executeQuery(sql);
           rs.next();
       %>
        <div style="width:100%;position:absolute; z-index:2; top:10%; text-align:center;">
            <div style="color: rgb(20, 93, 93); font-size: 70px; font-family: 'Concert One', cursive; "><%=rs.getString("ctitle")%> / <%=rs.getString("stitle")%></div>
        </div>

        <!-- category -->
       <%
           Statement stm_cat= conn.createStatement();
           String sql_cat="select category.id as cid, category.title as ctitle\n" +
                   "from category";
           ResultSet rs_cat=stm_cat.executeQuery(sql_cat);

       %>
       <div class="category">
           <%
               while(rs_cat.next())
               {
           %>
            <div class="maintip">
                <%=rs_cat.getString("ctitle")%>
            </div>
            <div class="tips">
                <%
                    Statement stm_sub= conn.createStatement();
                    String sql_sub="select subcategory.id as sid, subcategory.title as stitle\n" +
                            "from subcategory where subcategory.category_id="+ rs_cat.getString("cid");
                    ResultSet rs_sub=stm_sub.executeQuery(sql_sub);
                    while(rs_sub.next())
                    {
                %>
                <p class=tips_items><a href="products.jsp?sid=<%=rs_sub.getString("sid")%>"><%=rs_sub.getString("stitle")%></a></p>
                <%
                    }
                %>
            </div>
           <%
               }
           %>
        </div>
    </div>

    <div class="masonry" style="width: 1080px; margin:0px auto;">
        <%
            String sql_product="select product.id as pid, product.productname as pname, product.productprice as pprice,product.productnumber as pnumber, product.image as pimage\n" +
                    "from product where product.subcategory_id="+request.getParameter("sid");
            ResultSet rs_product=stm.executeQuery(sql_product);
            while(rs_product.next())
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
                    <h3><a href="product_details.jsp?pid=<%=rs_product.getString("pid")%>">
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

     <!--footer-->
     <div style="line-height: 25px; margin-top: 20px;text-align: center; background-color: black; padding: 15px; color: white;">
         Copyright 2020/09, Xiamen University Second-hand Website<br/>
         Hu Yuhang SWE1809351
    </div>
</body>
</html>