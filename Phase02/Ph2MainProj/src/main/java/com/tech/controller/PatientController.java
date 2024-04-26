package com.tech.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.dao.DB;
import com.tech.models.AdminModel;
import com.tech.models.PatientModel;

@WebServlet("/PatientController")
public class PatientController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    DB db = DB.getDb();
    
    public PatientController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("mode").equals("delete")) {
			doDelete(request, response);
			return;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("mode").equals("update")) {
			doPut(request, response);
			return;
		}
		
		HttpSession sess = request.getSession();
		AdminModel admin = (AdminModel) sess.getAttribute("admin");
		
		PatientModel model = new PatientModel();
		model.name = request.getParameter("name");
		model.email = request.getParameter("email");
		model.phone = request.getParameter("phone");
		model.age = Integer.parseInt(request.getParameter("age"));
		model.diagnosis = request.getParameter("diagnosis");
		model.remarks = request.getParameter("remarks");
		model.gender = request.getParameter("gender");
		model.createdByAdminId = admin.adminId;

		int result = db.executeUpdate(model.getPatientInsertQuery());
		if(result > 0) {
			response.sendRedirect("managePatients.jsp");
		} else {
			request.setAttribute("message", "Something went wrong!! Please Try Again");
			request.getRequestDispatcher("/patientForm.jsp?mode=add").forward(request, response);
		}
		
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PatientModel model = new PatientModel();
		model.patientId = Integer.parseInt(request.getParameter("patientId"));
		model.name = request.getParameter("name");
		model.email = request.getParameter("email");
		model.phone = request.getParameter("phone");
		model.age = Integer.parseInt(request.getParameter("age"));
		model.diagnosis = request.getParameter("diagnosis");
		model.gender = request.getParameter("gender");
		model.remarks = request.getParameter("remarks");

		int result = db.executeUpdate(model.getUpdateQuery());
		if(result > 0) {
			response.sendRedirect("managePatients.jsp");
		} else {
			request.setAttribute("message", "Something went wrong!! Please Try Again");
			response.getWriter().print("Something went wrong");
			response.getWriter().close();
			request.getRequestDispatcher("/patientForm.jsp?mode=update").forward(request, response);
		}
	}

	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int patientId = Integer.parseInt(request.getParameter("patientId"));
		db.executeUpdate(PatientModel.getDeleteQuery(patientId));
		response.sendRedirect("managePatients.jsp");
	}

}