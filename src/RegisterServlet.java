import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

@WebServlet(name = "RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("username");
        String gender=request.getParameter("gender");
        String studentID=request.getParameter("studentID");
        String password=request.getParameter("password");
        String email= request.getParameter("email");
        String phone= request.getParameter("phone");

        java.util.Date d= new java.util.Date();
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cur_time= sdf.format(d);
        HttpSession session=request.getSession();


        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/secondhand","root","838180"
                    );
            Statement stm= conn.createStatement();
            String sql = "insert into secondhand.users(username, password, gender, email, mobile, register_time,student_id,status,image)"
                    + " values ('" + username + "', '" + password + "', '" + gender + "', '" + email + "', '"+ phone+"','"+ cur_time+"','"+studentID+"',2,'')";
            stm.execute(sql);
            response.sendRedirect("Login.jsp");
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
