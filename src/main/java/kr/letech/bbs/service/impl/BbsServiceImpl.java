package kr.letech.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.letech.app.service.AppPushService;
import kr.letech.bbs.service.BbsService;
import kr.letech.cmm.util.EgovFileTool;
import kr.letech.cmm.util.ObjToConvert;
import kr.letech.cmm.util.PageNavigator;
import kr.letech.cmm.util.ReqUtils;

@Service("bbsService")
public class BbsServiceImpl implements BbsService {
	
	@Resource(name="bbsDAO")
	private BbsDAO bbsDAO;
	
	@Resource(name="appPushService")
	private AppPushService appPushService;

	@Override
	public List get00List(Map params) throws Exception {
		return bbsDAO.getList("bbs.get00List", params);
	}

	@Override
	public Map getBbs00Object(Map params) throws Exception {
		
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "10");
		String searchGubun = ReqUtils.getEmptyResult2((String)params.get("searchGubun"), "");	
		String searchField = ReqUtils.getEmptyResult2((String)params.get("searchField"), "");
		
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		totalCnt = bbsDAO.getBbsListCnt(params);
		
		int offSet = pageCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = intListCnt; //ObjToConvert.strToint(cPage)*intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,"notice00L.do"
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,"&nt_id=" + (String)params.get("bbs_id")  +"&searchGubun=" + searchGubun 
			   + "&searchField=" + searchField); // 검색 파라미터
		
		
		List list = bbsDAO.getBbsList(params, offSet, limit);
		
		Map objectMap = new HashMap();
		
		objectMap.put("resultList", list);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		return objectMap;
	}

	/**
	 * 이미지 게시판 조회
	 */
	@Override
	public Map getBbsImgList(Map params) throws Exception {
		
		String cPage = ReqUtils.getEmptyResult2((String)params.get("cPage"), "1");
		String listCnt = ReqUtils.getEmptyResult2((String)params.get("listCnt"), "16");
		String searchGubun = ReqUtils.getEmptyResult2((String)params.get("searchGubun"), "");	
		String searchField = ReqUtils.getEmptyResult2((String)params.get("searchField"), "");
		
		
		int intPage = Integer.parseInt(cPage);			/* 현재페이지 */
		int intListCnt = Integer.parseInt(listCnt);		/* 세로페이징(게시글수)*/
		int pageCnt = 10;								/* 가로페이징(페이지수) */
		int totalCnt = 0;								/* 총 건수  */
		
		totalCnt = bbsDAO.getBbsListCnt(params);
		
		int offSet = pageCnt * (ObjToConvert.strToint(cPage)-1);
		int limit = intListCnt; //ObjToConvert.strToint(cPage)*intListCnt;
		
		// 페이지 네비게이터 생성
		PageNavigator pageNavigator = new PageNavigator(
				intPage		
			   ,""
			   ,pageCnt		
			   ,intListCnt	
			   ,totalCnt	
			   ,""); // 검색 파라미터
		
		
		List list = bbsDAO.getBbsImgList(params, offSet, limit);
		
		Map objectMap = new HashMap();
		
		objectMap.put("resultList", list);
		objectMap.put("cPage", cPage);
		objectMap.put("intListCnt", intListCnt);
		objectMap.put("totalCnt", totalCnt);
		objectMap.put("pageNavigator", pageNavigator.getMakePageScript());
		
		return objectMap;
	}
	/**
	 * 게시물 등록
	 * @param params
	 * @param fileList
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void insertBbs(Map params, List fileList) throws Exception {
		
		// 게시물 등록
		bbsDAO.insertBbs(params);
		
		//  게시물 첨부파일 등록 
		int fileCnt = fileList.size();
		Map fileParams = new HashMap();
		for(int i=0; i < fileCnt; i++){
			Map file = (Map)fileList.get(i);
			fileParams = new HashMap();
			fileParams = params;
			fileParams.put("file_nm", file.get("OrignlFileNm"));		// 원문파일명
			fileParams.put("file_stre_nm", file.get("StreFileNm"));		// 저장파일명
			fileParams.put("file_path", file.get("FileStreCours"));		// 저장위치
			fileParams.put("file_size", file.get("FileMg"));			// 파일크기
			fileParams.put("file_ext", file.get("FileExtsn"));			// 파일확장자
			
			bbsDAO.insertBbsFile(fileParams);
		}
		
		// 안드로이드 푸시 기능 관련 (공지사항)
		if(params.get("bbs_id").equals("BB0001")){
			appPushService.googlePushSend(params);
		}
	}
	
	/**
	 * 게시물 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map getBbsView(Map params) throws Exception{
		return bbsDAO.getBbsView(params);
	}

	/**
	 * 게시물 수정
	 * @param params
	 * @param fileList
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void updateBbs(Map params, List fileList) throws Exception {
		
		// 게시물 등록
		bbsDAO.updateBbs(params);
		
		//  게시물 첨부파일 등록 
		int fileCnt = fileList.size();
		Map fileParams = new HashMap();
		for(int i=0; i < fileCnt; i++){
			Map file = (Map)fileList.get(i);
			fileParams = new HashMap();
			fileParams = params;
			fileParams.put("file_nm", file.get("OrignlFileNm"));		// 원문파일명
			fileParams.put("file_stre_nm", file.get("StreFileNm"));		// 저장파일명
			fileParams.put("file_path", file.get("FileStreCours"));		// 저장위치
			fileParams.put("file_size", file.get("FileMg"));			// 파일크기
			fileParams.put("file_ext", file.get("FileExtsn"));			// 파일확장자
			
			bbsDAO.insertBbsFile(fileParams);
		}
		
	}
	
	/**
	 * 게시물 조회수 증가
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void updateHitBbs(Map params) throws Exception {
		bbsDAO.updateHitBbs(params);;
	}

	/**
	 * 게시물 삭제
	 * @param params
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void deleteBbs(Map params) throws Exception {
		/* 일정 삭제 */
		bbsDAO.deleteBbs(params);
		
		// 파일 삭제하기전에 정보 조회
		List fileList = bbsDAO.getBbsFileList(params);
		/* 일정 파일 삭제 */
		bbsDAO.deleteBbsFileAll(params);
		
		/* 물리적 파일 삭제 */
		int fileListCnt = fileList.size();
		for(int i=0; i < fileListCnt; i++){
			Map file = (Map)fileList.get(i);
			String file_stre_nm = (String)file.get("FILE_STRE_NM");		// 저장파일명
			String file_path = (String)file.get("FILE_PATH");			// 저장위치
			// 파일 삭제
			EgovFileTool.deleteFile(file_path+file_stre_nm);
		}
	}
	

	/**
	 * 게시물 파일 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List getBbsFileList(Map params) throws Exception {
		return bbsDAO.getBbsFileList(params);
	}
	/**
	 * 게시물 파일 삭제
	 * @param params
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public void deleteBbsFile(Map params) throws Exception {
		// 파일 삭제
		bbsDAO.deleteBbsFile(params);

		/* 물리적 파일 삭제 */
		String file_stre_nm = (String)params.get("file_stre_nm");		// 저장파일명
		String file_path = (String)params.get("file_path");			// 저장위치
		// 파일 삭제
		EgovFileTool.deleteFile(file_path+file_stre_nm);
	}
	
	/**
	 * 공지사항 정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List noticeList(Map params) throws Exception {
		return bbsDAO.noticeList(params);
	}

	@Override
	public void insertReply(Map params) throws Exception {
		bbsDAO.insertReply(params);
	}

	@Override
	public void updateReply(Map params) throws Exception {
		bbsDAO.updateReply(params);
	}

	@Override
	public List getRepList(Map params) throws Exception {
		return bbsDAO.getRepList(params);
	}

	@Override
	public void deleteReply(Map params) throws Exception {
		bbsDAO.deleteReply(params);
	}
}
