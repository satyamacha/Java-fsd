package com.tech.controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.dao.DB;
import com.tech.models.AdminModel;

/**
 * Servlet implementation class AdminLoginController
 */
@WebServlet({ "/AdminLoginController", "/admin-login-controller" })
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminLoginController() {
        // TODO Auto-generated constructor stub
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	if(req.getParameter("mode").equals("logout")) {
    		req.getSession().removeAttribute("admin");
    		resp.sendRedirect("index.html");
    		return;
    	}
    }

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try	{
			DB db = DB.getDb();
			AdminModel admin = new AdminModel();
			admin.email = req.getParameter("email");
			admin.password = req.getParameter("password");
			
			ResultSet result = db.executeQuery(admin.toAdminLoginSql());
			if(result.next()) {
				System.out.println("Login Successful");
				HttpSession session = req.getSession();
				session.setAttribute("admin", admin.getAdminModel(result));
				
				resp.sendRedirect("adminHome.jsp");
			} else {
				Map<String, String> message = new HashMap<String, String>();
				message.put("status", "error");
				message.put("message", "User Not Found Corresponding To this email id or invalid credentials");
				
				req.setAttribute("message", message);
				req.getRequestDispatcher("/adminLogin.jsp").include(req, resp);;
			}
			
		} catch (Exception ex) {
			System.err.println(ex);
		}
	}

}
