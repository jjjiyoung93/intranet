//jquery js를 선호출후 호출할것

/**
 * ajax 등록 url
 * @param tUrl :타겟url
 * @param tType :전송 방식GET,POST(대문자로할것)
 * @param anc :async 방식
 * @param rUrl :이동url
 */
function jsFnReg(tUrl,tType,rUrl,anc)
{
	var formData = $("#form1").serialize();
	$.ajax({
        url : tUrl,
        type: tType,
        data : formData,
        dataType : 'json',
        async : anc,
        success : function(json){
			alert(json.msg);
			location.href = rUrl;
        },
		error: function (request, status, error) { 
			alert("입력중 에러 발생 브라우저를 재시작 후에 시도해 주세요"); 
		}
    });
}

/**
 * ajax 수정 url
 * @param tUrl :타겟url
 * @param tType :전송 방식GET,POST(대문자로할것)
 * @param anc :async 방식
 * @param rUrl :이동url
 */
function jsFnUpdate(tUrl,tType,rUrl,anc)
{
	if(confirm("수정하시겠습니까?")){
		var formData = $("#form1").serialize();
		$.ajax({
			url : tUrl,
			type: tType,
			data : formData,
			dataType : 'json',
			async : anc,
			success : function(json){
				alert(json.msg);
				location.href = rUrl;
			},
			error: function (request, status, error) { 
				alert("수정중 에러 발생 브라우저를 재시작 후에 시도해 주세요"); 
			}
		});
	}
}

/**
 * ajax 삭제 url
 * @param tUrl :타겟url
 * @param tType :전송 방식GET,POST(대문자로할것)
 * @param anc :async 방식
 * @param rUrl :이동url
 */
function jsFnDelete(tUrl,tType,rUrl,anc)
{
	if(confirm("삭제하시겠습니까?")){
		var formData = $("#form1").serialize();
		$.ajax({
			url : tUrl,
			type: tType,
			data : formData,
			dataType : 'json',
			async : anc,
			success : function(json){
				alert(json.msg);
				location.href = rUrl;
			},
			error: function (request, status, error) { 
				alert("삭제중 에러 발생 브라우저를 재시작 후에 시도해 주세요"); 
			}
		});
	}
}




