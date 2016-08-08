$(document).ready(function(){

	//кнопка выйти
	$('#login_panel').delegate('#logout', 'click', function(){
		parameters = {};
		parameters['method'] = 'logout';
		makeAjax(parameters);
	});

	//кнопка войти
	$('.content').delegate('#login_button', 'click', function(){
		username = $(this).parent().find('#username').val();
		password = $(this).parent().find('#password').val();
		if (username == ''){
			header = 'ошибка пользователя';
			text = 'пустое поле имя пользователя'
			makeNotification('alert', header, text);
		} else if (password == ''){
			header = 'ошибка пользователя';
			text = 'пустое поле пароль';
			makeNotification('alert', header, text);
		} else {
			parameters = {};
			parameters['method'] = 'trylogin';
			parameters['username'] = username;
			parameters['password'] = password;
			makeAjax(parameters);
		}
	});

	//таймер notification
	var timerid = setInterval(notificationCron, 1000)

	function notificationCron(){
		$.each($('.notification_unit'), function(){
			a = parseInt($(this).attr('data-id'));
			if (a == 5){
				$(this).fadeOut(400)
			} else if(a == 7){
				$(this).remove();
			}
			$(this).attr('data-id', a+1);
		});
	}

	//страница войти
	$('#login_panel').delegate('#login', 'click', function(){
		login();
	});

	//кнопка отправиться на предыдущую страницу
	$('#goto_previous').on('click', function(){
		gotoPrevious();
	})

	//кнопка заголовок сайта, отправиться на главную страницу
	$('#mainpage').on('click', function(){
		loadingIndex();
	});

	$('#paragraph_content').foundation('open');

	//отобразить содержимое paragraph
	$('.content').delegate('.a_paragraph_item', 'click', function(){
		$('#paragraph_content').foundation('open');
	});

	//наведение мыши на paragraph
	var par_pos = 140;
	$('.content').delegate('.a_paragraph_item', 'mouseenter', function(){
		a = $(this).find('#paragraph_name');
		a.animate({top: par_pos+25}, 200);
		a.delay(100).animate({top: 100}, 200);
	});

	$('.content').delegate('.a_paragraph_item', 'mouseleave', function(){
		a = $(this).find('#paragraph_name');
		a.animate({top: par_pos}, 200);
	})

	//отображаем страничку loadingindex
	updatePreviousCurrent('loadingindex');
	loadingOpen();
	parameters = {};
	parameters['method'] = 'loadingindex';
	makeAjax(parameters);

	//если загрузился background
	$('#backgroundimage').imagesLoaded( function() {
		loadingClose();
  		$('#backgroundimage').fadeIn(400);
  		$('#page_head').show(400);
	});


});

var makeNotification = function(type, header, text){
	parameters = {};
	parameters['method'] = 'notification';
	parameters['type'] = type;
	parameters['header'] = header;
	parameters['text'] = text;
	makeAjax(parameters);
}

//загрузить страничку login
var login = function(){
	//текущая страница как как предидущая
	updatePreviousCurrent('login');
	//обновляем кнопку предидущая страница
	updateGoToPrevious()
	$('#maincontent').hide(400);
	loadingOpen();
	parameters['method'] = 'login';
	makeAjax(parameters);	
}

//загрузить страничку loadingindex
var loadingIndex = function(){
	//текущая страница как как предидущая
	updatePreviousCurrent('loadingindex');
	//обновляем кнопку предидущая страница
	updateGoToPrevious()
	loadingOpen();
	parameters = {};
	parameters['method'] = 'loadingindex';
	makeAjax(parameters);
}

var updatePreviousCurrent = function(pageName){
	$('#previous_page').html($('#current_page').html());
	$('#current_page').html(pageName);
}


var loadingOpen = function(){
	$('#loading').foundation('open');
	$('.progress-meter').animate({width:"100%"}, 2000);
}

var loadingClose = function(){
	$('#loading').foundation('close');
	$('.progress-meter').css({width:0});
}

var makeAjax = function(parameters){
	loadingOpen();
	$.ajax({
    	type: "POST",
    	url: "/",
    	data: JSON.stringify(parameters),
    	contentType: "application/json; charset=utf-8",
    	dataType: "json",
    	async: true,
    	success: function(data, textStatus, jqXHR){
    		//если основная страница
    		if (parameters['method'] == 'loadingindex'){
    			$('.content').html(data['string']);
    			//загружаем index maincontent
				var no = 0;
		  		$.each($('.paragraph'), function(i){
					$(this).imagesLoaded(function(){
						no += 1;
						if (no == $('.paragraph').length){
							$('#maincontent').delay(300).show(400);
							loadingClose();
						}
					})
				});
			//если login страница
    		} else if (parameters['method'] == 'login'){
    			$('#maincontent').html(data['string']);
    			loadingClose();
    			$('#maincontent').show(400);
    		// если notification
    		} else if (parameters['method'] == 'notification'){
    			loadingClose();
    			$('#notification_panel').append(data['string']);
			// если trylogin
    		} else if (parameters['method'] == 'trylogin'){
    			loadingClose();
    			if ('login_panel' in data){
    				$('#login_panel').html(data['login_panel']);
    				header = 'уведомление';
    				text = 'выполнен вход';
    				makeNotification('success', header, text);
    				gotoPrevious();
    			} else {
    				header = 'ошибка пользователя';
    				text = 'некорректное имя пользователя и пароль';
    				makeNotification('alert', header, text);
    			}
    		// если logout
    		} else if (parameters['method'] == 'logout'){
    			loadingClose();
    			$('#login_panel').html(data['login_panel']);
    			header = 'уведомление';
    			text = 'выполнен выход пользователя';
    			makeNotification('success', header, text);
    		}
    	}
	});
}

function updateGoToPrevious(){
	if ($('#goto_previous:hidden')){
		$('#goto_previous').show(400);
	}
}

gotoPrevious = function(){
	if ($('#previous_page').html() == 'loadingindex'){
		loadingIndex();
	} else if ($('#previous_page').html() == 'login'){
		login();
	}	
}