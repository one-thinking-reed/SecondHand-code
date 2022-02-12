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
    <link rel="stylesheet" href="../css/input.css">
    <link rel="stylesheet" href="../css/profile.css">
    <script>
        function doclick(){
            var docs=document.getElementsByClassName("selfinfo");
            for(var i=0;i<docs.length;i++){
                docs[i].contentEditable=true;
            }
            var head=document.getElementById("headimg");
            head.style.display="";
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
    <%
        String seller=request.getParameter("uid");
        if(seller.equals(""))
            seller=(String)session.getAttribute("uid");
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn=
                DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/secondhand","root","838180"
                );
        Statement stm_user= conn.createStatement();
        String sql_user="select * from users where users.id="+ seller;
        ResultSet rs_user=stm_user.executeQuery(sql_user);
        rs_user.next();
    %>
   <div class="row" style=" position:relative;">
       <%--background image--%>
        <img src="../images/user.jpg" style=" width:100%; opacity:0.5 ;filter: alpha(opacity=60);padding:0px;"/>
        <div style="width:1200px; margin:auto; position:absolute; top:10%; left:18%; z-index:2;">
            <form id="modifyinfo" action="ProfileUpdateServlet" enctype="multipart/form-data" method="post">
            <table width="100%" style="margin: 50px; background-color:wheat; z-index:2; 
                                font-family: 'Courier New', Courier, monospace; font-weight:900;">
                <tr>
                    <td width="50%" style="text-align: center; border-right: 5px dotted rgb(56, 105, 0);">
                        <img style="border-radius: 100px; margin-top:20px;  width:250px; height:250px;" src="<%=rs_user.getString("image")%>" onerror="this.src='images/default.png'"><br/>
                        <input id="headimg" type="file" name="headimg" style="display: none;"></br>
                        <p style="font-size:30px;"><%=rs_user.getString("username")%></p>
                    </td>
                    <td width="50%" style="padding-left:50px;">
                        <table width="100%" style="font-size: 30px;">
                             <tr>
                                 <td>Gender</td>
                                 <td>
                                 <%
                                     if(rs_user.getInt("gender")==1)
                                         out.print("Female");
                                     else
                                         out.print("Male");
                                 %>
                                 </td>
                             </tr>
                             <tr>
                                 <td>StudentID</td>
                                 <td><%=rs_user.getString("student_id")%></td>
                             </tr>
                             <tr>
                                 <td>Mobile</td>
                                 <td><%=rs_user.getString("mobile")%></td>
                             </tr>
                             <tr>
                                 <td>E-mail</td>
                                 <td><%=rs_user.getString("email")%></td>
                             </tr>
                            <%
                                //user himself
                                Object requestid1=request.getParameter("uid");
                                if(request.getParameter("uid").equals(session.getAttribute("uid"))||requestid1.equals(""))
                                {
                            %>
                            <tr>
                                <td><input style="width:150px; margin:0 50px 0 0" type="button" value="Edit" onclick="doclick();"></td>
                                <td><input style="width:150px; margin:0 0 0 10px" type="submit" name="Submit" value="Save" onclick="document.getElementById('modifyinfo').submit();"></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                    </td>
                </tr>
            </table>
            </form>
        </div>
    </div>
    <div class="container">
        <div class="tab-wrapper">
            <!--tab section 1-->
            <input type="radio" name="tab-radio" class="tab-radio" id="tab-radio-1" checked>
            <label for="tab-radio-1" class="tab-handler">Buyer Messages</label>
            <div class="tab-content">
                <div style="margin:30px auto; width:1200px;">
                    <%
                        Statement stm_message=conn.createStatement();
                        String sql_message;
                        Object requestid=request.getParameter("uid");
                        Object userid=session.getAttribute("uid");
                        //buyer
                        if( !requestid.equals("") && !requestid.equals(userid) ) {
                            sql_message = "select message.id as mid, message.sender as msender,users.username as uname, message.receiver as mreceiver, message.productID as mproductID, message.message as mmessage, message.time as mtime, product.productname as pname\n" +
                                    "from message, product,users\n" +
                                    "where product.id=message.productID and message.sender=users.id and message.sender="+session.getAttribute("uid")+" and message.receiver="+request.getParameter("uid")+"";

                        }
                        //userhimself
                        else {
                            sql_message = "select message.id as mid, message.sender as msender,users.username as uname, message.receiver as mreceiver, message.productID as mproductID, message.message as mmessage, message.time as mtime, product.productname as pname\n" +
                                    "from message, product,users\n" +
                                    "where product.id=message.productID and message.sender=users.id and message.receiver=" + session.getAttribute("uid");
                            }
                        ResultSet rs_message=stm_message.executeQuery(sql_message);
                        while(rs_message.next())
                        {
                    %>
                    <table class="message" style="border:0px; margin:10px 0px; padding:0px; width:100%;">
                        <tr style="background-color:#DDDDDD;">
                            <td width=20%>From</td>
                            <td width=20%>Product</td>
                            <td width=40%>Content</td>
                            <td width=20%>Date</td>
                        </tr>
                        <tr style="background-color:#EEEEEE;">
                            <td width=20%><%=rs_message.getString("uname")%></td>
                            <td width=20%><%=rs_message.getString("pname")%></td>
                            <td width=40%><%=rs_message.getString("mmessage")%></td>
                            <td width=20%><%=rs_message.getString("mtime")%></td>
                        </tr>
                        <%
                            Statement stm_reply=conn.createStatement();
                            String sql_reply="select reply.id as rid, reply.message_id as replymessageID, reply.sender as rsender, reply.receiver as rreceiver, reply.message as rmessage, reply.time as rtime, users.username as username\n" +
                                    "from reply,users\n" +
                                    "where users.id=reply.sender and reply.message_id="+ rs_message.getString("mid");
                            ResultSet rs_reply=stm_reply.executeQuery(sql_reply);
                            while(rs_reply.next())
                            {
                        %>
                                <tr style="background-color:#EEEEEE;">
                                    <td width=20%><%=rs_reply.getString("username")%></td>
                                    <td width=20%></td>
                                    <td width=40%><%=rs_reply.getString("rmessage")%></td>
                                    <td width=20%><%=rs_reply.getString("rtime")%></td>
                                </tr>
                        <%
                            }
                            if(request.getParameter("uid").equals(session.getAttribute("uid"))||requestid.equals("")) {
                        %>
                        <tr>
                            <td width=20%></td>
                            <td width=20%></td>
                            <td width=40%></td>
                            <td width=20%>
                                <input style="width:100px; margin:auto" type="submit" value="Reply" onclick="document.getElementById('<%=rs_message.getString("mid")%>').style.display='';">
                            </td>
                        </tr>
                    </table>

                    <form id="<%=rs_message.getString("mid")%>" style="display: none;" method="post" action="ReplyMessageServlet">
                        <input type="hidden" name="mid" value="<%=rs_message.getString("mid")%>">
                        <input type="hidden" name="rid" value="<%=rs_message.getString("msender")%>">
                        <table width=100% style="text-align: center;">
                            <tr>
                                <td><textarea name="replymessage" style="width:1000px; height:150px;" placeholder="Reply the message here. "></textarea></td>
                            </tr>
                            <tr>
                                <td>
                                    <input style="width:150px; margin:auto" type="submit" value="Submit" onclick="document.getElementById('<%=rs_message.getString("mid")%>').submit();">
                                    <input style="width:150px; margin:auto" type="reset" value="Reset">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                            }
                        }
                        if( !requestid.equals("") && !requestid.equals(userid) )
                        {
                    %>
                    <form id="leave_message" method="post" action="LeaveMessageServlet">
                        <input type="hidden" name="pid" value="<%=request.getParameter("pid")%>">
                        <input type="hidden" name="receiver" value="<%=request.getParameter("uid")%>">
                        <table width=100% style="text-align: center;">
                            <tr>
                                <td><textarea name="newmessage"id="content" style="width:1000px; height:150px;" placeholder="Leave a new message here. "></textarea></td>
                            </tr>
                            <tr>
                                <td>
                                    <input style="width:150px; margin:auto" type="submit" value="Submit" onclick="document.getElementById('leave_message').submit();">
                                    <input style="width:150px; margin:auto" type="reset" value="Reset">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                        }
                    %>
                </div>
            </div>
            <!--tab section 2-->
            <input type="radio" name="tab-radio" class="tab-radio" id="tab-radio-2">
            <label for="tab-radio-2" class="tab-handler">Seller Messages</label>
            <div class="tab-content">
                <div style="margin:30px auto; width:1200px;">
                    <%
                        //user himself
                        if(request.getParameter("uid").equals(session.getAttribute("uid"))||requestid.equals(""))
                        {
                            Statement stm_message_buy=conn.createStatement();
                            String sql_message_buy="select message.id as mid, message.sender as msender,users.username as uname, message.receiver as mreceiver, message.productID as mproductID, message.message as mmessage, message.time as mtime, product.productname as pname\n" +
                                    "from message, product,users\n" +
                                    "where product.id=message.productID and message.sender=users.id and message.sender="+session.getAttribute("uid");
                            ResultSet message_buy=stm_message_buy.executeQuery(sql_message_buy);
                            while(message_buy.next())
                            {
                    %>
                    <table class="message" style="border:0px; margin:10px 0px; padding:0px; width:100%;">
                        <tr style="background-color:#DDDDDD;">
                            <td width=20%>From</td>
                            <td width=20%>Product</td>
                            <td width=40%>Content</td>
                            <td width=20%>Date</td>
                        </tr>
                        <tr style="background-color:#EEEEEE;">
                            <td width=20%><%=message_buy.getString("uname")%></td>
                            <td width=20%><%=message_buy.getString("pname")%></td>
                            <td width=40%><%=message_buy.getString("mmessage")%></td>
                            <td width=20%><%=message_buy.getString("mtime")%></td>
                        </tr>
                        <%
                            Statement stm_buy_reply=conn.createStatement();
                            String sql_buy_reply="select reply.id as rid, reply.message_id as replymessageID, reply.sender as rsender, reply.receiver as rreceiver, reply.message as rmessage, reply.time as rtime, users.username as username\n" +
                                    "from reply,users\n" +
                                    "where users.id=reply.sender and reply.message_id="+ message_buy.getString("mid");
                            ResultSet rs_buy_reply=stm_buy_reply.executeQuery(sql_buy_reply);
                            while(rs_buy_reply.next())
                            {
                        %>
                        <tr style="background-color:#EEEEEE;">
                            <td width=20%><%=rs_buy_reply.getString("username")%></td>
                            <td width=20%></td>
                            <td width=40%><%=rs_buy_reply.getString("rmessage")%></td>
                            <td width=20%><%=rs_buy_reply.getString("rtime")%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td width=20%></td>
                            <td width=20%></td>
                            <td width=40%></td>
                            <td width=20%>
                                <input style="width:100px; margin:auto" type="submit" value="Reply" onclick="document.getElementById('<%=message_buy.getString("mid")%>').style.display='';">
                            </td>
                        </tr>
                    </table>

                    <form id="<%=message_buy.getString("mid")%>" style="display: none;" method="post" action="ReplyMessageServlet">
                        <input type="hidden" name="mid" value="<%=message_buy.getString("mid")%>">
                        <input type="hidden" name="rid" value="<%=message_buy.getString("msender")%>">
                        <table width=100% style="text-align: center;">
                            <tr>
                                <td><textarea name="replymessage" style="width:1000px; height:150px;" placeholder="Reply the message here. "></textarea></td>
                            </tr>
                            <tr>
                                <td>
                                    <input style="width:150px; margin:auto" type="submit" value="Submit" onclick="document.getElementById('<%=message_buy.getString("mid")%>').submit();">
                                    <input style="width:150px; margin:auto" type="reset" value="Reset">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
          <!--tab section 3-->
          <input type="radio" name="tab-radio" class="tab-radio" id="tab-radio-3">
          <label for="tab-radio-3" class="tab-handler">On sale products </label>
          <div class="tab-content">
              <div class="masonry" style="width: 1080px; margin:0px auto;">
                  <%
                      //if user himself
                      if(request.getParameter("uid").equals(session.getAttribute("uid"))||requestid.equals("")) {
                      Statement stm_product=conn.createStatement();
                      String sql_product="select product.productname as pname, product.productprice as pprice,product.productnumber as pnumber,product.id as pid, product.image as pimage\n" +
                              "from product where product.user_id="+ session.getAttribute("uid");
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
                              <a href="DelProductServlet?pid=<%=rs_product.getString("pid")%>">
                                  <button type="button" onclick="document.getElementById('<%=rs_product.getString("pid")%>').style.display='none'" class="deletebtn">Delete</button>
                              </a>
                          </div>
                      </div>
                  </div>
                  <%
                      }
                  }
                  %>
              </div>
          </div>
        </div>
    </div>


     <!--footer-->
     <div style="position: relative; line-height: 25px; margin-top: 20px;text-align: center; background-color: black; padding: 15px; color: white;">
         Copyright 2020/09, Xiamen University Second-hand Website<br/>
         Hu Yuhang SWE1809351
    </div>
</body>
</html>