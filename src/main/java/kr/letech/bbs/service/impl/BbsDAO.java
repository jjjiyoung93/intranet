package kr.letech.bbs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.letech.cmm.service.impl.AbstractDAO;

/**
 * 게시판 DAO
 * @author jwchoi
 * @date 2015. 10. 23.
 */
@Repository("bbsDAO")
public class BbsDAO extends AbstractDAO {

	/**
	 * 게시판 카운터 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int getBbsListCnt(Map params)throws Exception {
		return (Integer) getObject("bbs.getBbsListCnt", params);
	}

	/**
	 * 게시판 리스트 조회
	 * @param params
	 * @param offSet
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	public List getBbsList(Map params, int offSet, int limit) throws Exception {
		return getList("bbs.getBbsList", params, offSet, limit);
	}
	
	/**
	 * 이미지게시판 목록조회
	 * @param params
	 * @param offSet
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	public List getBbsImgList(Map params, int offSet, int limit) throws Exception {
		return getList("bbs.getBbsImgList", params, offSet, limit);
	}
	
	/**
	 * 게시물 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public void insertBbs(Map params) throws Exception {
		insert("bbs.insertBbs", params);
	}
	
	/**
	 * 게시물 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getBbsView(Map params) throws Exception {
		return (Map)getObject("bbs.getBbsView", params);
	}
	
	/**
	 * 게시물 증가
	 * @param params
	 * @throws Exception
	 */
	public void updateBbs(Map params) throws Exception {
		update("bbs.updateBbs", params);
	}
	
	/**
	 * 게시물 조회수 증가
	 * @param params
	 * @throws Exception
	 */
	public void updateHitBbs(Map params) throws Exception {
		update("bbs.updateHitBbs", params);
	}
	
	/**
	 * 게시물 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteBbs(Map params) throws Exception {
		delete("bbs.deleteBbs", params);
	}
	
	
	/**
	 * 게시물 파일 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertBbsFile(Map params) throws Exception {
		insert("bbs.insertBbsFile", params);
	}

	/**
	 * 게시물 파일 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getBbsFileList(Map params) throws Exception {
		return getList("bbs.getBbsFileList", params);
	}
	
	/**
	 * 게시물 파일 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteBbsFile(Map params) throws Exception {
		delete("bbs.deleteBbsFile", params);
	}
	
	/**
	 * 게시물 파일 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteBbsFileAll(Map params) throws Exception {
		delete("bbs.deleteBbsFileAll", params);
	}
	
	/**
	 * 공지사항 정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List noticeList(Map params) throws Exception {
		return getList("bbs.noticeList", params);
	}

	/**
	 * 댓글 등록
	 * @param params
	 */
	public void insertReply(Map params)  throws Exception {
		insert("bbs.insertReply",params);
	}

	/**
	 * 댓글 목록 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getRepList(Map params)  throws Exception {
		return getList("bbs.getRepList", params);
	}

	/**
	 * 댓글 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteReply(Map params) throws Exception {
		delete("bbs.deleteReply", params);
	}

	/**
	 * 댓글 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateReply(Map params) throws Exception {
		update("bbs.updateReply", params);
	}
}
