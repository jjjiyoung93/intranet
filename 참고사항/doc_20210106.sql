/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/**************************************** DROP ****************************************/
/* 서류_출장정산 */
DROP TABLE DOC_BZTRP_ADJS 
	CASCADE CONSTRAINTS;

/* 서류_품의 */
DROP TABLE DOC_PTTN 
	CASCADE CONSTRAINTS;

/* 서류_도서구매 */
DROP TABLE DOC_BKS_BUY_APLF 
	CASCADE CONSTRAINTS;

/* 서류_휴가 */
DROP TABLE DOC_FROGH 
	CASCADE CONSTRAINTS;

/* 서류_유연근무제 */
DROP TABLE DOC_FLEX_WRK_SYST 
	CASCADE CONSTRAINTS;

/* 서류_교육훈련 */
DROP TABLE DOC_EDUC_TRAIN 
	CASCADE CONSTRAINTS;

/* 서류_출장정산_항목 */
DROP TABLE DOC_BZTRP_ADJS_ITEM 
	CASCADE CONSTRAINTS;

/* 서류_양식 */
DROP TABLE DOC_FORM
	CASCADE CONSTRAINTS;

/* 결재라인정보 */
DROP TABLE STD_APRV_LINE_INFO
    CASCADE CONSTRAINTS;

/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/**************************************** CREATE ****************************************/
/* 서류_출장정산 */
CREATE TABLE DOC_BZTRP_ADJS (
	APRV_NO VARCHAR2(20) NOT NULL, /* 결재번호 */
	BZTRP_DIV VARCHAR2(20), /* 출장구분 */
	BZTRP_PURP VARCHAR2(200), /* 출장목적 */
	BZTRP_PER VARCHAR2(200), /* 출장인원 */
    BZTRP_NIGHT VARCHAR2(50), /* 출장숙박일 */
	BZTRP_DAYS VARCHAR2(50), /* 출장일수 */
	BZTRP_PLC VARCHAR2(200), /* 출장장소 */
	DPAR_AREA VARCHAR2(200), /* 출발지 */
	ARYL_AREA VARCHAR2(200), /* 도착지 */
	PLND_AMT VARCHAR2(50), /* 전도금 */
	CORP_CRD_USE_AMT VARCHAR2(50), /* 기업카드사용금액 */
    BZTRP_ITEM_SUM VARCHAR2(50), /* 합계 */
    PROVD_AMT VARCHAR2(50), /* 차액 */
	BZTRP_RMRK VARCHAR2(500) /* 비고 */
);

COMMENT ON TABLE DOC_BZTRP_ADJS IS '서류_출장정산';
COMMENT ON COLUMN DOC_BZTRP_ADJS.APRV_NO IS '결재번호';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_DIV IS '출장구분';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_PURP IS '출장목적';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_PER IS '출장인원';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_NIGHT IS '출장숙박일';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_DAYS IS '출장일수';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_PLC IS '출장장소';
COMMENT ON COLUMN DOC_BZTRP_ADJS.DPAR_AREA IS '출발지';
COMMENT ON COLUMN DOC_BZTRP_ADJS.ARYL_AREA IS '도착지';
COMMENT ON COLUMN DOC_BZTRP_ADJS.PLND_AMT IS '전도금';
COMMENT ON COLUMN DOC_BZTRP_ADJS.CORP_CRD_USE_AMT IS '기업카드사용금액';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_ITEM_SUM IS '합계';
COMMENT ON COLUMN DOC_BZTRP_ADJS.PROVD_AMT IS '차액';
COMMENT ON COLUMN DOC_BZTRP_ADJS.BZTRP_RMRK IS '비고';

ALTER TABLE DOC_BZTRP_ADJS ADD CONSTRAINT PK_DOC_BZTRP_ADJS PRIMARY KEY (APRV_NO);
ALTER TABLE DOC_BZTRP_ADJS ADD CONSTRAINT FK_DOC_BZTRP_ADJS FOREIGN KEY (APRV_NO) REFERENCES STD_APRV_MNG (APRV_NO);





/* 서류_출장정산_항목 */
CREATE TABLE DOC_BZTRP_ADJS_ITEM (
	APRV_NO VARCHAR2(20) NOT NULL, /* 결재번호 */
	BZTRP_ITEM_SEQ VARCHAR2(5) NOT NULL, /* 순서 */
	BZTRP_ITEM_DIV VARCHAR2(20), /* 항목 */
	BZTRP_ITEM_CTNT VARCHAR2(200), /* 내역 */
	BZTRP_ITEM_AMT VARCHAR2(50), /* 금액 */
	BZTRP_ITEM_RMRK VARCHAR2(500) /* 비고 */
);

COMMENT ON TABLE DOC_BZTRP_ADJS_ITEM IS '서류_출장정산_항목';
COMMENT ON COLUMN DOC_BZTRP_ADJS_ITEM.APRV_NO IS '결재번호';
COMMENT ON COLUMN DOC_BZTRP_ADJS_ITEM.BZTRP_ITEM_SEQ IS '순서';
COMMENT ON COLUMN DOC_BZTRP_ADJS_ITEM.BZTRP_ITEM_DIV IS '항목';
COMMENT ON COLUMN DOC_BZTRP_ADJS_ITEM.BZTRP_ITEM_CTNT IS '내역';
COMMENT ON COLUMN DOC_BZTRP_ADJS_ITEM.BZTRP_ITEM_AMT IS '금액';
COMMENT ON COLUMN DOC_BZTRP_ADJS_ITEM.BZTRP_ITEM_RMRK IS '비고';

