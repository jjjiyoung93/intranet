document.domain = document.location.hostname.slice(document.location.hostname.lastIndexOf('.', document.location.hostname.lastIndexOf('.')-1) + 1);

function resize_frame(target,min_width,min_height)
{
  var o_body = document.frames(target).document.body;
  var o_frame = document.all(target);
  var t_height = o_body.scrollHeight + (o_body.offsetHeight - o_body.clientHeight);
  var t_width = o_body.scrollWidth + (o_body.offsetWidth - o_body.clientWidth);

  if(t_height < min_height)
    t_height = min_height;
  
  if(t_width < min_width)
    t_width = min_width;

  o_frame.style.height = t_height;
  o_frame.style.width = t_width;
} 

function resize_contents(frame)
{
  if (parent.resize_frame != "undefined")
  {
    parent.resize_frame('"+frame+"');
    setTimeout("parent.resize_frame('"+frame+"')", 1500);
  }
}

//------------- Content fix -------------//
contentFix = function (sidebar, content) {
	sidebarH = $(sidebar).height();
	$(content).css('min-height',sidebarH);
 	contentH = $(content).height();
 	contentH = contentH + 45;
 	if(sidebarH>contentH) {
 		if($('div').hasClass('calFix')) {
 			//do noting
 		} else {
			$(content).css('height',sidebarH);
		}
	}
}


// document ready function
$(document).ready(function() {
	
	//logo rotation
	$(".logo img").rotate({ 
	   bind: 
	     { 
	        mouseover : function() { 
	            $(this).rotate({animateTo:360})
	        },
	        mouseout : function() { 
	            $(this).rotate({animateTo:0})
	        }
	     } 
	});

	//------------- Globals -------------//

	var divElement = $('div'); //log all div elements
	
	//------------- Footer fix -----------//

	contentFix('#sidebar', '#mainContent');

	//------------- Top Search button -------------//

	$('.tSearch .button').click(function(event) {
		event.preventDefault();
		tForm = $('.tSearch form');
		if (tForm.css('display') == 'none') {
			tForm.show();
		} else {
			tForm.hide();
		}
	});

	//------------- Navigation -------------//
	var mainNav = $('ul.mainnav li');

	mainNav.find('ul').siblings().not('a.iLogout').addClass('hasUl')
	//find if has class current make icon dark
	mainNav.find('a.current>span.icon').not('a.iLogout').addClass('dark');
	//click magic
	mainNav.find('a').not('a.iLogout').click(function(event) {
		$this = $(this);
			
		if($this.hasClass('hasUl')) {
			event.preventDefault();
			if($this.hasClass('drop')) {
				$(this).siblings('ul.sub').slideUp(300).siblings().not('a.iLogout').removeClass('drop');
				$('a.hasUl>em').removeClass('icon_minus').addClass('icon_plus');
			} else {
				$(this).siblings('ul.sub').slideDown(200).siblings().not('a.iLogout').addClass('drop');				
				$('a.drop>em').removeClass('icon_plus').addClass('icon_minus');
			}			
		}	
	});

	//responsive navigation
	$('ul.mainnav>li.iMenu>a').click(function(event) {
		$thisOne = $(this);
		if ($thisOne.closest('li').hasClass('show')) {
			$thisOne.closest('li').removeClass('show');
			$('ul.mainnav>li').not('ul.mainnav>li.iMenu').css('display', 'none');
		}else{
			$thisOne.closest('li').addClass('show');
			$('ul.mainnav>li').css('display', 'inline-block');
		}
	});

	//-------------Top notification area --------//

	var topNav = $('ul.topNav li');
	topNav.find('ul').siblings().addClass('hasUl');
	topNav.find('ul>li>a').last('a').addClass('lastest');

	topNav.find('a').mouseover(function(event) {
		var $this = $(this);
		$this.find('span.notification').addClass('read'); //remove notification after read
		if($this.hasClass('hasUl')) {
			event.preventDefault();
			if($this.hasClass('drop')) {
				/*$(this).siblings('ul.sub').fadeOut(300).siblings().removeClass('drop');*/
				$(this).siblings('ul.sub').slideUp(300).siblings().removeClass('drop');
			} else {
				/*$(this).siblings('ul.sub').fadeIn(200).siblings().addClass('drop');*/
				$(this).siblings('ul.sub').slideDown(300).siblings().addClass('drop');
			}
		}
		$(this).parent().hover(function() {}
			, function(){
				/*$(this).find("ul.sub").fadeOut(200);*/
				$(this).find("ul.sub").slideUp(200);
				$(this).find('a') .removeClass("drop");
		});		

	});
	
	$('#YELLOW').click(function(event) {
			$('body.mainPage') .removeClass().addClass('mainPage');
			$('body.loginPage') .removeClass().addClass('loginPage');
	});
	$('#BLUE').click(function(event) {
			$('body.mainPage') .removeClass().addClass('mainPage colorBlue');
			$('body.loginPage') .removeClass().addClass('loginPage colorBlue');
	});
	$('#RED').click(function(event) {
			$('body.mainPage') .removeClass().addClass('mainPage colorRed');
			$('body.loginPage') .removeClass().addClass('loginPage colorRed');
	});
	$('#PINK').click(function(event) {
			$('body.mainPage') .removeClass().addClass('mainPage colorPink');
			$('body.loginPage') .removeClass().addClass('loginPage colorPink');
	});
	$('#SKYBLUE').click(function(event) {
			$('body.mainPage') .removeClass().addClass('mainPage colorSkyBlue');
			$('body.loginPage') .removeClass().addClass('loginPage colorSkyBlue');
	});
	$('#GREEN').click(function(event) {
			$('body.mainPage') .removeClass().addClass('mainPage colorGreen');
			$('body.loginPage') .removeClass().addClass('loginPage colorGreen');
	});

});


var inputText = {};	
inputText.placeHolders = function() {
 $(':input[placeholder]').each(function() {
	var $this = $(this);
	if($this.val() === '') {
	 $this.val($this.attr('placeholder'));
	}
	$this.focus(function() {
	 if($this.val() === $this.attr('placeholder')) {
		 $this.val('');
	 }
	});
	$this.blur(function() {
	 if($this.val() === '') {
		 $this.val($this.attr('placeholder'));
	 }
	});
 }); 
};
