package com.ajax2.users.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ajax2.users.model.UserDAO;
import com.ajax2.users.model.UserVO;

public class UserJoinServiecImpl implements UserService{

	@Override
	public int execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		int result = 0;
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		
		UserDAO dao = UserDAO.getInstance();
		
		result = dao.checkId(id);
		System.out.println("dao.checkId(id) result : " + result);
		
		if( result == 1) { //이미존재하는 경우
			System.out.println("이미 존재하는 회원입니다");
		} else { //중복이 없는 경우
			
			//UserVO vo = new UserVO(id, pw, name, email, address, null);
			UserVO vo = new UserVO(id, pw, name,null);
			result = dao.insert(vo);
		}
		
		return result;
	}
	
}
