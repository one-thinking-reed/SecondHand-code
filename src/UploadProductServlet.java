import com.sun.xml.internal.ws.wsdl.writer.document.Part;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig
@WebServlet(name = "UploadProductServlet")
public class UploadProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String productname=request.getParameter("pname");
        String productnumber=request.getParameter("pnumber");
        String productprice=request.getParameter("pprice");
        String productdetail=request.getParameter("pdetail");
        String category=request.getParameter("pcategory");
        String subcategory=request.getParameter("psubcategory");

        System.out.println();

        InputStream is=
                request.getPart("ppicture").getInputStream();
        byte[] buffer=new byte[100*1024*1024];
        int len_image= is.read(buffer);

        String path1= getServletContext().getRealPath("/images/")+ productname+ ".jpg" ;
        String path=  path1.replaceAll("\\\\","/");

        OutputStream os= new FileOutputStream(path);
        os.write(buffer,0,len_image);
        os.flush();
        os.close();
        String path2="images/"+productname+".jpg";

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/secondhand","root","838180"
                    );
            Statement stm= conn.createStatement();
            String sql_search="select subcategory.id as sid from subcategory where subcategory.title='"+subcategory+"'";
            ResultSet rs= stm.executeQuery(sql_search);
            rs.next();
            String id=rs.getString("sid");
            String sql = "insert into secondhand.product(productname, productprice, productnumber, category_id, subcategory_id, productdetail,image,user_id)"
                    + " values ('" + productname + "', '" + productprice + "', '" + productnumber + "', '" + category + "', '"+ id+"','"+ productdetail+"','"+path2+"','"+request.getSession().getAttribute("uid")+"')";
            stm.execute(sql);
            response.sendRedirect("index.jsp");
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
   }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
