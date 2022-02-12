import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
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
        String studentID=request.getParameter("studentID");
        String password=request.getParameter("password");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/secondhand","root","838180"
                    );
            PreparedStatement stm= conn.prepareStatement(
                    "select * from users where student_id=? and password=?");
            stm.setString(1,studentID);
            stm.setString(2,password);

            ResultSet rs=stm.executeQuery();
            if(rs.next())
            {
                HttpSession session=request.getSession();
                session.setAttribute("studentID",studentID);
                session.setAttribute("username",rs.getString("username"));
                session.setAttribute("uid", rs.getString("id"));

                Cookie c_uid= new Cookie("c_uid", rs.getString("id"));
                Cookie c_username= new Cookie("c_studentID",studentID);
                response.addCookie(c_uid);
                response.addCookie(c_username);

                response.sendRedirect("index.jsp");
            }
            else
            {
                response.getWriter().println("<h1>Failed</h1>");
            }
        }
        catch (Exception ex){
            ex.printStackTrace();
        }
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

    }
}