ALTER TABLE DOC_BZTRP_ADJS_ITEM ADD CONSTRAINT PK_DOC_BZTRP_ADJS_ITEM PRIMARY KEY (APRV_NO, BZTRP_ITEM_SEQ);
ALTER TABLE DOC_BZTRP_ADJS_ITEM ADD CONSTRAINT FK_DOC_BZTRP_ADJS_ITEM FOREIGN KEY (APRV_NO) REFERENCES DOC_BZTRP_ADJS (APRV_NO);

        
        
        
        
/* 서류_품의 */
CREATE TABLE DOC_PTTN (
	APRV_NO VARCHAR2(20) NOT NULL, /* 결재번호 */
	PTTN_DIV VARCHAR2(20), /* 품의구분 */
    PTTN_CONT CLOB /* 품의내용 */
);

COMMENT ON TABLE DOC_PTTN IS '서류_품의';
COMMENT ON COLUMN DOC_PTTN.APRV_NO IS '결재번호';
COMMENT ON COLUMN DOC_PTTN.PTTN_DIV IS '품의구분';
COMMENT ON COLUMN DOC_PTTN.PTTN_CONT IS '품의내용';

ALTER TABLE DOC_PTTN ADD CONSTRAINT PK_DOC_PTTN PRIMARY KEY (APRV_NO);
ALTER TABLE DOC_PTTN ADD CONSTRAINT FK_DOC_PTTN FOREIGN KEY (APRV_NO) REFERENCES STD_APRV_MNG (APRV_NO);


    
    

/* 서류_도서구매 */
CREATE TABLE DOC_BKS_BUY_APLF (
	APRV_NO VARCHAR2(20) NOT NULL, /* 결재번호 */
    BKS_NM VARCHAR2(200), /* 도서명 */
	PUCH_PURP VARCHAR2(200), /* 구입목적 */
	AUTHR_NM VARCHAR2(200), /* 저자명 */
	PBCM VARCHAR2(200), /* 출판사 */
    PBLT_DD VARCHAR2(50), /* 출판일 */
    ISBN VARCHAR2(20), /* ISBN */
    BKS_AMT VARCHAR2(50), /* 권당 금액 */
    BKS_AMT_SUM VARCHAR2(50), /* 총 금액 */
	PUCH_HOPE_NMVL VARCHAR2(20), /* 구입희망권수 */
	PUCH_HOPE_DD VARCHAR2(50), /* 구입희망일 */
	RMRK VARCHAR2(500) /* 비고 */
);

COMMENT ON TABLE DOC_BKS_BUY_APLF IS '서류_도서구매';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.APRV_NO IS '결재번호';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.BKS_NM IS '도서명';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.PUCH_PURP IS '구입목적';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.AUTHR_NM IS '저자명';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.PBCM IS '출판사';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.PBLT_DD IS '출판일';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.ISBN IS 'ISBN';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.BKS_AMT IS '권당금액';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.BKS_AMT_SUM IS '총금액';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.PUCH_HOPE_NMVL IS '구입희망권수';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.PUCH_HOPE_DD IS '구입희망일';
COMMENT ON COLUMN DOC_BKS_BUY_APLF.RMRK IS '비고';

ALTER TABLE DOC_BKS_BUY_APLF ADD CONSTRAINT PK_DOC_BKS_BUY_APLF PRIMARY KEY (APRV_NO);
ALTER TABLE DOC_BKS_BUY_APLF ADD CONSTRAINT FK_DOC_BKS_BUY_APLF FOREIGN KEY (APRV_NO) REFERENCES STD_APRV_MNG (APRV_NO);

    
    
    
    
/* 서류_휴가 */
CREATE TABLE DOC_FROGH (
	APRV_NO VARCHAR2(20) NOT NULL, /* 결재번호 */
	FROGH_RSN VARCHAR2(200), /* 휴가사유 */
	ADDR VARCHAR2(200), /* 주소 */
	CTTPLC VARCHAR2(20) /* 연락처 */
);

COMMENT ON TABLE DOC_FROGH IS '서류_휴가';
COMMENT ON COLUMN DOC_FROGH.APRV_NO IS '결재번호';
COMMENT ON COLUMN DOC_FROGH.FROGH_RSN IS '휴가사유';
COMMENT ON COLUMN DOC_FROGH.ADDR IS '주소';
COMMENT ON COLUMN DOC_FROGH.CTTPLC IS '연락처';

ALTER TABLE DOC_FROGH ADD CONSTRAINT PK_DOC_FROGH PRIMARY KEY (APRV_NO);
ALTER TABLE DOC_FROGH ADD CONSTRAINT FK_DOC_FROGH FOREIGN KEY (APRV_NO) REFERENCES STD_APRV_MNG (APRV_NO);





/* 서류_유연근무제 */
CREATE TABLE DOC_FLEX_WRK_SYST (
	APRV_NO VARCHAR2(20) NOT NULL, /* 결재번호 */
	MAIN_BUSI VARCHAR2(200), /* 주요업무 */
	WRK_HH VARCHAR2(200), /* 근무시간 */
	RQST_RSN VARCHAR2(200) /* 요청사유 */
);

