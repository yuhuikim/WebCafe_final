package com.pr.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pr.project.model.Reply;
import com.pr.project.service.ReplyService;

@Controller
public class ReplyController {
	@Autowired
	private ReplyService rs;
	
	@RequestMapping("replyForm.html")
	public String replyForm(int r_b_num, int r_ref, Model model) {
		model.addAttribute("r_b_num", r_b_num);
		model.addAttribute("r_ref", r_ref);
		return "/reply/replyForm";
	}
	
	@RequestMapping("insertReply.html")
	public String insert(Reply reply, Model model, HttpServletRequest request) {
		reply.setR_ip(request.getLocalAddr());	
		
		int rnum = rs.maxNum()+1;
		int rref = reply.getR_ref();
		if(reply.getR_num()==reply.getR_ref()) { //참조값 없을 때
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
		/* return "redirect:replyList.html?r_b_num="+reply.getR_b_num(); */
		return "redirect:board/boardView.html?b_num="+reply.getR_b_num()+"&pageNum=1";
	}
	
	@RequestMapping("udpateReply.html")
	public String update(String r_content, int r_b_num, int r_num, Model model) {
		Reply reply = new Reply();
		reply.setR_num(r_num);
		reply.setR_content(r_content);
		rs.update(reply);
		/* return "redirect:replyList.html?r_b_num="+r_b_num; */
		return "redirect:board/boardView.html?b_num="+r_b_num+"&pageNum=1";
	}
	
	@RequestMapping("deleteReply.html")
	public String delete(int r_b_num, int r_num, Model model) {
		rs.delete(r_num);
		/* return "redirect:replyList.html?r_b_num="+r_b_num; */
		return "redirect:board/boardView.html?b_num="+r_b_num+"&pageNum=1";
	}

	@RequestMapping("replyList")
	public String list(int r_b_num, Model model) {

		List<Reply> replyList = rs.list(r_b_num);
		model.addAttribute("r_b_num", r_b_num);
		model.addAttribute("replyList", replyList);
		return "/reply/replyView";
	}

}
