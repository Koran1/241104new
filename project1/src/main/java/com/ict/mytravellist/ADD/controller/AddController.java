package com.ict.mytravellist.ADD.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mytravellist.ADD.comm.FAQPaging;
import com.ict.mytravellist.ADD.comm.NoticePaging;
import com.ict.mytravellist.ADD.comm.NoticeSearchPaging;
import com.ict.mytravellist.ADD.comm.QNAPaging;
import com.ict.mytravellist.ADD.service.AddService;
import com.ict.mytravellist.vo.FAQVO;
import com.ict.mytravellist.vo.NoticeVO;
import com.ict.mytravellist.vo.QNAVO;


@Controller
public class AddController {
	
	@Autowired
	private AddService addService;
	
	@Autowired
	private FAQPaging paging;
	
	@Autowired
	private NoticePaging paging_notice;
	
	@Autowired
	private NoticeSearchPaging paging_nserach;
	
	@Autowired
	private QNAPaging paging_qna;

	// 공지사항 초기 화면
	@GetMapping("/add_notice")
	public ModelAndView addNotice(HttpServletRequest request) {
	    ModelAndView mv = new ModelAndView("ADD/ADD_notice");

	    // 1. 전체 게시물의 수를 구한다.
	    int count = addService.getNoticeTotalCount();
	    paging_notice.setTotalRecord(count);

	    // 2. 전체 페이지의 수를 계산한다.
	    if (paging_notice.getTotalRecord() <= paging_notice.getNumPerPage()) {
	        paging_notice.setTotalPage(1);
	    } else {
	        paging_notice.setTotalPage((int) Math.ceil((double) paging_notice.getTotalRecord() / paging_notice.getNumPerPage()));
	    }

	    // 3. 파라미터에서 넘어오는 cPage(보고 싶은 페이지번호)를 가져온다
	    String cPage = request.getParameter("cPage");

	    // cPage가 null이면 기본 1페이지를 설정
	    if (cPage == null) {
	        paging_notice.setNowPage(1);
	    } else {
	        paging_notice.setNowPage(Integer.parseInt(cPage));
	    }

	    // 4. offset 계산
	    paging_notice.setOffset(paging_notice.getNumPerPage() * (paging_notice.getNowPage() - 1));

	    // 시작 블록 및 끝 블록 계산
	    paging_notice.setBeginBlock(
	            (int) (((paging_notice.getNowPage() - 1) / paging_notice.getPagePerBlock()) * paging_notice.getPagePerBlock() + 1));
	    paging_notice.setEndBlock(paging_notice.getBeginBlock() + paging_notice.getPagePerBlock() - 1);

	    if (paging_notice.getEndBlock() > paging_notice.getTotalPage()) {
	        paging_notice.setEndBlock(paging_notice.getTotalPage());
	    }

	    // 상단 고정 공지사항 (최대 5개)
	    List<NoticeVO> notice_list = addService.getNoticeList();
	    // 페이징된 공지사항 목록
	    List<NoticeVO> notice_list2 = addService.getNoticeList2(paging_notice.getOffset(), paging_notice.getNumPerPage());

	    mv.addObject("notice_list", notice_list); // 상단 고정 공지사항
	    mv.addObject("notice_list2", notice_list2); // 페이징된 공지사항 목록
	    mv.addObject("pg", paging_notice); // pg 객체를 JSP에 전달

	    return mv;
	}

	// 검색 결과 화면
    @GetMapping("/add_notice_search")
    public ModelAndView addNoticeSearch(@RequestParam("notice_keyword") String notice_keyword) {
        ModelAndView mv = new ModelAndView("ADD/ADD_notice_search");

        List<NoticeVO> searchResults = addService.getNoticeSearch(notice_keyword);

        mv.addObject("searchResults", searchResults);
        mv.addObject("notice_keyword", notice_keyword);
        return mv;
    }
    