COMMENT ON TABLE DOC_FLEX_WRK_SYST IS '서류_유연근무제';
COMMENT ON COLUMN DOC_FLEX_WRK_SYST.APRV_NO IS '결재번호';
COMMENT ON COLUMN DOC_FLEX_WRK_SYST.MAIN_BUSI IS '주요업무';
COMMENT ON COLUMN DOC_FLEX_WRK_SYST.WRK_HH IS '근무시간';
COMMENT ON COLUMN DOC_FLEX_WRK_SYST.RQST_RSN IS '요청사유';

ALTER TABLE DOC_FLEX_WRK_SYST ADD CONSTRAINT PK_DOC_FLEX_WRK_SYST PRIMARY KEY (APRV_NO);
ALTER TABLE DOC_FLEX_WRK_SYST ADD CONSTRAINT FK_DOC_FLEX_WRK_SYST FOREIGN KEY (APRV_NO) REFERENCES STD_APRV_MNG (APRV_NO);
    
    
    
    
    
/* 서류_교육훈련 */
CREATE TABLE DOC_EDUC_TRAIN (
	APRV_NO VARCHAR2(20) NOT NULL, /* 결재번호 */
	EDUC_NM VARCHAR2(200), /* 교육명 */
	EDUC_PURP_CNTN VARCHAR2(3000), /* 교육목적내용 */
	EDUC_PLC VARCHAR2(200), /* 교육장소 */
	EDUC_INST VARCHAR2(200), /* 교육기관 */
	EDUC_COST VARCHAR2(50), /* 교육비용 */
	SPMN VARCHAR2(50), /* 지원금 */
	RMRK VARCHAR2(500) /* 비고 */
);

COMMENT ON TABLE DOC_EDUC_TRAIN IS '서류_교육훈련';
COMMENT ON COLUMN DOC_EDUC_TRAIN.APRV_NO IS '결재번호';
COMMENT ON COLUMN DOC_EDUC_TRAIN.EDUC_NM IS '교육명';
COMMENT ON COLUMN DOC_EDUC_TRAIN.EDUC_PURP_CNTN IS '교육목적내용';
COMMENT ON COLUMN DOC_EDUC_TRAIN.EDUC_PLC IS '교육장소';
COMMENT ON COLUMN DOC_EDUC_TRAIN.EDUC_INST IS '교육기관';
COMMENT ON COLUMN DOC_EDUC_TRAIN.EDUC_COST IS '교육비용';
COMMENT ON COLUMN DOC_EDUC_TRAIN.SPMN IS '지원금';
COMMENT ON COLUMN DOC_EDUC_TRAIN.RMRK IS '비고';

ALTER TABLE DOC_EDUC_TRAIN ADD CONSTRAINT PK_DOC_EDUC_TRAIN PRIMARY KEY (APRV_NO);
ALTER TABLE DOC_EDUC_TRAIN ADD CONSTRAINT FK_DOC_EDUC_TRAIN FOREIGN KEY (APRV_NO) REFERENCES STD_APRV_MNG (APRV_NO);





/* 서류 양식 */
CREATE TABLE DOC_FORM (
    APRV_TYPE_CD VARCHAR2(20), /* 결재구분코드 */
    APRV_TYPE_DTIL_CD VARCHAR2(20), /* 결재구분상세코드 */
    DOC_CODE CLOB, /* 문서코드 */
    DOC_REPORT CLOB, /* 보고서양식 */
    REG_DT DATE, /* 생성일 */
    REG_ID VARCHAR2(20), /* 생성자 */
    MOD_DT DATE, /* 수정일 */
    MOD_ID VARCHAR2(20) /* 수정자 */
);

COMMENT ON COLUMN DOC_FORM.APRV_TYPE_CD IS '결재구분코드';
COMMENT ON COLUMN DOC_FORM.APRV_TYPE_DTIL_CD IS '결재구분상세코드';
COMMENT ON COLUMN DOC_FORM.DOC_CODE IS '문서코드';
COMMENT ON COLUMN DOC_FORM.DOC_REPORT IS '보고서양식';
COMMENT ON COLUMN DOC_FORM.REG_DT IS '생성일';
COMMENT ON COLUMN DOC_FORM.REG_ID IS '생성자';
COMMENT ON COLUMN DOC_FORM.MOD_DT IS '수정일';
COMMENT ON COLUMN DOC_FORM.MOD_ID IS '수정자';

ALTER TABLE DOC_FORM ADD CONSTRAINT PK_DOC_FORM PRIMARY KEY (APRV_TYPE_CD, APRV_TYPE_DTIL_CD);





/* 결재라인정보 */
CREATE TABLE STD_APRV_LINE_INFO (
	EMP_NO VARCHAR2(20) NOT NULL, /* 결재대상사원코드 */
	APRV_ORDR VARCHAR2(2) NOT NULL, /* 결재순서 */
    REFE_YN VARCHAR2(1) NOT NULL, /* 참조자여부 */
	APRV_EMP_NO VARCHAR2(20) NOT NULL /* 결재자사원코드 */
);

COMMENT ON TABLE STD_APRV_LINE_INFO IS '결재라인정보';
COMMENT ON COLUMN STD_APRV_LINE_INFO.EMP_NO IS '결재대상사원코드';
COMMENT ON COLUMN STD_APRV_LINE_INFO.APRV_ORDR IS '결재순서';
COMMENT ON COLUMN STD_APRV_LINE_INFO.REFE_YN IS '참조자여부';
COMMENT ON COLUMN STD_APRV_LINE_INFO.APRV_EMP_NO IS '결재자사원코드';

