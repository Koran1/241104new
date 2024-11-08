package com.ict.mytravellist.PLAN.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mytravellist.PLAN.comm.MyTrvlPlan_Intrst_Paging;
import com.ict.mytravellist.PLAN.comm.MyTrvlPlan_Plans_Paging;
import com.ict.mytravellist.PLAN.service.TravelService;
import com.ict.mytravellist.WTHR.service.WeatherService;
import com.ict.mytravellist.vo.TravelDBVO;
import com.ict.mytravellist.vo.TrvlPlanVO;

@Controller
public class PlanController {
	
	@Autowired
	private TravelService travelService;
	
	@Autowired
	private MyTrvlPlan_Intrst_Paging intrst_Paging;
	
	@Autowired
	private MyTrvlPlan_Plans_Paging plans_Paging;
	
	@RequestMapping("/mytrvlplan")
	public ModelAndView goPLAN(HttpServletRequest request, HttpSession session) { 
		ModelAndView mv = new ModelAndView("PLAN/mytrvlplan");
		try {
			String userId = (String) session.getAttribute("userId");
			
			// Paging Settings
			int totalCount = travelService.getTotalCount(userId);
			intrst_Paging.setTotalRecord(totalCount);
			
			if(intrst_Paging.getTotalRecord() <= intrst_Paging.getNumPerPage()) {
				intrst_Paging.setTotalPage(1);
			}else {
				int totalPage = intrst_Paging.getTotalRecord() / intrst_Paging.getNumPerPage();
				if(intrst_Paging.getTotalRecord() % intrst_Paging.getNumPerPage() != 0 ) {
					totalPage += 1;
				}
				intrst_Paging.setTotalPage(totalPage);
			}
			
			String intrst_cPage = request.getParameter("intrst_cPage");
			if(intrst_cPage == null) {
				intrst_Paging.setNowPage(1);
			}else {
				intrst_Paging.setNowPage(Integer.parseInt(intrst_cPage));
			}
			
			int limit = intrst_Paging.getNumPerPage();
			int offset = limit * (intrst_Paging.getNowPage() - 1);
			intrst_Paging.setOffset(offset);
			intrst_Paging.setBeginBlock(
					(int)(((intrst_Paging.getNowPage()-1)/intrst_Paging.getPagePerBlock()) * intrst_Paging.getPagePerBlock() + 1)
					);
			intrst_Paging.setEndBlock(
					intrst_Paging.getBeginBlock() + intrst_Paging.getPagePerBlock()-1
					);
			
			if(intrst_Paging.getEndBlock() > intrst_Paging.getTotalPage()) {
				intrst_Paging.setEndBlock(intrst_Paging.getTotalPage());
			}
			
			List<TravelDBVO> list_trvlfav_paged = travelService.selectListTrvlFavPaged(userId, offset, limit);
			mv.addObject("list_trvlfav_paged", list_trvlfav_paged);
			mv.addObject("intrst_Paging", intrst_Paging);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return mv;
	}
	
	@RequestMapping("/mytrvlplan_unlike")
	public ModelAndView goPLANUnlike(@RequestParam("travelIdx") List<String>  travelIdx, HttpSession session) {
		ModelAndView mv = new ModelAndView("redirect:/mytrvlplan");
		try {
			String userId = (String) session.getAttribute("userId");
			
			for (String k : travelIdx) {
				int result = travelService.unlikeTrvlFav(userId, k);
				if(result <= 0) {
					mv.setViewName("PLAN/error");
					return mv;
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("PLAN/error");
		}
		return mv;
	}
	
	@RequestMapping("/mytrvlplan_create")
	public ModelAndView goPLANCreate(HttpSession session) { 
		ModelAndView mv = new ModelAndView("PLAN/mytrvlplan_create");
		try {
			String userId = (String) session.getAttribute("userId");
			List<TravelDBVO> list_trvlfav = travelService.selectListTrvlFav(userId);
			mv.addObject("list_trvlfav", list_trvlfav);
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("PLAN/plan_error");
		}
		return mv;
	}
	
	@PostMapping("/mytrvlplan_create_ok")
	public ModelAndView goPLANCreateOK(TrvlPlanVO tplvo, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		try {
			String userId = (String) session.getAttribute("userId");
			tplvo.setUserId(userId);
			
			int result = travelService.insertTrvlPlan(tplvo);
			if(result > 0) {
				mv.setViewName("redirect:/mytrvlplan_list");
			} else {
				mv.setViewName("PLAN/plan_error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("PLAN/plan_error");
		}
		return mv;
	}
	
	@RequestMapping("/mytrvlplan_list")
	public ModelAndView goPLANList(HttpServletRequest request ,HttpSession session) { 
		ModelAndView mv = new ModelAndView("PLAN/mytrvlplan_list");
		try {
			String userId = (String) session.getAttribute("userId");
			int count = travelService.getPlansCount(userId);
			plans_Paging.setTotalRecord(count);
			
			if(plans_Paging.getTotalRecord() <= plans_Paging.getNumPerPage()) {
				plans_Paging.setTotalPage(1);
			}else {
				int totalPage = plans_Paging.getTotalRecord() / plans_Paging.getNumPerPage();
				if(plans_Paging.getTotalRecord() % plans_Paging.getNumPerPage() != 0 ) {
					totalPage += 1;
				}
				plans_Paging.setTotalPage(totalPage);
			}
			
			String plans_cPage = request.getParameter("plans_cPage");
			if(plans_cPage == null) {
				plans_Paging.setNowPage(1);
			} else {
				plans_Paging.setNowPage(Integer.parseInt(plans_cPage));
			}
			
			int limit = plans_Paging.getNumPerPage();
			int offset = limit * (plans_Paging.getNowPage() - 1);
			plans_Paging.setOffset(offset);
			plans_Paging.setBeginBlock(
					(int)(((plans_Paging.getNowPage()-1) / plans_Paging.getPagePerBlock()) *plans_Paging.getPagePerBlock() +1)
					);
			plans_Paging.setEndBlock(
					plans_Paging.getBeginBlock() + plans_Paging.getPagePerBlock() -1
					);
			
			if(plans_Paging.getEndBlock() > plans_Paging.getTotalPage()) {
				plans_Paging.setEndBlock(plans_Paging.getTotalPage());
			}
			
			List<TrvlPlanVO> list_user = travelService.selectTrvlPlans(userId, offset, limit);
			mv.addObject("list_user", list_user);
			mv.addObject("plans_Paging", plans_Paging);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping("/mytrvlplan_list_detail")
	public ModelAndView goPLANListDetail(
			@ModelAttribute("trvlPlanIdx") String trvlPlanIdx,
			HttpSession session) { 
		ModelAndView mv = new ModelAndView("PLAN/mytrvlplan_list_detail");
		try {
			TrvlPlanVO tplvo = travelService.selectOneTrvlPlan(trvlPlanIdx);
			mv.addObject("tplvo", tplvo);
			
			List<TravelDBVO> list_detail = new ArrayList<TravelDBVO>();
			String tpl_trrsrtNm1 = tplvo.getTrvlPlantrrsrtNm1();
			if(tpl_trrsrtNm1 != null) {
				TravelDBVO tplvo1 = travelService.selectOne(tpl_trrsrtNm1);
				list_detail.add(tplvo1);
			}
			
			String tpl_trrsrtNm2 = tplvo.getTrvlPlantrrsrtNm2();
			if(tpl_trrsrtNm2 != null) {
				TravelDBVO tplvo2 = travelService.selectOne(tpl_trrsrtNm2);
				list_detail.add(tplvo2);
			}
			
			String tpl_trrsrtNm3 = tplvo.getTrvlPlantrrsrtNm3();
			if(tpl_trrsrtNm3 != null) {
				TravelDBVO tplvo3 = travelService.selectOne(tpl_trrsrtNm3);
				list_detail.add(tplvo3);
			}
			
			String tpl_trrsrtNm4 = tplvo.getTrvlPlantrrsrtNm4();
			if(tpl_trrsrtNm4 != null) {
				TravelDBVO tplvo4 = travelService.selectOne(tpl_trrsrtNm4);
				list_detail.add(tplvo4);
			}
			
			String tpl_trrsrtNm5 = tplvo.getTrvlPlantrrsrtNm5();
			if(tpl_trrsrtNm5 != null) {
				TravelDBVO tplvo5 = travelService.selectOne(tpl_trrsrtNm5);
				list_detail.add(tplvo5);
			}
			
			session.setAttribute("list_detail", list_detail);
			
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("PLAN/plan_error");
		}
		
		return mv;
	}
	
	
	
	@GetMapping("/mytrvlplan_update")
	public ModelAndView goPlanUpdate(
			@ModelAttribute("trvlPlanIdx") String trvlPlanIdx) {
		ModelAndView mv = new ModelAndView();
		try {
			TrvlPlanVO tplvo = travelService.selectOneTrvlPlan(trvlPlanIdx);
			mv.addObject("tplvo", tplvo);
			mv.setViewName("PLAN/mytrvlplan_update");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("PLAN/plan_error");
		}
		return mv;
	}
	
	@PostMapping("/mytrvlplan_update_ok")
	public ModelAndView goPlanUpdateOK(
			@ModelAttribute("trvlPlanIdx") String trvlPlanIdx,
			TrvlPlanVO tplvo, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		try {
			String userId = (String) session.getAttribute("userId");
			tplvo.setUserId(userId);
			int result = travelService.updateTrvlPlan(tplvo);
			  
			if(result > 0) {
			mv.setViewName("redirect:/mytrvlplan_list_detail?trvlPlanIdx="+trvlPlanIdx);
			} else { 
				mv.setViewName("PLAN/plan_error");
			}
			 
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("PLAN/plan_error");
		}
		return mv;
	}
	
	
	
	
	
}
