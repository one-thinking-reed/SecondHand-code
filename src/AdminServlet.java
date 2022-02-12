import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet(name = "AdminServlet")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String newcategory=request.getParameter("newcat");
        String newsubcat=request.getParameter("newsubcat");
        String newsubcategory=request.getParameter("newsub");
        String deletecategory=request.getParameter("delcat");
        String deletesubcat=request.getParameter("delsubcat");
        String deletesubcategory=request.getParameter("delsub");

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/secondhand","root","838180"
                    );
            Statement stm= conn.createStatement();


            if(!newcategory.equals(""))
            {
                String sql = "insert into secondhand.category(title) values ('" + newcategory + "')";
                stm.execute(sql);
            }
            if(!newsubcat.equals("-1")& !newsubcategory.equals(""))
            {
                String sql = "insert into secondhand.subcategory(category_id,title) values ('" + newsubcat + "','"+newsubcategory+"')";
                stm.execute(sql);
            }
            if(!deletecategory.equals("-1"))
            {
                String sql = "delete from category where id="+deletecategory;
                stm.execute(sql);
            }
            if(!deletesubcat.equals("-1")& !deletesubcategory.equals(""))
            {
                String sql_search="select subcategory.id as sid from subcategory where subcategory.title='"+deletesubcategory+"'";
                ResultSet rs= stm.executeQuery(sql_search);
                rs.next();
                String id=rs.getString("sid");
                String sql = "delete from subcategory where id="+id;
                stm.execute(sql);
            }

            response.sendRedirect("Admin.jsp");
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