ALTER TABLE STD_APRV_LINE_INFO ADD CONSTRAINT PK_STD_APRV_LINE_INFO PRIMARY KEY (EMP_NO, APRV_EMP_NO);





/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
/**************************************** INSERT ****************************************/
INSERT INTO DOC_FORM VALUES (
    'CD0000',
    'CD0000',
    '<!-- 행선지 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">행선지</label>
        </div>
        <div class="col-lg-9">
            <input type="text" name="place" id="place" class="form-control"/>
        </div>
    </div>
    <!-- 행선지 END -->
    
    <!-- 기간 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">기간</label>
        </div>
        <div class="col-lg-9">
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="startpicker-container" style="margin-left: -1px;"></div>
            </div>
            ~
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="endpicker-container" style="margin-left: -1px;"></div>
            </div>
        </div>
    </div>
    <!-- 기간 END -->',
    '<h1>보 고 서</h1>
    <div id="fileList"></div>
    <div id="footer" class="text-center">
        <br>
        <h4>위와 같은 사유로 신청합니다.<h4>
        <br>
        <h4 id="crtn_dt"><h4>
    </div>',
    SYSDATE,
    'admin01',
    SYSDATE,
    'admin01'
);

INSERT INTO DOC_FORM VALUES(
    'CD0001011',
    'CD0001011',
    '<!-- 기간 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">기간</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="startpicker-container" style="margin-left: -1px;"></div>
            </div>
            ~
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="endpicker-container" style="margin-left: -1px;"></div>
            </div>
        </div>
    </div>
    <!-- 기간 END -->
    
    <!-- 사유 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">사유</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input type="text" name="frogh_rsn" id="frogh_rsn" class="form-control"/>
        </div>
    </div>
    <!-- 사유 END -->
    
    <!-- 주소 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">행선지</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input type="text" name="addr" id="addr" class="form-control"/>
        </div>
    </div>
    <!-- 주소 END -->
    
    <!-- 연락처 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">연락처</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input type="text" name="cttplc" id="cttplc" class="form-control"/>
        </div>
    </div>
    <!-- 연락처 END -->',
    '<h1>휴 가 신 청 서</h1>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
                <td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
                <td colspan="2" class="td-comm td-s2 td-header">성명</td>
                <td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">기간</td>
                <td colspan="8" class="td-comm td-s8" id="term"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">사유</td>
                <td colspan="8" class="td-comm td-s8" id="frogh_rsn"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">행선지</td>
                <td colspan="8" class="td-comm td-s8" id="addr"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">연락처</td>
                <td colspan="8" class="td-comm td-s8" id="cttplc"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">휴가구분</td>
                <td colspan="8" class="td-comm td-s8" id="frogh_div"></td>
            </tr>
        </tbody>
    </table>
    <div id="fileList"></div>
    <div id="footer" class="text-center">
        <br>
        <h4>위와 같은 사유로 휴가를 신청합니다.<h4>
        <br>
        <h4 id="crtn_dt"><h4>
    </div>',
    SYSDATE,
    'admin01',
    SYSDATE,
    'admin01'
);





INSERT INTO DOC_FORM VALUES(
    'CD0001016',
    'CD0001016',
    '<!-- 교육명 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">교육명</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input type="text" name="educ_nm" id="educ_nm" class="form-control"/>
        </div>
    </div>
    <!-- 교육명 END -->
    
    <!-- 교육훈련목적 및 내용 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">교육훈련목적 및 내용</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <textarea class="form-control" name="educ_purp_cntn" id="educ_purp_cntn"></textarea>
        </div>
    </div>
    <!-- 교육훈련목적 및 내용 END -->
    
    <!-- 교육기간 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">교육기간</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="startpicker-container" style="margin-left: -1px;"></div>
            </div>
            ~
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="endpicker-container" style="margin-left: -1px;"></div>
            </div>
        </div>
    </div>
    <!-- 교육기간 END -->
    
    <!-- 교육장소, 교육기관 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">교육장소</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input type="text" name="educ_plc" id="educ_plc" class="form-control"/>
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">교육기관</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input type="text" name="educ_inst" id="educ_inst" class="form-control"/>
        </div>
    </div>
    <!-- 교육장소, 교육기관 END -->
    
    <!-- 교육비, 지원액 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">교육비</label>
        </div>
        <div class="col-lg-6">
            <input type="text" name="educ_cost" id="educ_cost" class="form-control text-right convNum"/>
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">지원액</label>
        </div>
        <div class="col-lg-6">
            <input type="text" name="spmn" id="spmn" class="form-control text-right convNum"/>
        </div>
    </div>
    <!-- 교육비, 지원액 END -->
    
    <!-- 비고 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">비고</label>
        </div>
        <div class="col-lg-9">
            <textarea class="form-control" name="rmrk" id="rmrk"></textarea>
        </div>
    </div>
    <!-- 비고 END -->',
    '<h1>교 육 훈 련 신 청 서</h1>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
                <td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
                <td colspan="2" class="td-comm td-s2 td-header">성명</td>
                <td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">교육명</td>
                <td colspan="8" class="td-comm td-s8" id="educ_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header" style="height: 300px;">교육훈련목적<br>및 내용</td>
                <td colspan="8" class="td-comm td-s8" id="educ_purp_cntn"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">교육기간</td>
                <td colspan="8" class="td-comm td-s8" id="term"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">교육장소</td>
                <td colspan="3" class="td-comm td-s3" id="educ_plc"></td>
                <td colspan="2" class="td-comm td-s2 td-header">교육기관</td>
                <td colspan="3" class="td-comm td-s3" id="educ_inst"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">교육비</td>
                <td colspan="3" class="td-comm td-s3 text-right" id="educ_cost"></td>
                <td colspan="2" class="td-comm td-s2 td-header">지원액</td>
                <td colspan="3" class="td-comm td-s3 text-right" id="spmn"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">비고</td>
                <td colspan="8" class="td-comm td-s8" id="rmrk"></td>
            </tr>
        </tbody>
    </table>
    <div id="fileList"></div>
    <div id="footer" class="text-center">
        <br>
        <h4>위와 같은 사유로 교육훈련을 신청합니다.<h4>
        <br>
        <h4 id="crtn_dt"><h4>
    </div>',
    SYSDATE,
    'admin01',
    SYSDATE,
    'admin01'
);

