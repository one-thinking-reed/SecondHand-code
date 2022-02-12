import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.SimpleDateFormat;

@WebServlet(name = "LeaveMessageServlet")
public class LeaveMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String productID= request.getParameter("pid");
        String receiver=request.getParameter("receiver");
        String message=request.getParameter("newmessage");

        java.util.Date d= new java.util.Date();
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cur_time= sdf.format(d);


        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/secondhand","root","838180"
                    );
            Statement stm= conn.createStatement();
            String sql = "insert into secondhand.message(sender,receiver, message, productID, time)"
                    + " values ('" + session.getAttribute("uid") + "', '" + receiver + "', '" + message + "', '" + productID + "', '" + cur_time + "')";
            stm.execute(sql);
            response.sendRedirect("profile.jsp?uid="+receiver);
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
