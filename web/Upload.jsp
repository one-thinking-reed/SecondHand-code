<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.awt.image.RescaleOp" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("studentID")==null)
        response.sendRedirect("Login.jsp");
%>
<!DOCTYPE html>
<head>
    <title>Document</title>
    <link href='https://fonts.googleapis.com/css?family=Aclonica' rel='stylesheet'>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/header.css">

    <style>
        select, input, textarea{
            border: 1px solid #ccc; 
            border-radius: 3px;
            padding: 13px 14px;
            width: 500px;
            font-size: 18px;
            font-weight: 700;
            font-family:"Microsoft soft";
        }
        /*input{*/
            /*outline-style: none ;*/
        /*}*/
        textarea:focus,input:focus{
            border-color: #66afe9;
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
        }
        #show img{
            max-width: 200px;
            max-height: 200px;
            box-shadow: 0px 1px 1px 1px #AAA3A3;
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
                document.getElementById("Category").options.add(newoption);
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

            var value=document.getElementById("Category").value;
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
            <a href="profile.jsp?uid="<%=session.getAttribute("uid")%>><div class="nav_item"> [<%=session.getAttribute("username")%>] </div></a>
            <a href="LogoutServlet"><div class="nav_item"> Logout </div></a>
        </div>
    </div>
   <!-- background -->
   <div class="row" style=" position:relative;z-index:1;">
        <img src="../images/upload.jpg" style="width:100%; opacity:0.5 ;filter: alpha(opacity=60);padding:0px;"/>
        <div style="width:900px; margin:auto; position:absolute;z-index:2; top:10%; left:25%; 
                    text-align:center;
                    background-color: wheat;">
            <div style="color:white; font-size: 60px; font-weight:900; margin:20px">Upload Product</div>
            <form id="uploadproduct" method="post" action="UploadProductServlet" enctype="multipart/form-data">
                <table width="100%" Cellpadding="20px" style="font-size: 20px; font-weight: 900;">
                    <tr>
                        <td><input name="pname" type="text"  placeholder="Product name: "></td>
                    </tr>
                    <tr>
                        <td><input name="pprice" type="text" placeholder="Product price: "></td>
                    </tr>
                    <tr>
                        <td><input name="pnumber" type="text" placeholder="Product number: "></td>
                    </tr>
                    <tr>
                        <td>
                            <textarea name="pdetail" rows="4" cols="59" placeholder="Describe your product here..."></textarea>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <select name="pcategory" style="width: 530px;" id="Category" onChange="changeCategory( )">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select name="psubcategory" style="width: 530px;" id="subCategory">
                                <option value="Stationery">Stationery</option>
                                <option value="Online Classes">Online Classes</option>
                                <option value="Textbook">Textbook</option>
                                <option value="Electronic Product">Electronic Product</option>
                                <option value="Others">Others</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input name="ppicture" type="file" id='upimg' multiple="multiple">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <!-- show表示<div id='show'></div>，用来展示图片预览的 -->
                            <div id='show'></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input style="width:150px; margin:0 50px 0 0" type="submit" name="Submit"  value="Submit" onclick="document.getElementById('uploadproduct').submit();">
                            <input style="width:150px; margin:0 0 0 10px" type="reset" name="Reset" id="Reset" value="Reset">
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
    <script type="text/javascript">
        var upimg = document.querySelector('#upimg');
        upimg.addEventListener('change', function(e){
            var files = this.files;
            if(files.length){
                console.log(files.length);
                if(files.length>1){
                    alert("The maximum number is 1! Please select again! ");
                    return;
                }
                else{
                    var html='', i=0;
                    var func = function(){
                        if(i>=files.length){

                            show.innerHTML = html;
                        }
                        var file = files[i];
                        var reader = new FileReader();

                        reader.onload = function(e){
                            html += '<img src="'+e.target.result+'" alt="img">';
                            i++;
                            func();
                        }
                        reader.readAsDataURL(file);
                    }
                    func();
                }
            }
        });
        var reset=document.getElementById("Reset");
        reset.addEventListener('click',function(e){
            show.innerHTML='';
        });
    </script>
</body>

</html>