INSERT INTO DOC_FORM VALUES(
    'CD0001013',
    'CD0001013001',
    '<!-- 이용기간 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">이용기간</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="startpicker-container" style="margin-left: -1px;"></div>
            </div>
            ~
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="endpicker-container" style="margin-left: -1px;"></div>
            </div>
        </div>
    </div>
    <!-- 이용기간 END -->
    
    <!-- 근무시간 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">근무시간</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <textarea class="form-control" name="wrk_hh" id="wrk_hh"></textarea>
        </div>
    </div>
    <!-- 근무시간 END -->
    
    <!-- 주요업무 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">주요업무</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input type="text" name="main_busi" id="main_busi" class="form-control"/>
        </div>
    </div>
    <!-- 주요업무 END -->
    
    <!-- 요청사유 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">신청사유</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input type="text" name="rqst_rsn" id="rqst_rsn" class="form-control"/>
        </div>
    </div>
    <!-- 요청사유 END -->',
    '<h1>시 차 출 퇴 근 제 신 청 서</h1>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
                <td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
                <td colspan="2" class="td-comm td-s2 td-header">성명</td>
                <td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">주요업무</td>
                <td colspan="8" class="td-comm td-s8" id="main_busi"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">이용기간</td>
                <td colspan="8" class="td-comm td-s8" id="term"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">근무시간</td>
                <td colspan="8" class="td-comm td-s8" id="wrk_hh"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">신청사유</td>
                <td colspan="8" class="td-comm td-s8" id="rqst_rsn"></td>
            </tr>
        </tbody>
    </table>
    <div id="fileList"></div>
    <div id="footer" class="text-center">
        <br>
        <h4>위와 같은 사유로 시차출퇴근제를 신청합니다.<h4>
        <br>
        <h4 id="crtn_dt"><h4>
    </div>',
    SYSDATE,
    'admin01',
    SYSDATE,
    'admin01'
);
delete from doc_form where aprv_type_cd = 'CD0001015';
commit;
INSERT INTO DOC_FORM VALUES(
    'CD0001015',
    'CD0001015',
    TO_CLOB('<!-- 도서명  START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">도서명</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input class="form-control" type="text" id="bks_nm" name="bks_nm"/>
        </div>
    </div>
    <!-- 도서명 END -->
    
    <!-- 구입목적 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">구입목적</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <textarea class="form-control" name="puch_purp" id="puch_purp"></textarea>
        </div>
    </div>
    <!-- 구입목적 END -->
    
    <!-- 저자명 및 출판사 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">저자명</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input class="form-control" type="text" id="authr_nm" name="authr_nm"/>
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">출판사</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input class="form-control" type="text" id="pbcm" name="pbcm"/>
        </div>
    </div>
    <!-- 저자명 및 출판사 END -->
    
    <!-- 출판일 및 ISBN START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">출판일</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input class="form-control" type="text" id="pblt_dd" name="pblt_dd"/>
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">ISBN</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input class="form-control" type="text" id="isbn" name="isbn"/>
        </div>
    </div>
    <!-- 출판일 및 ISBN END -->
    ') || TO_CLOB('
    <!-- 구입희망권수 및 권당금액 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">구입희망권수</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input class="form-control text-right convVol" type="text" id="puch_hope_nmvl" name="puch_hope_nmvl"/>
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">권당금액</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input class="form-control text-right convNum" type="text" id="bks_amt" name="bks_amt"/>
        </div>
    </div>
    <!-- 구입희망권수 및 권당금액 END -->
    
    <!-- 구입희망일 및 총금액 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">구입희망일</label>
        </div>
        <div class="col-lg-6">
            <input class="form-control" type="text" id="puch_hope_dd" name="puch_hope_dd"/>
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">총금액</label>
        </div>
        <div class="col-lg-6">
            <input class="form-control text-right convNum" type="text" id="bks_amt_sum" name="bks_amt_sum" readonly/>
        </div>
    </div>
    <!-- 구입희망일 및 총금액 END -->
    
    <!-- 비고 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">비고</label>
        </div>
        <div class="col-lg-9">
            <textarea class="form-control" name="rmrk" id="rmrk"></textarea>
        </div>
    </div>
    <!-- 비고 END -->'),
    '<h1>도 서 구 매 신 청 서</h1>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
                <td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
                <td colspan="2" class="td-comm td-s2 td-header">성명</td>
                <td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">도서명</td>
                <td colspan="8" class="td-comm td-s8" id="bks_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">구입목적</td>
                <td colspan="8" class="td-comm td-s8" id="puch_purp"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">저자명</td>
                <td colspan="3" class="td-comm td-s3" id="authr_nm"></td>
                <td colspan="2" class="td-comm td-s2 td-header">출판사</td>
                <td colspan="3" class="td-comm td-s3" id="pbcm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">출판일</td>
                <td colspan="3" class="td-comm td-s3" id="pblt_dd"></td>
                <td colspan="2" class="td-comm td-s2 td-header">ISBN</td>
                <td colspan="3" class="td-comm td-s3" id="isbn"></td>
                
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">구입희망권수</td>
                <td colspan="3" class="td-comm td-s3 text-right" id="puch_hope_nmvl"></td>
                <td colspan="2" class="td-comm td-s2 td-header">권당금액</td>
                <td colspan="3" class="td-comm td-s3 text-right" id="bks_amt"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">구입희망일</td>
                <td colspan="3" class="td-comm td-s3" id="puch_hope_dd"></td>
                <td colspan="2" class="td-comm td-s2 td-header">총금액</td>
                <td colspan="3" class="td-comm td-s3 text-right" id="bks_amt_sum"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">비고</td>
                <td colspan="8" class="td-comm td-s8" id="rmrk"></td>
            </tr>
        </tbody>
    </table>
    <div id="fileList"></div>
    <div id="footer" class="text-center">
        <br>
        <h4>위와 같은 사유로 도서구매를 신청합니다.<h4>
        <br>
        <h4 id="crtn_dt"><h4>
    </div>',
    SYSDATE,
    'admin01',
    SYSDATE,
    'admin01'
);

INSERT INTO DOC_FORM VALUES(
    'CD0001008',
    'CD0001008',
    '<!-- 구분 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">품의구분</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <select id="pttn_div" name="pttn_div" class="form-control">
                <option value="">--선택--</option>
                <option value="품의">품의</option>
                <option value="보고">보고</option>
            </select>
        </div>
    </div>
    <!-- 구분 END -->
    
    <!-- 내용 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">품의내용</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <textarea class="form-control" name="pttn_cont" id="pttn_cont" style="height: 400px"></textarea>
        </div>
    </div>
    <!-- 내용 END -->',
    '<h1>품 의 서</h1>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
                <td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
                <td colspan="2" class="td-comm td-s2 td-header">성명</td>
                <td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">품의구분</td>
                <td colspan="8" class="td-comm td-s8" id="pttn_div"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">품의내용</td>
                <td colspan="8" class="td-comm td-s8" style="height: 500px;" id="pttn_cont"></td>
            </tr>
        </tbody>
    </table>
    <div id="fileList"></div>
    <div id="footer" class="text-center">
        <br>
        <h4>위와 같은 사유로 품의를 신청합니다.<h4>
        <br>
        <h4 id="crtn_dt"><h4>
    </div>',
    SYSDATE,
    'admin01',
    SYSDATE,
    'admin01'
);

INSERT INTO DOC_FORM VALUES(
    'CD0001009',
    'CD0001009001',
    TO_CLOB('<!-- 출장구분 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">출장구분</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <select id="bztrp_div" name="bztrp_div" class="form-control">
                <option value="">--선택--</option>
                <option value="일반">일반</option>
                <option value="파견">파견</option>
            </select>
        </div>
    </div>
    <!-- 출장구분 END -->
    
    <!-- 기간 및 일수 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">출장기간</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_st" name="term_st" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="startpicker-container" style="margin-left: -1px;"></div>
            </div>
            ~
            <div class="form-control tui-datepicker-input tui-datetime-input tui-has-focus">
                <input id="term_ed" name="term_ed" type="text" aria-label="Date" autocomplete="off">
                <span class="tui-ico-date"></span>
                <div id="endpicker-container" style="margin-left: -1px;"></div>
            </div>
            <input type="text" class="form-control" name="bztrp_night" id="bztrp_night" style="width: 50px; display: inline; margin-left: 5px;">
            <span>박</span>
            <input type="text" class="form-control" name="bztrp_days" id="bztrp_days" style="width: 50px; display: inline; margin-left: 5px;">
            <span>일</span>
        </div>
    </div>
    <!-- 기간 및 일수 END -->
    
    <!-- 출장목적 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">출장목적</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-9">
            <input type="text" class="form-control" name="bztrp_purp" id="bztrp_purp">
        </div>
    </div>
    <!-- 출장목적 END -->
    
    <!-- 출장자 및 장소 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">출장자</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input type="text" class="form-control" name="bztrp_per" id="bztrp_per">
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">장소</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input type="text" class="form-control" name="bztrp_plc" id="bztrp_plc">
        </div>
    </div>
    <!-- 출장자 및 장소 END -->
    
    <!-- 출발지역 및 도착지역 START -->
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">출발지역</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input type="text" class="form-control" name="dpar_area" id="dpar_area">
        </div>
    </div>
    <div class="col-lg-6 form-group">
        <div class="col-lg-4 col-sm-2 text-right">
            <label class="control-label">도착지역</label>
            <span class="req-sign">*</span>
        </div>
        <div class="col-lg-6">
            <input type="text" class="form-control" name="aryl_area" id="aryl_area">
        </div>
    </div>
    <!-- 출발지역 및 도착지역 END -->
    ') || TO_CLOB('
    <!-- 항목 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-10 col-lg-offset-1">
            <table class="table table-bordered">
                <colgroup>
                    <col width="15%" />
                    <col width="43%" />
                    <col width="15%" />
                    <col width="20%" />
                    <col width="7%" />
                </colgroup>
                <thead>
                    <tr>
                        <th>
                            항목
                            <span class="req-sign">*</span>
                        </th>
                        <th>
                            내역
                            <span class="req-sign">*</span>
                        </th>
                        <th>
                            금액
                            <span class="req-sign">*</span>
                        </th>
                        <th>비고</th>
                        <th><span class="btn btn-xs btn-default" onClick="fn_addBztrpItem()"><i class="glyphicon glyphicon-plus-sign"></i> 추가</span></th>
                    </tr>
                </thead>
                <tbody>') || TO_CLOB('
                    <tr id="tr_bztrp_item_1" class="tr_bztrp_items">
                        <td class="form-group">
                            <select id="bztrp_item_div_1" name="bztrp_item_div_1" class="form-control bztrp_item_divs">
                                <option value="">--선택--</option>
                                <option value="교통비">교통비</option>
                                <option value="여비">여비</option>
                                <option value="기타">기타</option>
                            </select>
                        </td>
                        <td class="form-group">
                            <input type="text" class="form-control bztrp_item_ctnts" id="bztrp_item_ctnt_1" name="bztrp_item_ctnt_1">
                        </td>
                        <td class="form-group">
                            <input type="text" class="form-control bztrp_item_amts text-right convNum" id="bztrp_item_amt_1" name="bztrp_item_amt_1">
                        </td>
                        <td class="form-group">
                            <input type="text" class="form-control bztrp_item_rmrks" id="bztrp_item_rmrk_1" name="bztrp_item_rmrk_1">
                        </td>
                        <td></td>
                    </tr>
                    <tr id="tr_bztrp_item_sum">
                        <td colspan="2" class="text-center" style="border-bottom-width: 2px;">
                            <label class="form-label">합계</label>
                        </td>
                        <td colspan="3" class="text-right" style="border-bottom-width: 2px;">
                            <input type="text" class="form-control text-right" id="bztrp_item_sum" name="bztrp_item_sum" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">
                            <label class="form-label">전도금</label>
                        </td>
                        <td colspan="3" class="text-right">
                            <input type="text" class="form-control text-right convNum" id="plnd_amt" name="plnd_amt">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">
                            <label class="form-label">기업카드사용금액</label>
                        </td>
                        <td colspan="3" class="text-right">
                            <input type="text" class="form-control text-right convNum" id="corp_crd_use_amt" name="corp_crd_use_amt">
                        </td>
                    </tr>
                    <tr>') || TO_CLOB('
                        <td colspan="2" class="text-center">
                            <label class="form-label">지급액(차액)</label>
                        </td>
                        <td colspan="3" class="text-right">
                            <input type="text" class="form-control text-right" id="provd_amt" name="provd_amt" readonly>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 항목 END -->
    ') || TO_CLOB('
    <!-- 비고 START -->
    <div class="col-lg-12 form-group">
        <div class="col-lg-2 col-sm-2 text-right">
            <label class="control-label">비고<br>
            (계좌번호)</label>
        </div>
        <div class="col-lg-9">
            <textarea class="form-control" name="bztrp_rmrk" id="bztrp_rmrk"></textarea>
        </div>
    </div>
    <!-- 비고 END -->'),
    '<h1>출 장 정 산 서(국내)</h1>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">부서명/직위</td>
                <td colspan="3" class="td-comm td-s3" id="emp_dp_rank"></td>
                <td colspan="2" class="td-comm td-s2 td-header">성명</td>
                <td colspan="3" class="td-comm td-s3" id="emp_nm"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">출장구분</td>
                <td colspan="8" class="td-comm td-s8" id="bztrp_div"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">출장목적</td>
                <td colspan="8" class="td-comm td-s8" id="bztrp_purp"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">출장기간</td>
                <td colspan="8" class="td-comm td-s8" id="term"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">출장자</td>
                <td colspan="3" class="td-comm td-s3" id="bztrp_per"></td>
                <td colspan="2" class="td-comm td-s2 td-header">장소</td>
                <td colspan="3" class="td-comm td-s3" id="bztrp_plc"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">출발지역</td>
                <td colspan="3" class="td-comm td-s3" id="dpar_area"></td>
                <td colspan="2" class="td-comm td-s2 td-header">도착지역</td>
                <td colspan="3" class="td-comm td-s3" id="aryl_area"></td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 td-header">비고</td>
                <td colspan="8" class="td-comm td-s8" id="bztrp_rmrk"></td>
            </tr>
        </tbody>
    </table>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr id="tr_items">
                <td colspan="1" class="td-comm td-s1 td-header">항목</td>
                <td colspan="5" class="td-comm td-s5 td-header">내역</td>
                <td colspan="2" class="td-comm td-s2 td-header">금액</td>
                <td colspan="2" class="td-comm td-s2 td-header">비고</td>
            </tr>
            <tr>
                <td colspan="6" class="td-comm td-s6 td-header">합계</td>
                <td colspan="4" class="td-comm td-s4 text-right" id="bztrp_item_sum"></td>
            </tr>
        </tbody>
    </table>
    <table class="table table-bordered" style="border: 2px solid black;">
        <tbody>
            <tr>
                <td rowspan="2" colspan="2" class="td-comm td-s2 td-header">정산</td>
                <td colspan="2" class="td-comm td-s2 td-header">전도금</td>
                <td colspan="2" class="td-comm td-s2 td-header">기업카드사용금액</td>
                <td colspan="4" class="td-comm td-s4 td-header">지급액(차액)</td>
            </tr>
            <tr>
                <td colspan="2" class="td-comm td-s2 text-right" id="plnd_amt"></td>
                <td colspan="2" class="td-comm td-s2 text-right" id="corp_crd_use_amt"></td>
                <td colspan="4" class="td-comm td-s4 text-right" id="provd_amt"></td>
            </tr>
        </tbody>
    </table>
    <div id="fileList"></div>
    <div id="footer" class="text-center">
        <br>
        <h4>위와 같은 사유로 정산을 신청합니다.<h4>
        <br>
        <h4 id="crtn_dt"><h4>
    </div>',
    SYSDATE,
    'admin01',
    SYSDATE,
    'admin01'
);





-- 경영지원실
-- jmkim(김정민 선배님)
INSERT INTO STD_APRV_LINE_INFO VALUES('jmkim', '1', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('jmkim', '2', 'N', 'pilbyun');
-- sjpark(박상준 차장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('sjpark', '1', 'N', 'pilbyun');
INSERT INTO STD_APRV_LINE_INFO VALUES('sjpark', '2', 'Y', 'jmkim');
-- yjs5204(윤진석 부장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('yjs5204', '1', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('yjs5204', '2', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('yjs5204', '3', 'N', 'pilbyun');

-- 행안부
-- jwchoi(최정원 수석님)
INSERT INTO STD_APRV_LINE_INFO VALUES('jwchoi', '1', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('jwchoi', '2', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('jwchoi', '3', 'N', 'pilbyun');
-- minjeong(민정 수석님)
INSERT INTO STD_APRV_LINE_INFO VALUES('minjeong', '1', 'N', 'jwchoi');
INSERT INTO STD_APRV_LINE_INFO VALUES('minjeong', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('minjeong', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('minjeong', '4', 'N', 'pilbyun');
-- kte(김태은 과장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('kte', '1', 'N', 'jwchoi');
INSERT INTO STD_APRV_LINE_INFO VALUES('kte', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('kte', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('kte', '4', 'N', 'pilbyun');
-- jydev(김지연 주임님)
INSERT INTO STD_APRV_LINE_INFO VALUES('jydev', '1', 'N', 'jwchoi');
INSERT INTO STD_APRV_LINE_INFO VALUES('jydev', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('jydev', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('jydev', '4', 'N', 'pilbyun');
-- pojyd052(이진희 선배님)
INSERT INTO STD_APRV_LINE_INFO VALUES('pojyd052', '1', 'N', 'jwchoi');
INSERT INTO STD_APRV_LINE_INFO VALUES('pojyd052', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('pojyd052', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('pojyd052', '4', 'N', 'pilbyun');
-- msjo(나)
INSERT INTO STD_APRV_LINE_INFO VALUES('msjo', '1', 'N', 'jwchoi');
INSERT INTO STD_APRV_LINE_INFO VALUES('msjo', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('msjo', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('msjo', '4', 'N', 'pilbyun');

-- 한전
-- citywork(전재완 부장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('citywork', '1', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('citywork', '2', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('citywork', '3', 'N', 'pilbyun');
-- shy(유석현 차장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('shy', '1', 'N', 'citywork');
INSERT INTO STD_APRV_LINE_INFO VALUES('shy', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('shy', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('shy', '4', 'N', 'pilbyun');

-- KGC
-- hakseungkim(김학승 부장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('hakseungkim', '1', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('hakseungkim', '2', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('hakseungkim', '3', 'N', 'pilbyun');
-- welty(조수원 차장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('welty', '1', 'N', 'hakseungkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('welty', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('welty', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('welty', '4', 'N', 'pilbyun');
-- a4602(배정섭 차장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('a4602', '1', 'N', 'hakseungkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('a4602', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('a4602', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('a4602', '4', 'N', 'pilbyun');
-- yty(유태영 과장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('yty', '1', 'N', 'hakseungkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('yty', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('yty', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('yty', '4', 'N', 'pilbyun');
-- sano(김장호 과장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('sano', '1', 'N', 'hakseungkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('sano', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('sano', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('sano', '4', 'N', 'pilbyun');
-- lsh78(이상호 과장님)
INSERT INTO STD_APRV_LINE_INFO VALUES('lsh78', '1', 'N', 'hakseungkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('lsh78', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('lsh78', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('lsh78', '4', 'N', 'pilbyun');
-- gefo1(김중원 대리님)
INSERT INTO STD_APRV_LINE_INFO VALUES('gefo1', '1', 'N', 'hakseungkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('gefo1', '2', 'N', 'jmkim');
INSERT INTO STD_APRV_LINE_INFO VALUES('gefo1', '3', 'N', 'sjpark');
INSERT INTO STD_APRV_LINE_INFO VALUES('gefo1', '4', 'N', 'pilbyun');