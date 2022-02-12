<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.awt.image.RescaleOp" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("uid")==null)
    {
        response.sendRedirect("Login.jsp");
    }
    else{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn=
                DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/secondhand","root","838180"
                );
        Statement stm= conn.createStatement();
        String sql="select users.status as ustatus from users where users.id="+session.getAttribute("uid");
        ResultSet rs=stm.executeQuery(sql);
        rs.next();
        if(rs.getInt("ustatus")!=1){
            response.sendRedirect("alert.jsp");
        }
    }
%>

<!DOCTYPE html>
<head>
    <title>Document</title>
    <link href='https://fonts.googleapis.com/css?family=Aclonica' rel='stylesheet'>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/productDisplay.css">
    <link rel="stylesheet" href="../css/input.css">
    <style>
        select, input{
            border: 1px solid #ccc;
            border-radius: 3px;
            padding: 13px 14px;
            width: 500px;
            font-size: 18px;
            font-weight: 700;
            font-family:"Microsoft soft";
        }

        /* Set a style for all buttons */
        li button {
            background-color: #f44336;
            color: white;
            padding: 14px 20px;
            margin: 20px;
            border: none;
            cursor: pointer;
            width: 80%;
            opacity: 0.9;
        }

        button:hover {
            opacity:1;
        }
        /* Float cancel and delete buttons and add an equal width */
        .cancelbtn, .deletebtn {
            margin:10px;
            width: 150px;
            height: 30px;
            font-size:20px;
        }
        /* Add a color to the cancel button */
        .cancelbtn {
            background-color: #ccc;
            color: black;
        }
        /* Add a color to the delete button */
        .deletebtn {
            background-color: #f44336;
        }
        /* Add padding and center-align text to the container */
        .contain {
            padding: 16px;
            text-align: center;
        }
        /* The Modal (background) */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 35%;
            top: 25%;
            width: 500px;
            height: 230px;
            overflow: auto;
            background-color: wheat;
        }
        /* Clear floats */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }

    </style>
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript">
        var subCategoryList = new Array();
        $(document).ready(function() {
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
            var newoption;
            var i=1;
            <%
            while(rs_cat.next())
           {
            %>
            newoption=new Option("<%=rs_cat.getString("ctitle")%>",<%=rs_cat.getString("cid")%>);
            document.getElementById("Category2").options.add(newoption);
            subCategoryList[i] = new Array();
            <%
                Statement stm_sub= conn.createStatement();
                String sql_sub="select subcategory.id as sid, subcategory.title as stitle\n" +
                        "from subcategory where subcategory.category_id="+ rs_cat.getString("cid");
                ResultSet rs_sub=stm_sub.executeQuery(sql_sub);
                while(rs_sub.next())
                {
            %>
            subCategoryList[i].push("<%=rs_sub.getString("stitle")%>");

            <%
                 }
            %>
            ++i;
            <%
           }
            %>
        })

        function changeCategory( )
        {
            document.getElementById("subCategory").options.length=0;
            var value=document.getElementById("Category2").value;
            var newoption1;
            for (var j in subCategoryList[value])
            {
                newoption1=new Option(subCategoryList[value][j], subCategoryList[value][j]);
                document.getElementById("subCategory").options.add(newoption1);
            }
        }
    </script>
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
    <div style="width:1100px; margin:auto; position:absolute;z-index:2; top:3%; left:20%;
                    text-align:center;
                    background-color: wheat;">
            <div style="color:white; font-size: 60px; font-weight:900; margin:20px">Admin</div>
            <form id="Admin" method="post" action="AdminServlet">
                <table width="100%" Cellpadding="20px" style="font-size: 20px; font-weight: 900;">
                    <tr>
                        <td>Add Category: </td>
                        <td><input name="newcat" type="text"  placeholder="Category name: "></td>
                    </tr>
                    <tr>
                        <td>Add subCategory: </td>
                        <td>
                            <select name="newsubcat" style="width: 530px;">
                                <option value="-1"></option>
                                <%
                                    rs_cat.beforeFirst();
                                    while(rs_cat.next())
                                    {
                                %>
                                <option value="<%=rs_cat.getString("cid")%>">
                                    <%=rs_cat.getString("ctitle")%>
                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input name="newsub" type="text"  placeholder="Subcategory name: ">
                        </td>
                    </tr>
                    <tr>
                        <td>Delete Category: </td>
                        <td>
                            <select name="delcat" style="width: 530px;">
                                <option value="-1"></option>
                                <%
                                    rs_cat.beforeFirst();
                                    while(rs_cat.next())
                                    {
                                %>
                                <option value="<%=rs_cat.getString("cid")%>">
                                    <%=rs_cat.getString("ctitle")%>
                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Delete subCategory:</td>
                        <td>
                            <select name="delsubcat" style="width: 530px;" id="Category2" onChange="changeCategory( )">
                                <option value="-1"></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <select name="delsub" style="width: 530px;" id="subCategory">
                                <option value="-1"></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <input style="width:150px; margin:0 50px 0 0" type="submit" name="Submit"  value="Submit" onclick="document.getElementById('Admin').submit();">
                            <input style="width:150px; margin:0 0 0 10px" type="reset" name="Reset" id="Reset" value="Reset">
                        </td>
                    </tr>
                </table>
            </form>
    </div>
</div>

<div class="masonry" style="width: 1080px; margin:0px auto;">
    <%
            Statement stm_product=conn.createStatement();
            String sql_product="select product.id as pid, product.productname as pname, product.productprice as pprice,product.productnumber as pnumber, product.image as pimage\n" +
                    "from product";
            ResultSet rs_product=stm_product.executeQuery(sql_product);
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
                <button onclick="document.getElementById('<%=rs_product.getString("pid")%>').style.display='block'">Delete</button>
            </li>
        </ul>
    </div>
    <div id="<%=rs_product.getString("pid")%>" class="modal">
        <div class="contain">
            <h1>Delete Product</h1>
            <p style="font-size: 20px;">Are you sure you want to delete your product?</p>
            <div class="clearfix">
                <button type="button" onclick="document.getElementById('<%=rs_product.getString("pid")%>').style.display='none'" class="cancelbtn">Cancel</button>
                <a href="AdminProductServlet?pid=<%=rs_product.getString("pid")%>">
                    <button type="button" onclick="document.getElementById('<%=rs_product.getString("pid")%>').style.display='none'" class="deletebtn">Delete</button>
                </a>
            </div>
        </div>
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