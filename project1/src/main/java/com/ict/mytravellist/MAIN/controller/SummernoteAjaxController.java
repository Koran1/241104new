package com.ict.mytravellist.MAIN.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.ict.mytravellist.MAIN.service.TourTalkService;
import com.ict.mytravellist.vo.ImgVO;
import com.ict.mytravellist.vo.TourTalkVO;

@RestController
public class SummernoteAjaxController {
	
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
	@RequestMapping(value = "/bbs_write_ok", method = RequestMethod.POST)
	@ResponseBody
	public void getBbsWriteOk(TourTalkVO tourtvo, HttpServletRequest request) {
		try {
			System.out.println(tourtvo.getTourTalkContent());
			/* tourtvo.setUserId("hong"); */
			
			
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
	
	
	
}
