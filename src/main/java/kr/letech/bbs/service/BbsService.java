package kr.letech.bbs.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

public interface BbsService {

	/**
	 * 게시판 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List get00List(Map params)throws Exception;
	
	/**
	 * 이미지 게시판 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getBbsImgList(Map params) throws Exception;

	/**
	 * 페이징 처리된 게시판 서비스
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getBbs00Object(Map params)throws Exception;
	
	/**
	 * 게시물 등록
	 * @param params
	 * @param fileList
	 * @throws Exception
	 */
	public void insertBbs(Map params, List fileList) throws Exception;

	/**
	 * 게시물 수정
	 * @param params
	 * @param fileList
	 * @throws Exception
	 */
	public void updateBbs(Map params, List fileList) throws Exception;

	/**
	 * 게시물 상세조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map getBbsView(Map params) throws Exception;

	/**
	 * 게시물 조회수 증가
	 * @param params
	 * @throws Exception
	 */
	public void updateHitBbs(Map params) throws Exception;
	
	/**
	 * 게시물 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteBbs(Map params) throws Exception;
	
	/**
	 * 게시물 파일 정보 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List getBbsFileList(Map params) throws Exception;
	
	/**
	 * 게시물 파일 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteBbsFile(Map params) throws Exception; 
	
	/**
	 * 공지사항 정보 가져오기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List noticeList(Map params) throws Exception;
	
	/**
	 * 게시글 목록 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List getRepList(Map params)throws Exception;

	/**
	 * 댓글 등록
	 * @param params
	 * @throws Exception
	 */
	public void insertReply(Map params)throws Exception;

	/**
	 * 댓글 수정
	 * @param params
	 * @throws Exception
	 */
	public void updateReply(Map params)throws Exception;

	/**
	 * 댓글 삭제
	 * @param params
	 * @throws Exception
	 */
	public void deleteReply(Map params)throws Exception;
}
