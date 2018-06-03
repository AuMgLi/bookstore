package com.bookstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.service.LoginService;

/**
 * ��½������
 * @author ME495
 *
 */
@Controller
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	/**
	 * �û���½����֤�û��������룬������json��ʽ�����ַ�������֤ͨ���򴴽�session
	 * @param userName
	 * @param password
	 * @return
	 * ��֤ͨ��ʱ����
	 */
	@RequestMapping("/user_login")
	@ResponseBody
	public String userLogin(@RequestParam("user_name") String userName, 
			@RequestParam("password") String password) {
		if (loginService.checkUser(userName, password)) {
			return "ok";
		} else {
			return "no";
		}
	}
	
}