	// 공지사항 상세 화면
	@GetMapping("/add_notice_detail")
	public ModelAndView addNoticeDetail(@RequestParam("noticeIdx") String noticeIdx) {
		ModelAndView mv = new ModelAndView("ADD/ADD_notice_detail");

		// 전체 공지사항 목록을 가져옴
		List<NoticeVO> noticeList = addService.getNoticeAll();
		NoticeVO noticevo = addService.getNoticeDetail(noticeIdx);

		if (noticevo != null) {
			// 현재 noticeIdx의 위치 찾기
			int currentIdx = -1; // 현재 Idx에서 없을수도 있으니까 -1로 초기화 해주는 코드
			for (int i = 0; i < noticeList.size(); i++) { // 리스트의 전체 크기를 반환해주는 for문 돌리기
				if (noticeList.get(i).getNoticeIdx().equals(noticeIdx)) { // 리스트의 현재 i값의 Idx가 noticeIdx와 같을 때
					currentIdx = i; // currentIdx에 i를 저장
					break;
				}
			}

			// 이전글과 다음글 찾기
			// previous는 현재 Idx가 0보다 클 때 값 가져오고 currentIdx-1을 해서 저장
			NoticeVO previous= (currentIdx > 0) ? noticeList.get(currentIdx - 1) : null;
			// next는 현재 Idx가 리스트의 마지막 Idx보다 작을 때 값 가져오고 currentIdx+1을 해서 저장
			NoticeVO next = (currentIdx < noticeList.size() - 1) ? noticeList.get(currentIdx + 1) : null;

			mv.addObject("noticevo", noticevo);
			mv.addObject("previous", previous);
			mv.addObject("next", next);
			return mv;
		}
		 return null;
    }

	@GetMapping("/add_faq")
	public ModelAndView addFaq(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("ADD/ADD_FAQ");

		// 1. 전체 게시물의 수를 구한다.
		int count = addService.getFAQTotalCount();
		paging.setTotalRecord(count);

		// 2. 전체 페이지의 수를 구한다.
		// NumPerPage(6) 보다 작을 경우 1페이지
		if (paging.getTotalRecord() <= paging.getNumPerPage()) { // 전체 데이터의 수가 한 페이지당 데이터보다 작거나 같을 경우
			paging.setTotalPage(1);
		} else { // 클 경우
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage()); // (전체 데이터) / (한 페이지당 데이터)
			if (paging.getTotalRecord() % paging.getNumPerPage() != 0) { // 나누어 떨어지지 않으면
				paging.setTotalPage(paging.getTotalPage() + 1); // 나눠진 결과에 +1을 해서 총 페이지에 저장하자
			}
		}

		// 3. 파라미터에서 넘어오는 cPage(보고 싶은 페이지번호)를 구하자
		String cPage = request.getParameter("cPage");

