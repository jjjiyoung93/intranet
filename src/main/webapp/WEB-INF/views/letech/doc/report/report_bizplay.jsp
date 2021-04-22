<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>

<h1>보 고 서</h1>
<div>
<h1 id="mainTitle" style="margin-top: 0px;">
지출결의서(
	                  	                  
	<span id="cardType">카드 타입 </span>
)   
</h1>
</div>

<div class="clearfix">
        <div id="myDIV" style="display:block;">
         	<div class="recCommData">
	            <div style="margin-top:2%; margin-bottom:2%;">
	               <span id="docNo"></span>
	            </div> 
		         <div class="table-responsive">
		            <table class="table table-bordered">
		               <thead class="table_s">
		                  <tr>
		                     <td class="table_menu td-header" style="width:100px;">발의자</td>
		                     <td id="reptAprvEmp"></td>
		                  </tr>
		                  <tr>
	                        <td class="table_menu td-header" style="width:100px;">발의일자</td>
	                        <td id="draftDate">
	                        </td>
		                 </tr>
		                 <tr>
	                        <td class="table_menu td-header" style="width:100px;">제목</td>
	                        <td id="title"></td>
		                 </tr>
		                 <tr>
		                     <td class="table_menu td-header" style="width:100px;">내용</td>
		                     <td id="reptCont"></td>
		                 </tr>
		                 <tr class="no-print-page">
		                     <td class="table_menu td-header" style="width:100px;">첨부파일</td>
		                     <td id="fileList"></td>
		                 </tr>
		                 		                 
		               </thead>
		            </table>
		         </div>
<!-- 	             	<div id="fileList"> -->
                    
<!--                     </div> -->
		         
	             <div style="margin-top:2%;">
                     <span>ㆍ</span>&nbsp;
                     <span>총 </span>&nbsp;
                     <span id = "recListSize"></span>
                     <span>건 </span>&nbsp;
                     <span id="sumAmt" class="amt">
                     </span>
			    </div>
	       </div>
	       
	       <div class="recView">              
                <div class="row" style="margin: 0 0 2% 2%;">
                  <hr>
                  <div>
	                  <div class="" style="width: 55%; vertical-align:top; display: inline-block;">
		                  	<div style="border: 1px solid lightgray; height:50%; padding:10%; background:#F5F5F5 !important;">
		                     <div>
		                        <ul style="list-style-type: none; padding: 0 0 0 0;">
		                           <li style="letter-spacing: 0px;">
		                           	  <span class="apvDt"></span>
		                           	  <span class="apvTm"></span>
		                           	  
		                              <span class="mestType" style="border:1px solid lightgray; padding:1%;"></span>
		                           	  
		                           </li>
		                           <li style="letter-spacing: 0px; font-size: medium; font-weight: bold;"><span class="mestNm"><%-- ${recList.MEST_NM} --%></span></li>
		                           <li style="letter-spacing: 0px;">
		                           		<span class="buyInfo"></span>
		                           </li>
		                        </ul>
		                     </div>
		                     <div style="float: right; margin_bottom: 0;">
		                        <strong style="letter-spacing: 0px; font-size: large;">
		                          <span class="buySum amt">
		                          </span>
		                        </strong>
		                     </div>
		                  </div>
	
		                  <div style="border: 1px solid lightgray; height:100%; padding:10%; background:#F0F8FF !important;">
		<%--                                                          <span style="background:url('${pageContext.request.contextPath}/resources/images/layout/bg_cardbill.gif'); "></span> --%>
		                     <table>
		                     	<colgroup>
		                     		<col style="width:40%;"></col>
		                     		<col style="width:60%;"></col>
		                     	</colgroup>
		                        <tbody style="margin:0% 10% 0% 10%;">
		<!--                                                       <tr style="width:100%;"> -->
		                           
		<!--                                                       </tr> -->
		                           <tr>
		                              <th class="recipt reciptInfoHeader">카드정보</th>
		                              <td style="padding-bottom:0">
		                                 <span class="cardInfo">
		                                 </span>
		                              </td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">거래일시</th>
		                              <td style="padding-bottom:0;">
		                               <span class="reciptApvDt">
		                              </span>
		                              <span class="reciptApvTm"></span>
		                              </td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">승인번호</th>
		                              <td style="padding-bottom:0;"><span class="apvNo"></span></td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">공급금액</th>
		                              <td style="padding-bottom:0;"><span class="splyAmt amt"></span></td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">부가세</th>
		                              <td style="padding-bottom:0;"><span class="vatAmt amt"></span></td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">봉사료</th>
		                              <td style="padding-bottom:0;"><span class="srvFee amt"></span></td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">가맹점/대표자</th>
		                              <td style="padding-bottom:0;"><span class="mest"></span></td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">가맹점업종</th>
		                              <td style="padding-bottom:0;"><span class="cardTpbzNm"></span></td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">가맹점주소</th>
		                              <td style="padding-bottom:0;"><span class="mestAddr"></span></td>
		                           </tr>
		                           <tr>
		                              <th class="recipt reciptInfoHeader">사업자등록번호</th>
		                              <td style="padding-bottom:0;"><span class="mestBizNo"></span></td>
		                           </tr>
		                        </tbody>
		                     </table>
		                  </div>
	               </div>
	               
	               <div class="" style="width:40%; display:inline-table; vertical-align:top; margin-left:10px; padding: 0 0 0 0;">
	                  <table>
	                  		<colgroup>
	                  			<col width="25%"></col>
	                  			<col width="75%"></col>
	                  		</colgroup>
	                     <tbody>
	                        <tr>
	                           <th class="recipt" style="letter-spacing:0px; padding-bottom:0px;">구분</th>
	                           <td style="padding-bottom:0px;">
	                              <span class="tranKindNm"></span>
	                           <td>
	                        </tr>
	                        <tr>
	                           <th class="recipt" style="letter-spacing:0px; padding-bottom:0px;">분류</th>
	                           <td style="padding-bottom:0px;">
	                              <span class="summary"></span>
	                           <td>
	                        </tr>
	                        <tr>
	                           <th class="recipt" style="letter-spacing:0px; padding-bottom:0px;">상세내용</th>
	                           <td style="padding-bottom:0px;">
	                              <span class="summary2"></span>
	                           <td>
	                        </tr>
	                        <tr>
	                           <th class="recipt" style="letter-spacing:0px; padding-bottom:0px;">신청금액</th>
	                           <td style="padding-bottom:0px;">
	                              <span class="aprAmt amt">
	                              </span>
	                           <td>
	                        </tr>
	                        <tr>
	                           <th class="recipt" style="letter-spacing:0px; padding-bottom:0px;">프로젝트</th>
	                           <td style="padding-bottom:0px;">
	                              <span class="bizUnitNm"></span>
	                           <td>
	                        </tr>
	                         <tr class="summary3-tr" style="display:none;">
	                            <th class="recipt" style="letter-spacing:0px; padding-bottom:0px;">계좌정보</th>
	                            <td style="padding-bottom:0px;">
	                               <span class="summary3"></span>
	                            <td>
	                         </tr>
	                     </tbody>
	                  </table>
	               </div>
               </div>
<!--             <hr> -->
         </div>
        </div>
      		            
      </div>   
<!--    </dl> -->
<%--                               <span style="background:url('${pageContext.request.contextPath}/resources/images/layout/bg_cardbill.gif'); "></span> --%>
</div>