package com.pr.project.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pr.project.model.LoginIp;
import com.pr.project.model.User;
import com.pr.project.service.LoginIpService;
import com.pr.project.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService us;
	@Autowired
	private LoginIpService ls;

	@RequestMapping("user/joinForm")
	public String joinForm() {
		return "user/joinForm";
	}

	@RequestMapping(value = "user/idChk", produces = "text/html;charset=utf-8") // text를 html로 바꿔주고 한글은 utf-8로 받기
	@ResponseBody // jsp 통하지 말고 바로 문자로 전달
	public String idChk(String user_id, Model model) { // user_id가지고 데이터베이스 이동하기
		String msg = "";
		User user = us.select(user_id);
		if (user == null)
			msg = "사용 가능한 ID 입니다.";
		else
			msg = "사용 중인 ID 입니다.";
		//model.addAttribute("message", msg);
		return msg;
	}

	@RequestMapping(value = "user/nickChk", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String nickChk(String user_nickname, Model model) { // user_nickname가지고 데이터베이스 이동하기
		String msg1 = "";
		User user = us.select1(user_nickname);
		if (user == null)
			msg1 = "사용 가능한 닉네임 입니다.";
		else
			msg1 = "사용 중인 닉네임 입니다.";
		model.addAttribute("message1", msg1);
		return msg1;
	}

	@RequestMapping("user/join")
	public String join(User user, Model model, HttpServletRequest request, HttpSession session) throws IOException {
		int result = 0;

		User ui = us.select(user.getUser_id());
		User un = us.select1(user.getUser_nickname());
		if (ui == null && un == null) { // 둘 다 중복 아닌 경우
			user.setUser_ip(request.getLocalAddr()); // ip setting
			result = us.insert(user);
		} else if (ui != null && un != null) { // 중복된 아이디 및 닉네임
			result = -3;
		} else if (ui != null && un == null) { // 중복된 아이디
			result = -1;
		} else if (ui == null && un != null) { // 중복된 닉네임
			result = -2;
		}
		model.addAttribute("result", result);
		return "user/join";
	}

	@RequestMapping("user/loginForm")
	public String loginForm() {
		return "user/loginForm";
	}

	@RequestMapping("user/login")
	public String login(User user, LoginIp loginip, Model model, HttpServletRequest request, HttpSession session) {
		int result = 0;
		User ur = us.select(user.getUser_id());

		if (ur == null || ur.getUser_del().equals("y"))
			result = -1; // 없거나 탈퇴한 회원이다.
		else if (user.getUser_pwd().equals(ur.getUser_pwd())) {
			result = 1; // 로그인 성공
			loginip.setI_id(user.getUser_id());
			loginip.setI_ip(request.getLocalAddr()); // ip setting
			ls.insert_ip(loginip);
			session.setAttribute("user_id", user.getUser_id()); // 로그인 상태 유지
		}
		model.addAttribute("result", result);
		return "user/login";
	}

	/*
	 * @RequestMapping("user/main") public String main(Model model,
	 * HttpServletRequest request, HttpSession session) {
	 * 
	 * return "user/main"; }
	 */


//	@RequestMapping("/main")
//	public String main(Model model, HttpSession session) {
//		String id = (String) session.getAttribute("id");
//		User user = null;
//		if (id != null && !id.equals("")) {
//			user = us.select(id);
//		}
//		model.addAttribute("member", user);
//		return "main";
//	}
//
//	@RequestMapping("view")
//	public String view(Model model, HttpSession session) {
//		String id = (String) session.getAttribute("id");
//		User user = us.select(id);
//		model.addAttribute("member", user);
//		return "view";
//	}

//	@RequestMapping("view2")
//	public String view2(Model model, HttpSession session) {
//		String id = (String) session.getAttribute("id");
//		User member = us.select(id);
//		List<MemberPhoto> list = us.listPhoto(id);
//		model.addAttribute("member", member);
//		model.addAttribute("list", list);
//		return "view2";
//	}

//	@RequestMapping("/updateForm")
//	public String updateForm(Model model, HttpSession session) {
//		String id = (String) session.getAttribute("id");
//		User user = us.select(id);
//		model.addAttribute("member", user);
//		return "updateForm";
//	}

//	@RequestMapping("update")
//	public String update(User user, Model model, HttpSession session) throws IOException {
//		String fileName = user.getFile().getOriginalFilename();
//		// 그림파일을 수정하지 않으면 null 또는 ""이 넘어온다
//		if (fileName != null && !fileName.equals("")) {
//			// 그림파일을 수정했을 경우에만 수행
//			user.setFileName(fileName);
//			String real = session.getServletContext().getRealPath("/upload");
//			FileOutputStream fos = new FileOutputStream(new File(real + "/" + fileName));
//			fos.write(user.getFile().getBytes());
//			fos.close();
//		}
//		int result = us.update(user);
//		model.addAttribute("result", result);
//		return "update";
//	}
//
//	@RequestMapping("delete")
//	public String delete(Model model, HttpSession session) {
//		String id = (String) session.getAttribute("id");
//		int result = us.delete(id);
//		if (result > 0) {
//			session.invalidate(); // session 삭제
//		}
//		model.addAttribute("result", result);
//		return "delete";
//	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "logout";
	}
}
