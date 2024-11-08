package com.ict.mytravellist.MAIN.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ict.mytravellist.MAIN.service.TourTalkService;
import com.ict.mytravellist.vo.ImgVO;
import com.ict.mytravellist.vo.ReportVO;
import com.ict.mytravellist.vo.TourTalkVO;
import com.ict.mytravellist.vo.UserVO;

@RestController
public class MainRestController {
	
	@Autowired
	private TourTalkService tourTalkService;

    // 특정 관광지의 상세 정보와 TourTalk 정보 조회
    @PostMapping(value = "/getTourTalkList", produces = "application/json; charset=utf-8")
    @ResponseBody
    public List<TourTalkVO> detail(@RequestParam("travelIdx") String travelIdx) {
        // travelIdx에 해당하는 TourTalk 정보를 가져오기
        List<TourTalkVO> list = tourTalkService.getTourTalkList(travelIdx);
        if (!list.isEmpty()) {
            return list;
        } else {
            return null;
        }
    }
    
    // 글 등록 처리
	@RequestMapping(value = "/tourtalk_write_ok", method = RequestMethod.POST)
	@ResponseBody
	public void getBbsWriteOk(TourTalkVO tourtvo, HttpServletRequest request) {
		try {
	        String userId = (String) request.getSession().getAttribute("userId");
	        tourtvo.setUserId(userId);
			int result = tourTalkService.getTourTalkInsert(tourtvo);
		    } catch (Exception e) {
		    	e.printStackTrace();
		    }
	}	
	
    // 이미지 업로드 처리
	@RequestMapping(value = "/saveImg", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> saveImg(ImgVO imgVO, HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		try {
			MultipartFile file = imgVO.getS_file();
			String fname = null;
			if(file.getSize()>0) {
				String path = request.getSession().getServletContext().getRealPath("/resources/upload");
				UUID uuid = UUID.randomUUID();
				fname = uuid.toString()+"_"+file.getOriginalFilename();
				// 파일 업로드 처리
				file.transferTo(new File(path, fname));
			}
			map.put("path", "resources/upload");
			map.put("fname", fname);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	 	@RequestMapping(value = "/report", produces = "application/json; charset=utf-8")
	    @ResponseBody
	    public Map<String, Object> getReportInsert(
	    		@RequestBody ReportVO repvo, HttpServletRequest request) {
	        Map<String, Object> map = new HashMap<>();
	        try {
	            // 세션에서 reporter ID 가져오기
	            String reporter = (String) request.getSession().getAttribute("userId");
	            repvo.setReporter(reporter);

	            // 1. 신고 정보 저장
	            int reportInsertResult = tourTalkService.getReportInsert(repvo);
	            
	            // 2. tourtalk 테이블 hit 증가 및 조건부 active 업데이트
	            int reportCountUpdateResult = tourTalkService.getReportCountUpdate(repvo.getTourTalkIdx());

	            // 3. pjcustomer 테이블 userEtc01 증가
	            int customerCountUpdateResult = tourTalkService.getCustomerCountUpdate(repvo.getWriter());

	            // 결과 확인
	            if (reportInsertResult > 0 && reportCountUpdateResult > 0 && customerCountUpdateResult > 0) {
	                map.put("status", "success");
	                map.put("message", "신고가 접수되었고 관련 업데이트가 완료되었습니다.");
	            } else {
	                map.put("status", "fail");
	                map.put("message", "신고 접수 또는 관련 업데이트에 실패했습니다.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            map.put("status", "error");
	            map.put("message", "예외가 발생했습니다: " + e.getMessage());
	        }

	        return map;
	    }
	
	
}























