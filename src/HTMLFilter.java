import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(filterName = "HTMLFilter")
public class HTMLFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {

        String detail=req.getParameter("pdetail");
        String name=req.getParameter("pname");
        String price=req.getParameter("pprice");

        if(detail.contains("<")||detail.contains(">"))
        {
            resp.getWriter().println("illegal chars");
        }
        else if(name.contains("<")||name.contains(">"))
        {
            resp.getWriter().println("illegal chars");
        }
        else if(price.contains("<")||price.contains(">"))
        {
            resp.getWriter().println("illegal chars");
        }
        else
        {
            chain.doFilter(req, resp);
        }

    }

    public void init(FilterConfig config) throws ServletException {

    }

}
