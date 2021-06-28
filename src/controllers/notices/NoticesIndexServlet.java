package controllers.notices;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Employee;
import models.Report;
import utils.DBUtil;
/**
 * Servlet implementation class NoticesIndexServlet
 */
@WebServlet("/notices/index")
public class NoticesIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticesIndexServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        Employee login_employee = (Employee)request.getSession().getAttribute("login_employee");

        int page;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        }catch(Exception e) {
            page = 1;
        }
        List<Report> members = em.createNamedQuery("getAllMembers", Report.class)
                .setFirstResult(15 * (page - 1))
                .setMaxResults(15)
                .getResultList();

        long members_count = (long) em.createNamedQuery("getMembersCount", Long.class)
                .getSingleResult();

        List<Report> reads = em.createNamedQuery("getMyAllReads",Report.class)
                .setParameter("employee", login_employee)
                .setFirstResult(15 * (page -1))
                .setMaxResults(15)
                .getResultList();

        long reads_count = (long)em.createNamedQuery("getMyReadsCount", Long.class)
                                        .setParameter("employee", login_employee)
                                        .getSingleResult();

        em.close();

        request.setAttribute("members", members);
        request.setAttribute("members_count", members_count);
        request.setAttribute("page", page);

        request.setAttribute("reads", reads);
        request.setAttribute("reads_count", reads_count);
        request.setAttribute("page", page);

        if(request.getSession().getAttribute("flush") != null) {
            request.setAttribute("flush", request.getSession().getAttribute("flush"));
            request.getSession().removeAttribute("flush");
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/notices/index.jsp");
        rd.forward(request, response);
    }

}
