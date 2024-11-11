package com.ict.mytravellist.ADMIN.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mytravellist.ADMIN.common.AdminFAQ_Paging;
import com.ict.mytravellist.ADMIN.common.AdminMain_Paging;
import com.ict.mytravellist.ADMIN.common.AdminNotice_Paging;
import com.ict.mytravellist.ADMIN.common.AdminQNA_Paging;
import com.ict.mytravellist.ADMIN.common.ManageUserPaging;
import com.ict.mytravellist.ADMIN.service.AdminService;
import com.ict.mytravellist.ADMIN.vo.AdminVO;
import com.ict.mytravellist.vo.FAQVO;
import com.ict.mytravellist.vo.NoticeVO;
import com.ict.mytravellist.vo.QNAVO;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.UserVO;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AdminNotice_Paging notice_paging;
	
	@Autowired
	private AdminFAQ_Paging faq_paging;
	
	@Autowired
	private AdminQNA_Paging qna_paging;
	
	@Autowired
	private AdminMain_Paging main_Paging;
	
	@Autowired
	private ManageUserPaging mupj;
	
	@GetMapping("/administrator")
	public ModelAndView goAdminLoginPage() {
		return new ModelAndView("ADMIN/loginPage");
	}
	
	public Map<String, Integer> getPaging(String nowPage) {
		if (nowPage == null || nowPage.equals("undefined") || Integer.parseInt(nowPage) < 1) {
			mupj.setNowPage(1);
		}else {
			mupj.setNowPage(Integer.parseInt(nowPage));
		}
		mupj.setOffset(mupj.getNumPerPage() * (mupj.getNowPage() - 1));
		mupj.setStartBlock((int)((mupj.getNowPage() - 1)) / mupj.getBlockPerPage() * mupj.getBlockPerPage() + 1);
		mupj.setEndBlock(mupj.getStartBlock() + mupj.getBlockPerPage() - 1);
		
		if (mupj.getEndBlock() > mupj.getTotalPage()) {
			mupj.setEndBlock(mupj.getTotalPage());
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("offset", mupj.getOffset());
		map.put("limit", mupj.getNumPerPage());    
		return map;
	}
	
	@GetMapping("/admin_members")
	public ModelAndView goAdminMembers(
			HttpServletRequest request,
			@ModelAttribute("filter_lev") String filter_lev) {
		ModelAndView mav = new ModelAndView("ADMIN/members");
		try {
			int count = adminService.countTotalData();
			mupj.setTotalCount(count);
			int numPerPage = mupj.getNumPerPage();
			
			if (count <= numPerPage) {
				mupj.setTotalPage(1);
			}else {
				int totalPage = (count / numPerPage);
				if ((count % numPerPage) == 0) {
					mupj.setTotalPage(totalPage);
				}else {
					mupj.setTotalPage(totalPage + 1);
				}
			}
			String nowPage = request.getParameter("nowPage");
			Map<String, Integer> map = getPaging(nowPage);
			int offset = map.get("offset");
			int limit = map.get("limit");
			
			List<UserVO> list = adminService.getUserList(offset, limit);
			
			mav.addObject("list", list);
			mav.addObject("pg", mupj);
			String isOK = request.getParameter("isOK");
			mav.addObject("isOK", isOK);
			mav.addObject("filter_lev", filter_lev);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@PostMapping("/admin_manage_user")
	public ModelAndView manageUser(
			UserVO uvo) {
		ModelAndView mav = new ModelAndView();
		try {
			int result = adminService.getManageUser(uvo);
			if (result > 0) {
				mav.setViewName("redirect:/admin_members?isOK=yes");
			}else {
				mav.setViewName("redirect:/admin_members?isOK=no");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav ;
	}
	
	@PostMapping("/admin_filter_user")
	public ModelAndView filterUser(String f_keyword, String filter_lev, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			int count = adminService.countFilteredData(f_keyword, filter_lev);
			
			mupj.setTotalCount(count);
			int numPerPage = mupj.getNumPerPage();
			
			if (count <= numPerPage) {
				mupj.setTotalPage(1);
			}else {
				int totalPage = (count / numPerPage);
				if ((count % numPerPage) == 0) {
					mupj.setTotalPage(totalPage);
				}else {
					mupj.setTotalPage(totalPage + 1);
				}
			}
			String nowPage = request.getParameter("nowPage");
			Map<String, Integer> map = getPaging(nowPage);
			int offset = map.get("offset");
			int limit = map.get("limit");
			List<UserVO> list = adminService.getFilteredList(f_keyword, filter_lev, offset, limit);
			if (list != null) {
				mav.addObject("list", list);
				mav.addObject("pg", mupj);
				mav.addObject("filter_lev", filter_lev);
				mav.setViewName("ADMIN/members");
			}else {
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav; 
	}
	
	@GetMapping("/admin_notice")
	public ModelAndView goAdminNotice(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("ADMIN/notice");
		try {
			int count = adminService.getNoticeTotalCount();
			notice_paging.setTotalRecord(count);
			if(notice_paging.getTotalRecord() <= notice_paging.getNumPerPage()) {
				notice_paging.setTotalPage(1);
			}else {
				int totalPage = notice_paging.getTotalRecord() / notice_paging.getNumPerPage();
				if(notice_paging.getTotalRecord() % notice_paging.getNumPerPage() != 0 ) {
					totalPage += 1;
				}
				notice_paging.setTotalPage(totalPage);
			}
			
			// 3. 현재 페이지
			String notice_cPage = request.getParameter("notice_cPage");
			if(notice_cPage == null || notice_cPage.equals("")) {
				notice_paging.setNowPage(1);
			} else {
				notice_paging.setNowPage(Integer.parseInt(notice_cPage));
			}
			
			// 4. cPage 기준 시작 & 끝
			int limit = notice_paging.getNumPerPage();
			int offset = limit * (notice_paging.getNowPage() - 1);
			notice_paging.setOffset(offset);
			notice_paging.setBeginBlock(
					(int)(((notice_paging.getNowPage()-1) / notice_paging.getPagePerBlock()) *notice_paging.getPagePerBlock() +1)
					);
			notice_paging.setEndBlock(
					notice_paging.getBeginBlock() + notice_paging.getPagePerBlock() -1
					);
			
			if(notice_paging.getEndBlock() > notice_paging.getTotalPage()) {
				notice_paging.setEndBlock(notice_paging.getTotalPage());
			}
			
			List<NoticeVO> notice_list = adminService.getNoticeList(offset, limit);
			mv.addObject("notice_list", notice_list);
			mv.addObject("notice_paging", notice_paging);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return mv;
	}
	
	// 공지사항 작성화면으로 가기
	@GetMapping("/admin_notice_create")
	public ModelAndView goAdminNoticeCreate(@ModelAttribute("notice_cPage") String notice_cPage) {
		return new ModelAndView("ADMIN/notice_create");
	}
	
	// 공지사항 작성하기 화면
	@PostMapping("/admin_notice_create_ok")
	public ModelAndView goAdminNoticeCreateOK(
			NoticeVO noticevo, HttpServletRequest request,
			@ModelAttribute("notice_cPage") String notice_cPage) {
		try {
			ModelAndView mv = new ModelAndView("redirect:/admin_notice");
			
			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			MultipartFile file = noticevo.getFileName();
			
			if (file == null || file.isEmpty()) {
				noticevo.setNoticeFile("");
			} else {
				UUID uuid = UUID.randomUUID();
				String noticeFile = uuid.toString()+"_"+file.getOriginalFilename();
				noticevo.setNoticeFile(noticeFile);
				file.transferTo(new File(path, noticeFile));
			}
			
			int result = adminService.getNoticeInsert(noticevo);
			if (result > 0) {
				return mv;
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@PostMapping("/admin_notice_update")
	public ModelAndView updateAdminNotice(
			NoticeVO noticevo, HttpServletRequest request,
			@RequestParam("old_f_name") String old_f_name,
			@ModelAttribute("notice_cPage") String notice_cPage) {
		ModelAndView mv = new ModelAndView("redirect:/admin_notice");
		try {
			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			MultipartFile file = noticevo.getFileName();
			if(file.isEmpty()) {
				noticevo.setNoticeFile(old_f_name);
			}else {
				UUID uuid = UUID.randomUUID();
				String f_name = uuid.toString() +"_"+file.getOriginalFilename();
				noticevo.setNoticeFile(f_name);
				
				file.transferTo(new File(path, f_name));
			}
			
			int result = adminService.getNoticeUpdate(noticevo);
			if(result > 0) {
				mv.setViewName("redirect:/admin_notice");
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return mv;
	}
	
	@GetMapping("/admin_faq")
	public ModelAndView goAdminFAQ(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("ADMIN/faq");
		try {
			int count = adminService.getFAQTotalCount();
			faq_paging.setTotalRecord(count);
			
			// 2. 전체 페이지 수 계산하기
			if(faq_paging.getTotalRecord() <= faq_paging.getNumPerPage()) {
				faq_paging.setTotalPage(1);
			}else {
				int totalPage = faq_paging.getTotalRecord() / faq_paging.getNumPerPage();
				if(faq_paging.getTotalRecord() % faq_paging.getNumPerPage() != 0 ) {
					totalPage += 1;
				}
				faq_paging.setTotalPage(totalPage);
			}
			
			// 3. 현재 페이지
			String faq_cPage = request.getParameter("faq_cPage");
			if(faq_cPage == null || faq_cPage.equals("")) {
				faq_paging.setNowPage(1);
			} else {
				faq_paging.setNowPage(Integer.parseInt(faq_cPage));
			}
			
			// 4. cPage 기준 시작 & 끝
			int limit = faq_paging.getNumPerPage();
			int offset = limit * (faq_paging.getNowPage() - 1);
			faq_paging.setOffset(offset);
			faq_paging.setBeginBlock(
					(int)(((faq_paging.getNowPage()-1) / faq_paging.getPagePerBlock()) *faq_paging.getPagePerBlock() +1)
					);
			faq_paging.setEndBlock(
					faq_paging.getBeginBlock() + faq_paging.getPagePerBlock() -1
					);
			
			if(faq_paging.getEndBlock() > faq_paging.getTotalPage()) {
				faq_paging.setEndBlock(faq_paging.getTotalPage());
			}
			
			List<FAQVO> faq_list = adminService.getFAQList(offset, limit);
			mv.addObject("faq_list", faq_list);
			mv.addObject("faq_paging", faq_paging);
		
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return mv;
	}
	
	@GetMapping("/admin_faq_create")
	public ModelAndView goAdminFAQCreate(
			@ModelAttribute("faq_cPage") String faq_cPage) {
		return new ModelAndView("ADMIN/faq_create");
	}
	
	@PostMapping("/admin_faq_create_ok")
	public ModelAndView goAdminFAQCreateOK(
			FAQVO faqvo,
			@ModelAttribute("faq_cPage") String faq_cPage) {
		ModelAndView mv = new ModelAndView("redirect:/admin_faq");
		try {
			int result = adminService.getFAQInsert(faqvo);
			if(result > 0) {
				return mv;
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	@PostMapping("/admin_faq_update")
	public ModelAndView goAdminFAQUpdate(
			FAQVO faqvo,
			@ModelAttribute("faq_cPage") String faq_cPage
			) {
		ModelAndView mv = new ModelAndView("redirect:/admin_faq");
		try {
			int result = adminService.getFAQUpdate(faqvo);
			if(result > 0) {
				return mv;
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("/admin_qa")
	public ModelAndView goAdminQA(
			HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("ADMIN/qa");
		try {
			int count = adminService.getQNATotalCount();
			qna_paging.setTotalRecord(count);
			
			// 2. 전체 페이지 수 계산하기
			if(qna_paging.getTotalRecord() <= qna_paging.getNumPerPage()) {
				qna_paging.setTotalPage(1);
			}else {
				int totalPage = qna_paging.getTotalRecord() / qna_paging.getNumPerPage();
				if(qna_paging.getTotalRecord() % qna_paging.getNumPerPage() != 0 ) {
					totalPage += 1;
				}
				qna_paging.setTotalPage(totalPage);
			}
			
			// 3. 현재 페이지
			String qna_cPage = request.getParameter("qna_cPage");
			if(qna_cPage == null || qna_cPage.equals("")) {
				qna_paging.setNowPage(1);
			} else {
				qna_paging.setNowPage(Integer.parseInt(qna_cPage));
			}
			
			// 4. cPage 기준 시작 & 끝
			int limit = qna_paging.getNumPerPage();
			int offset = limit * (qna_paging.getNowPage() - 1);
			qna_paging.setOffset(offset);
			qna_paging.setBeginBlock(
					(int)(((qna_paging.getNowPage()-1) / qna_paging.getPagePerBlock()) *qna_paging.getPagePerBlock() +1)
					);
			qna_paging.setEndBlock(
					qna_paging.getBeginBlock() + qna_paging.getPagePerBlock() -1
					);
			
			if(qna_paging.getEndBlock() > qna_paging.getTotalPage()) {
				qna_paging.setEndBlock(qna_paging.getTotalPage());
			}
			
			List<QNAVO> qna_list = adminService.getQNAList(offset, limit);
			mv.addObject("qna_list", qna_list);
			mv.addObject("qna_paging", qna_paging);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
				
		return mv;
	}
	
	@GetMapping("/admin_qa_question")
	public ModelAndView goAdminQAQuestion(
			@ModelAttribute("qnaIdx") String qnaIdx,
			@ModelAttribute("qna_cPage") String qna_cPage) {
		ModelAndView mv = new ModelAndView("ADMIN/qa_question");
		try {
			QNAVO qnavo = adminService.getQNAOneList(qnaIdx);
			mv.addObject("qnavo", qnavo);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return mv;
	}
	
	@PostMapping("/admin_qa_answer")
	public ModelAndView goAdminQAAnswer(
			QNAVO qnavo,
			@ModelAttribute("qna_cPage") String qna_cPage) {
		ModelAndView mv = new ModelAndView("redirect:/admin_qa");
		try {
			int result = adminService.getQNAAnswered(qnavo);
			if(result > 0) {
				return mv;
			}else {
				return null;
		}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("/admin_main")
	public ModelAndView goAdminMain(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("ADMIN/main");
		try {
			int count = adminService.getMainTotalCount();
			main_Paging.setTotalRecord(count);
			
			if(main_Paging.getTotalRecord() <= main_Paging.getNumPerPage()) {
				main_Paging.setTotalPage(1);
			}else {
				int totalPage = main_Paging.getTotalRecord() / main_Paging.getNumPerPage();
				if(main_Paging.getTotalRecord() % main_Paging.getNumPerPage() != 0 ) {
					totalPage += 1;
				}
				main_Paging.setTotalPage(totalPage);
			}
			
			String main_cPage = request.getParameter("main_cPage");
			if(main_cPage == null || main_cPage.equals("")) {
				main_Paging.setNowPage(1);
			} else {
				main_Paging.setNowPage(Integer.parseInt(main_cPage));
			}
			
			int limit = main_Paging.getNumPerPage();
			int offset = limit * (main_Paging.getNowPage() - 1);
			main_Paging.setOffset(offset);
			main_Paging.setBeginBlock(
					(int)(((main_Paging.getNowPage()-1) / main_Paging.getPagePerBlock()) *main_Paging.getPagePerBlock() +1)
					);
			main_Paging.setEndBlock(
					main_Paging.getBeginBlock() + main_Paging.getPagePerBlock() -1
					);
			
			if(main_Paging.getEndBlock() > main_Paging.getTotalPage()) {
				main_Paging.setEndBlock(main_Paging.getTotalPage());
			}
			
			List<TravelDBVO> main_list = adminService.getMainList(offset, limit);
			mv.addObject("main_list", main_list);
			mv.addObject("main_Paging", main_Paging);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return mv;
	}
	
	@GetMapping("/admin_main_update")
	public ModelAndView goAdminMainUpdate(
			@RequestParam("travelIdx") String travelIdx ,
			@ModelAttribute("main_cPage") String main_cPage) {
		ModelAndView mv = new ModelAndView("ADMIN/main_update");
		try {
			TravelDBVO tdvo = adminService.getMainOneList(travelIdx);
			mv.addObject("tdvo", tdvo);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return mv;
	}
	
	@PostMapping("/admin_main_update_OK")
	public ModelAndView adminMainUpdateOK(
			TravelDBVO tdvo,
			@ModelAttribute("main_cPage") String main_cPage) {
		ModelAndView mv = new ModelAndView("redirect:/admin_main");
		try {
			int result = adminService.getMainUpdate(tdvo);
			if(result > 0) {
				return mv;
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("/admin_main_create")
	public ModelAndView goAdminMainCreate(@ModelAttribute("main_cPage") String main_cPage) {
		return new ModelAndView("ADMIN/main_create");
	}
	
	@PostMapping("/admin_main_create_OK")
	public ModelAndView adminMainCreateOK(
			TravelDBVO tdvo,
			@ModelAttribute("main_cPage") String main_cPage) {
		ModelAndView mv = new ModelAndView("redirect:/admin_main");
		try {
			int result = adminService.getMainInsert(tdvo);
			if(result > 0) {
				return mv;
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping("/admin_index")
	public ModelAndView goAdminIndex(AdminVO adminvo, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		try {
			String input_id = adminvo.getAdminID();
			String input_pw = adminvo.getAdminPW();
			
			AdminVO true_admin = adminService.getAdminInfo(input_id);
			
			String loginChk = (String) session.getAttribute("loginChk");
			
			int newUserConnReg = adminService.getUserConnReg();
			mv.addObject("newUserConnReg", newUserConnReg);
			
			int newTourTalk = adminService.getNewTourTalk();
			mv.addObject("newTourTalk", newTourTalk);
			
			int newUserReg = adminService.getNewUserReg();
			mv.addObject("newUserReg", newUserReg);
			
			if(loginChk == null) {
				if(true_admin == null || !true_admin.getAdminPW().equals(input_pw)) {
					mv.addObject("errorMsg", "올바르지 못한 로그인 정보입니다.");
					mv.setViewName("ADMIN/loginPage");
					return mv;
				}else {
					session.setAttribute("loginChk", "ok");
					mv.setViewName("ADMIN/index");
					return mv;
				}
			}else {
				session.setAttribute("loginChk", "ok");
				mv.setViewName("ADMIN/index");
				return mv;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	
}
