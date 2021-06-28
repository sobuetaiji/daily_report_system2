package controllers.departments;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Department;
import models.validators.DepartmentValidator;
import utils.DBUtil;
/**
 * Servlet implementation class DepartmentsUpdateServlet
 */
@WebServlet("/departments/update")
public class DepartmentsUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DepartmentsUpdateServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String _token = request.getParameter("_token");
        if (_token != null && _token.equals(request.getSession().getId())) {
            EntityManager em = DBUtil.createEntityManager();

            Department d = em.find(Department.class, (Integer) (request.getSession().getAttribute("department_id")));

            d.setDepartment_date(Date.valueOf(request.getParameter("department_date")));
            d.setName(request.getParameter("name"));
            d.setUpdated_at(new Timestamp(System.currentTimeMillis()));

            List<String> errors = DepartmentValidator.validate(d);
            if(errors.size() > 0) {
                em.close();

                request.setAttribute("_token", request.getSession().getId());
                request.setAttribute("department", d);
                request.setAttribute("errors", errors);


                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/departments/edit.jsp");
                rd.forward(request, response);
            }else {
                em.getTransaction().begin();
                em.getTransaction().commit();
                em.close();
                request.getSession().setAttribute("flush","登録が完了しました。");

                request.getSession().removeAttribute("department_id");

                response.sendRedirect(request.getContextPath() + "/departments/index");
            }
    }
    }

}
