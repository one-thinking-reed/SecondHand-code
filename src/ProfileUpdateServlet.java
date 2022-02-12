import jdk.nashorn.internal.runtime.Debug;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig
@WebServlet(name = "ProfileUpdateServlet")
public class ProfileUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String uid= (String)request.getSession().getAttribute("uid");
        String path2="";

        InputStream is = request.getPart("headimg").getInputStream();
        byte[] buffer = new byte[100 * 1024 * 1024];
        int len_image = is.read(buffer);

        String path1 = getServletContext().getRealPath("/images/") + uid + ".jpg";
        String path = path1.replaceAll("\\\\", "/");

        OutputStream os = new FileOutputStream(path);
        os.write(buffer, 0, len_image);
        os.flush();
        os.close();
        path2 = "images/" + uid + ".jpg";

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/secondhand","root","838180"
                    );
            Statement stm=conn.createStatement();
            String sql="update users set image='"+path2+"'where id='"+uid+"'";
            stm.execute(sql);

            response.sendRedirect("profile.jsp?uid="+uid);

        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
