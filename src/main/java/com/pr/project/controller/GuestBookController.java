package com.pr.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pr.project.model.Reply;
import com.pr.project.model.User;
import com.pr.project.service.ReplyService;
import com.pr.project.service.UserService;

@Controller
public class GuestBookController {
	@Autowired
	private ReplyService rs;
	@Autowired
	private UserService us;

	@RequestMapping("guestBookForm.html")
	public String replyForm(int r_b_num, int r_ref, Model model) {
		model.addAttribute("r_b_num", r_b_num);
		model.addAttribute("r_ref", r_ref);
		return "/board/guestBookForm";
	}

	@RequestMapping("guestBookReplyForm.html")
	public String gbReplyForm(int r_num, int r_ref, Model model) {
		model.addAttribute("r_num", r_num);
		model.addAttribute("r_ref", r_ref);
		return "/board/guestBookReplyForm";
	}

	@RequestMapping("guestBookRereplyForm.html")
	public String gbRereplyForm(int r_num, int r_ref, Model model) {
		model.addAttribute("r_num", r_num);
		model.addAttribute("r_ref", r_ref);
		return "/board/guestBookRereplyForm";
	}

	
	 @RequestMapping("insertGuestBook.html") 
	 public String insert(Reply reply, Model model, HttpServletRequest request) {
		 reply.setR_ip(request.getLocalAddr());
		 
		 int rnum = rs.maxNum()+1; 
		 int rref = reply.getR_ref();

		 if(reply.getR_num()==rref) { //참조값 없을 때
			 reply.setR_num(rnum);
			 reply.setR_ref(rnum);
			 reply.setR_origin(rnum); 
			 reply.setR_level(0);
			 reply.setR_step(rs.selectMaxStep(reply.getR_b_num())+1); 
		 
		 } else { // 참조값 있을 때 aka 대댓글임 
			 Reply refReply = rs.getReply(rref); 
			 reply.setR_num(rnum);
			 reply.setR_b_num(refReply.getR_b_num());
			 reply.setR_origin(refReply.getR_origin());
			 reply.setR_level(refReply.getR_level()+1); 
			 int step = rs.selectStep(rref);
			 reply.setR_step(step+1); 
			 rs.updateStep(reply); 
			 } 
		 
		 rs.insert(reply);
		 model.addAttribute("r_b_num", reply.getR_b_num()); 
		 return "redirect:guestBookView.html?r_b_num="+reply.getR_b_num(); 
	 }
	 

	@RequestMapping("requestLevelUp.html")
	public String requestLevelUp(Reply reply, Model model, HttpServletRequest request) {
		reply.setR_ip(request.getLocalAddr());

		int rnum = rs.maxNum() + 1;
		reply.setR_num(rnum);
		reply.setR_ref(rnum);
		reply.setR_origin(rnum);
		reply.setR_level(0);
		reply.setR_step(rs.selectMaxStep(reply.getR_b_num()) + 1);

		User user = us.select(reply.getR_id());
		int boardWrite = us.selectB(user.getUser_id());
		int replyWrite = us.selectR(user.getUser_id());
		System.out.println("boardWrite = " + boardWrite);
		System.out.println("replyWrite = " + replyWrite);
		int level = user.getUser_level();
		System.out.println("기존 유저 레벨 : " + user.getUser_level());

		if (boardWrite >= 30 && replyWrite >= 50) {
			user.setUser_level(5);
		} else if (boardWrite >= 20 && replyWrite >= 30) {
			user.setUser_level(4);
		} else if (boardWrite >= 10 && replyWrite >= 20) {
			user.setUser_level(3);
		} else if (boardWrite >= 3 && replyWrite >= 5) {
			user.setUser_level(2);
		} else
			user.setUser_level(1);

		if (level >= user.getUser_level())
			user.setUser_level(level);
		else
			us.updateL(user);

		rs.insert(reply);
		model.addAttribute("r_b_num", reply.getR_b_num());
		model.addAttribute("user_level", user.getUser_level());

		System.out.println("최종 유저 레벨 : " + user.getUser_level());
		return "redirect:guestBookView.html?r_b_num=" + reply.getR_b_num();
	}

	@RequestMapping("guestBookUpdateForm.html")
	public String gbUpdateForm(int r_num, Model model) {
		Reply reply = rs.getReply(r_num);
		model.addAttribute("reply", reply);
		return "board/guestBookUpdateForm";
	}

	@RequestMapping("udpateGuestBook.html")
	public String update(Reply reply, Model model) {
		rs.update(reply);
		return "redirect:guestBookView.html?r_b_num=" + reply.getR_b_num();
	}

	@RequestMapping("deleteGuestBook.html")
	public String delete(int r_b_num, int r_num, Model model) {
		rs.delete(r_num);
		return "redirect:guestBookView.html?r_b_num=" + r_b_num;
	}

	@RequestMapping("gbReplyUpdate.html")
	public String update(int r_num, String r_content, Model model) {
		Reply reply = rs.getReply(r_num);
		reply.setR_content(r_content);
		rs.update(reply);
		model.addAttribute("reply", reply);
		return "/board/guestBookView";
	}

	@RequestMapping("getReply.html")
	public String getReply(int r_num, Model model) {
		System.out.println("getReply.html 중 : 인자로 받은 r_num = " + r_num);
		Reply reply = rs.getReply(r_num);

		System.out.println("getReply.html 중 : 인자로 받은 r_num = " + r_num);
		System.out.println("getReply.html 중 : reply.getR_num() = " + reply.getR_num());
		System.out.println("getReply.html 중 : reply.getR_origin() = " + reply.getR_origin());
		model.addAttribute("r_origin", reply.getR_origin());
		return "/board/reply";
	}

	@RequestMapping("guestBookView.html")
	public String view(int r_b_num, Model model) {
		model.addAttribute("r_b_num", r_b_num);
		return "/board/guestBookView";
	}

	@RequestMapping("guestBookList.html")
	public String list(int r_b_num, int startNum, Model model) {

		int wholeNum = rs.count(r_b_num);
		int rowPerPage = 10;
		int endNum = startNum + rowPerPage - 1;

		Reply reply = new Reply();
		reply.setR_b_num(r_b_num);
		reply.setStartNum(startNum);
		if (wholeNum < endNum)
			endNum = wholeNum;
		reply.setEndNum(endNum);
		List<Reply> replyList = rs.list2(reply);

		model.addAttribute("r_b_num", r_b_num);
		model.addAttribute("startNum", startNum);
		model.addAttribute("endNum", endNum);
		model.addAttribute("wholeNum", wholeNum);
		model.addAttribute("replyList", replyList);

		return "/board/guestBookList";
	}

	@RequestMapping("guestBookReplyList")
	public String list(int r_num, Model model) {
		List<Reply> gbReplyList = rs.list3(r_num);
		model.addAttribute("gbReplyList", gbReplyList);
		return "/board/guestBookReplyList";
	}

}
