package com.ajax2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ajax2.users.service.UserJoinServiecImpl;
import com.ajax2.users.service.UserService;
import com.ajax2.users.service.LoginServiceImpl;


@WebServlet("*.user")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public UserController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI();
		String path = request.getContextPath();
		String command = uri.substring(path.length());
		
		System.out.println("uri : " + uri);
		System.out.println("path : " + path);
		System.out.println("command : " + command);
		
		UserService service = null;
		
		if(command.equals("/joinForm.user")) {
			response.sendRedirect("user_join.jsp");
		} else if(command.equals("/join.user")) {
			service = new UserJoinServiecImpl();
			int result = service.execute(request, response);
			if(result == 1) {
				System.out.println(result);
			} else if(result == 0) {
				System.out.println(result);
			}
		} else if(command.equals("/login.user")) {
			request.getRequestDispatcher("loginForm.user").forward(request, response);

		}else if(command.equals("/loginForm.user") ) {

			System.out.println("로그인성공");
			String id = request.getParameter("id");
			System.out.println(id);
			request.getSession().setAttribute("user_id", id);

			System.out.println("세션값 : " + request.getSession().getAttribute("user_id"));

			service = new LoginServiceImpl();
			int result = service.execute(request, response);
			if(result==0) {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();

				out.println("<script>");
				out.println("alert('아이디 비번 확인하세요')");
				out.println(" location.href='index.jsp'  ");
				out.println("</script>");

			} else {
				response.sendRedirect("map.user");
			}
		} else if (command.equals("/logout.user")) {
			if(request.getSession().getAttribute("user_id")==null) {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();

				out.println("alert('sgddfgdsfgdsfgsdfgsdfgsdgsf.')");
				out.println("<script>");
				out.println("if (!Kakao.Auth.getAccessToken()) {");
				out.println("alert('Not logged in.')");
				out.println("return");
				out.println("}");
				out.println("alert('logout ok\\naccess token -> ' + Kakao.Auth.getAccessToken())");
				out.println("})");
				out.println("</script>");
				response.sendRedirect("index.jsp");
			} else {
				System.out.println("일로와");
				request.getSession().invalidate();//세션삭제
				response.sendRedirect("index.jsp");
			}
		} else if(command.equals("/map.user")) {
			//response.sendRedirect("http://127.0.0.1:5501/09.ajax/script10.html");
			response.sendRedirect("script10.html");
		}
	}
	
	

}
