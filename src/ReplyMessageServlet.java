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

@WebServlet(name = "ReplyMessageServlet")
public class ReplyMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String replymessage= request.getParameter("replymessage");
        String mid=request.getParameter("mid");
        String rid=request.getParameter("rid");
        java.util.Date d= new java.util.Date();
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cur_time= sdf.format(d);
        HttpSession session = request.getSession();

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/secondhand","root","838180"
                    );
            Statement stm= conn.createStatement();
            String sql = "insert into secondhand.reply(message_id,sender, receiver, message, time)"
                    + " values ('" + mid + "', '" + session.getAttribute("uid") + "', '" + rid + "', '" + replymessage + "', '" + cur_time + "')";
            stm.execute(sql);
            response.sendRedirect("profile.jsp?uid="+session.getAttribute("uid"));
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
