package com.tech.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.dao.DB;
import com.tech.models.VitalModel;

/**
 * Servlet implementation class VitalController
 */
@WebServlet("/VitalController")
public class VitalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
      DB db = DB.getDb();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VitalController() {
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
		if(request.getParameter("patientId") == null) {
			request.setAttribute("message", "Please Select Patient");
			request.getRequestDispatcher("vitalForm.jsp").include(request, response);
			return;
		}
		
		VitalModel vital = new VitalModel();
		vital.bpLow = request.getParameter("bpLow") == null ? 0 : Integer.parseInt(request.getParameter("bpLow"));
		vital.bpHigh = request.getParameter("bpHigh") == null ? 0 : Integer.parseInt(request.getParameter("bpHigh"));
		vital.spo2 = request.getParameter("spo2") == null ? 0 : Integer.parseInt(request.getParameter("spo2"));
		vital.patientId = request.getParameter("patientId") == null ? 0 : Integer.parseInt(request.getParameter("patientId"));
		
		int result = db.executeUpdate(vital.getInsertQuery());
		if(result > 0) {
			String redirect = request.getParameter("isPatientVitals").equals("true") ? "manageVitals.jsp?patientId=" + vital.patientId : "manageVitals.jsp";
			response.sendRedirect(redirect);
		} else {
			request.setAttribute("message", "Something went wrong!! Please Try Again");
			request.getRequestDispatcher("vitalForm.jsp").include(request, response);
		}
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int vitalId = Integer.parseInt(request.getParameter("vitalId"));
		db.executeUpdate("delete from "+VitalModel.TABLE_NAME + " where vitalId="+vitalId+";");
		response.sendRedirect("manageVitals.jsp");
	}

}