		// 만약에 cPage가 null 이면 무조건 1 page 이다.
		if (cPage == null) {
			paging.setNowPage(1);
		} else {
			paging.setNowPage(Integer.parseInt(cPage));
		}

		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));

		// 시작블록 구하기
		paging.setBeginBlock(
				(int) (((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1));
		
		// 끝블록 구하기
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

		// 주의 사항
		// enbBlock(3,6,9...) 이렇게 설정되는데
		// 총 데이터가 20개면 총 페이지는 4개가 나온다.
		if (paging.getEndBlock() > paging.getTotalPage()) { // 끝블록이 총 페이지보다 크면
			paging.setEndBlock(paging.getTotalPage()); // 끝블록을 총 페이지에 맞게 조절
		}

		// DB 갔다가 오기
		List<FAQVO> faq_list = addService.getFAOList(paging.getOffset(), paging.getNumPerPage());

		mv.addObject("faq_list", faq_list);
		mv.addObject("paging", paging);
		return mv;
	}
	
	private String getSessionUserId(HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    return (String) session.getAttribute("userId");
	}

	
	// Q&A 초기 화면 테스트
	@GetMapping("/add_qna")
	public ModelAndView add_qna(HttpServletRequest request) {
		String userId = getSessionUserId(request);
		ModelAndView mv = new ModelAndView("ADD/ADD_QNA");

		// 1. 전체 게시물의 수를 구한다.
		int count = addService.getQNATotalCount();
		paging_qna.setTotalRecord(count);

		// 2. 전체 페이지의 수를 구한다.
		// NumPerPage(6) 보다 작을 경우 1페이지
		if (paging_qna.getTotalRecord() <= paging_qna.getNumPerPage()) { // 전체 데이터의 수가 한 페이지당 데이터보다 작거나 같을 경우
			paging_qna.setTotalPage(1);
		} else { // 클 경우
			paging_qna.setTotalPage(paging_qna.getTotalRecord() / paging_qna.getNumPerPage()); // (전체 데이터) / (한 페이지당 데이터)
			if (paging_qna.getTotalRecord() % paging_qna.getNumPerPage() != 0) { // 나누어 떨어지지 않으면
				paging_qna.setTotalPage(paging_qna.getTotalPage() + 1); // 나눠진 결과에 +1을 해서 총 페이지에 저장하자
			}
		}

		// 3. 파라미터에서 넘어오는 cPage(보고 싶은 페이지번호)를 구하자
		String cPage = request.getParameter("cPage");

		// 만약에 cPage가 null 이면 무조건 1 page 이다.
		if (cPage == null) {
			paging_qna.setNowPage(1);
		} else {
			paging_qna.setNowPage(Integer.parseInt(cPage));
		}

		paging_qna.setOffset(paging_qna.getNumPerPage() * (paging_qna.getNowPage() - 1));

		// 시작블록 구하기
		paging_qna.setBeginBlock(
				(int) (((paging_qna.getNowPage() - 1) / paging_qna.getPagePerBlock()) * paging_qna.getPagePerBlock() + 1));

		// 끝블록 구하기
		paging_qna.setEndBlock(paging_qna.getBeginBlock() + paging_qna.getPagePerBlock() - 1);

		// 주의 사항
		// enbBlock(3,6,9...) 이렇게 설정되는데
		// 총 데이터가 20개면 총 페이지는 4개가 나온다.
		if (paging_qna.getEndBlock() > paging_qna.getTotalPage()) { // 끝블록이 총 페이지보다 크면
			paging_qna.setEndBlock(paging_qna.getTotalPage()); // 끝블록을 총 페이지에 맞게 조절
		}
		
		// DB 갔다가 오기
		List<QNAVO> qna_list = addService.getQNAList(paging_qna.getOffset(), paging_qna.getNumPerPage(), userId);
		
		mv.addObject("qna_list", qna_list);
		mv.addObject("paging_qna", paging_qna);
		return mv;
	}
	
	
	// Q&A 질문하기 상세 화면 테스트-User
	@GetMapping("/add_qna_detail")
	public ModelAndView addQnaDetail(@RequestParam("qnaIdx") String qnaIdx, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("ADD/ADD_QNA_detail");
		QNAVO qnavo = addService.getQNADetail(qnaIdx);
		if (qnavo != null) {
			mv.addObject("qnavo", qnavo);
			return mv;
		}
		return null;
	}
	
	// Q&A 질문하기 화면
	@GetMapping("/add_qna_ask")
	public ModelAndView addQnaAsk(HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView("ADD/ADD_QNA_ask");
		return mv;
	}
	
	// Q&A 질문하기 저장
	@PostMapping("/add_qna_ask_ok")
	public ModelAndView addQnaAskOK(QNAVO qnavo, HttpServletRequest request) {
	    try {
	        String userId = getSessionUserId(request);
	        qnavo.setUserId(userId); // userId를 세션에서 가져와 설정
	        ModelAndView mv = new ModelAndView("redirect:/add_qna");
	        
			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			MultipartFile file = qnavo.getFileName();

			if (file == null || file.isEmpty()) {
				qnavo.setQnaFile("");
			} else {
				UUID uuid = UUID.randomUUID();
				String qnaFile = uuid.toString() + "_" + file.getOriginalFilename();
				qnavo.setQnaFile(qnaFile);
				file.transferTo(new File(path, qnaFile));
			}
	        
	        int result = addService.getQNAInsert(qnavo);
	        if (result > 0) {
	        	return mv;
			}
	        return null;  
	    } catch (Exception e) {
	        System.out.println(e);
	        e.printStackTrace();
	        return null;
	    }
	}
	
	// 파일 다운로드
	@GetMapping("/add_qna_ask_filedown")
	public void aadQnaAskFiledown(HttpServletRequest request, HttpServletResponse response) {
		try {
			String qnaFile = request.getParameter("qnaFile");
			String path = request.getSession().getServletContext().getRealPath("/resources/upload/"+qnaFile);
			String r_path = URLEncoder.encode(path, "UTF-8");
			// 브라우저 설정
			response.setContentType("application/x-msdownload");
			response.setHeader("Content-Disposition", "attachment; filename=" + r_path);
			
			// 실제 가져오기
			File file = new File(new String(path.getBytes(), "UTF-8"));
			FileInputStream in = new FileInputStream(file);
			OutputStream out = response.getOutputStream();
			
			FileCopyUtils.copy(in, out);
			
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	@GetMapping("/add_qna_detail_admin")
	public ModelAndView addQnaDetailAdmin(@RequestParam("qnaIdx") String qnaIdx) {
		ModelAndView mv = new ModelAndView("ADD/ADD_QNA_detail_admin");
		QNAVO qnavo = addService.getQNADetail(qnaIdx);
		if (qnavo != null) {
			mv.addObject("qnavo", qnavo);
			return mv;
		}
		return null;
	}
	
}