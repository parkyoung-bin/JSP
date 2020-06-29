
package com.ajax.controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("*.ajax")
public class AjaxController extends HttpServlet {
   private static final long serialVersionUID = 1L;

  
    public AjaxController() {
        // TODO Auto-generated constructor stub
    }

   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      doAction(request, response);
   }

   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      doAction(request, response);
   }

protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
   //한글처리
      
      request.setCharacterEncoding("utf-8");
   
   
      String uri = request.getRequestURI();
      String conpath = request.getContextPath();
      
      String command = uri.substring(conpath.length());
      
      System.out.println(command);
      if(command.equals("/test.ajax")) {
         
         String id = request.getParameter("id");
         String pw = request.getParameter("pw");
         System.out.println(id);
         System.out.println(pw);
         
         System.out.println("실행됨....");
         
         //요청들어온 곳으로 문자열의 형태로 반환
         response.setCharacterEncoding("utf-8");
         response.setContentType("text/html");
         PrintWriter out = response.getWriter();
         out.println("반환된 데이터");
      }else if(command.equals("/list.ajax")) {
    	  String num = request.getParameter("num");
    	  System.out.println("전달된 번호:"+num);
    	  
    	  //1. JSON-simple 라이브러리 추가
    	  //JSONObject - 자바의 맵을 제이슨 형식으로 변환
    	  
//    	  JSONObject obj = new JSONObject();
//    	  obj.put("name","홍길동");
//    	  obj.put("age","30");
//    	  
//    	  System.out.println(obj.toJSONString());
//    	  response.setCharacterEncoding("utf-8");
//    	  response.setContentType("application/json");
//    	  PrintWriter out = response.getWriter();
//    	  out.println(obj.toString());
    	  
    	  
    	  //JSONArray - 자바의 list를 자바스크립트의 배열 형식으로 변환
    	  JSONArray list=  new JSONArray();
    	  
    	  for(int i =1;i<=10;i++) {
    		JSONObject obj = new JSONObject();
    		obj.put("writer","글쓴이 :"+i);
    		obj.put("title","제목 :"+i);
    		obj.put("content","내용 :"+i);
    		
    		list.add(obj); //리스트에 JSON를 넣는다.
    		
    	  }
    	  response.setCharacterEncoding("utf-8");
    	  response.setContentType("application/json");
    	  PrintWriter out = response.getWriter();
    	  out.println(list.toString());//응답
    	  
      }
   }
}