$(document).ready(function(){
	var par_id;
	var unit_id;
	var keyword;
	
	//если заметка (paragraph unit article), показываем её
	if (typeof art != 'undefined'){
		$('#paragraph_content').foundation('open');	
	}

	//history история
	History.Adapter.bind(window, 'statechange', function(){
		var State = History.getState();
		window.location = State.hashedUrl;
	});

	//удалить модерированную заявку
	$('.content').delegate('#delete_moderated', 'click', function(){
		loadingOpen();
		$('#maincontent').hide(400);
		parameters = {};
		parameters['type'] = $(this).attr('data-type');
		parameters['ordermoderated_id'] = parseInt($(this).attr('data-id'));
		parameters['method'] = 'delete_moderated';
		makeAjax(parameters);
	});

	//удалить заявку
	$('.content').delegate('#delete', 'click', function(){
		loadingOpen();
		$('#maincontent').hide(400);
		parameters = {};
		parameters['type'] = $(this).attr('data-type');
		parameters['order_id'] = parseInt($(this).attr('data-id'));
		parameters['method'] = 'delete';
		makeAjax(parameters);
	});


	//отправить модерирование заявки
	$('.content').delegate('#submit_moderate', 'click', function(){
		parameters = {};
		if ($(this).attr('data-type') == 'order_moderate'){
			loadingOpen();
			$('#maincontent').hide(400);
			parameters['type'] = 'order_moderate';
			parameters['order_id'] = parseInt($(this).attr('data-id'));
			parameters['customer_id'] = parseInt($('#customer option:selected')[0].value);
			parameters['customer_name'] = $('#customer_name').val();
			parameters['quantity'] = parseInt($('#quantity').val());
			parameters['delivery_date'] = $('#delivery_date').val();
			parameters['text'] = $('#text').val();
			parameters['method'] = 'submit_moderate';
			makeAjax(parameters);
		} else if ($(this).attr('data-type') == 'transport_order_moderate'){
			loadingOpen();
			$('#maincontent').hide(400);
			parameters['type'] =  'transport_order_moderate';
			parameters['order_id'] = parseInt($(this).attr('data-id'));
			parameters['customer_id'] = parseInt($('#customer option:selected')[0].value);
			parameters['customer_name'] = $('#customer_name').val();
			parameters['from'] = $('#from').val();
			parameters['to'] = $('#to').val();
			parameters['volume'] = parseInt($('#volume').val());
			parameters['delivery_date'] = $('#delivery_date').val();
			parameters['text'] = $('#text').val();
			parameters['method'] = 'submit_moderate';
			makeAjax(parameters);
		} else if ($(this).attr('data-type') == 'getintouch_moderate'){
			loadingOpen();
			$('#maincontent').hide(400);
			parameters['type'] = 'getintouch_moderate';
			parameters['getintouch_id'] = parseInt($(this).attr('data-id'));
			parameters['customer_id'] = parseInt($('#customer option:selected')[0].value);
			parameters['customer_name'] = $('#customer_name').val();
			parameters['unit'] = parseInt($('#unit option:selected')[0].value);
			parameters['quantity'] = parseInt($('#quantity').val());
			parameters['delivery_date'] = $('#delivery_date').val();
			parameters['text'] = $('#text').val();
			parameters['method'] = 'submit_moderate';
			makeAjax(parameters);
		}
	});

	//модерирование заявок и предложений
	$('.content').delegate('#moderate', 'click', function(){
		parameters = {};
		parameters['order_type'] = $(this).attr('data-type');
		parameters['id'] = parseInt($(this).attr('data-id'));
		parameters['method'] = 'moderate_form';
		makeAjax(parameters);
	});

	//поле поиск при набора
	$('.content').delegate('#keyword', 'keyup', function(){
		parameters = {};
		parameters['method'] = 'searchkeyup';
		parameters['word'] = $(this).val();
		makeAjax(parameters);
	});

	//посмотреть статью
	$('.content').delegate('#article', 'click', function(){
		parameters = {};
		parameters['paragraph_id'] = parseInt($(this).attr('data-paragraph'));
		parameters['unit_id'] = parseInt($(this).attr('data-unit'));
		parameters['keyword_id'] = parseInt($(this).attr('data-keyword'));
		parameters['article_id'] = parseInt($(this).attr('data-article'));
		history.pushState({state:7}, 'article', '/paragraph/'+parameters['paragraph_id']+'/unit/'+parameters['unit_id']+'/article/'+parameters['article_id']);
		parameters['method'] = 'get_article';
		makeAjax(parameters);
	});

	//клик на unit
	//переход на удовлетворяющий критерю unit
	$('.content').delegate('#item_unit a', 'click', function(){
		par_id = $(this).attr('data-paragraph');
		unit_id = $(this).attr('data-unit');
		console.log(par_id);
		console.log(unit_id);
		history.pushState({state:2}, 'paragraph_unit', '/paragraph/'+par_id+'/unit/'+unit_id);
		$('#paragraph_id').attr('data-id', par_id);
		$('#unit_id').attr('data-id', unit_id);
	});

	//клик на schema
	$('#schema').on('click', function(){
		parameters = {};
		parameters['method'] = 'schema';
		makeAjax(parameters);		
	});



	a = History.getState();
	//если разлинковка = пусто, страница index
	if (a.hash == "/"){
		/*loadingIndex();*/
	//если разлинковка = search, страница search
	} else if (a.hash == '/search/'){
		/*search();*/
	//если разлинковка = login, страница login
	} else if (a.hash == "/login/") {
		/*login();*/
	//если разлинковка = orders, страница orders
	} else if (a.hash == "/orders/") {
		/*orders();*/
	//если разлинковка = contacts, страница contacts
	} else if (a.hash == "/contacts") {
		/*contacts();*/
	//eсли разлинковка = order_moderated, страница модерирование заказов
	} else if (a.hash == '/order_moderated/'){
		/*order_moderated();*/
	}

	
	/*loadingClose();*/
	var id;
	//кнопка отправить пожелание и предложение
	$('.content').delegate('#submit_getintouch', 'click', function(){
		name = $('#name').val();
		telephone = $('#telephone').val();
		text = $('#text').val();
		email = $('#e-mail').val();
		error = 0;
		//если пустое поле name
		if (name == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле имя';
			makeNotification('alert', header, text);
			error = 1;
		}
		//если пустое поле телефон
		if (telephone == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле телефон';
			makeNotification('alert', header, text)
			error = 1;
		} else if (jQuery.isNumeric(telephone) == false){
			header = 'ошибка пользователя';
			text = 'некорректный номер телефона';
			makeNotification('alert', header, text);
			error = 1;
		}
		//если пустое поле text
		if (text == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле текст пожелания и предложения';
			makeNotification('alert', header, text);
			error = 1;
		}
		$('#telephone').val('');
		$('#name').val('');
		$('#text').val('');
		$('#e-mail').val('');
		if (error == 0){
			/*loadingOpen();*/
			parameters = {};
			parameters['method'] = 'getintouch';
			parameters['name'] = name;
			parameters['telephone'] = telephone;
			parameters['email'] = email;
			parameters['text'] = text;
			makeAjax(parameters);
		}
	});
	//кнопка отправить заявку на транспорт
	$('#paragraph_content').delegate('#submit_transport_order', 'click', function(){
		name = $('#name').val();
		telephone = $('#telephone').val();
		from = $('#from').val();
		to = $('#to').val();
		volume = parseInt($('#volume').val());
		email = $('#email').val();
		text = $('#text').val();
		watsup = 0;
		if ($('input#telmethod')[0].checked == true){
			watsup = 0;
		} else if ($('input#watsupmethod')[0].checked == true){
			watsup = 1;
		}
		error = 0;
		//если пустое поле объем груза
		if (volume == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле объем груза';
			makeNotification('alert', header, text);
			error = 1;
		}
		//если пустое поле место назначения
		if (to == 0){
			header = 'ошибка  пользователя';
			text = 'пустое поле место назначения';
			makeNotification('alert', header, text);
			error = 1;
		}
		//если пустое поле место отправки
		if (from == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле место отправки';
			makeNotification('alert', header, text);
			error = 1;
		}
		//если пустое поле name
		if (name == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле имя';
			makeNotification('alert', header, text);
			error = 1;
		}

		//если пустое поле телефон
		if (telephone == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле телефон';
			makeNotification('alert', header, text)
			error = 1;
		} else if (jQuery.isNumeric(telephone) == false){
			header = 'ошибка пользователя';
			text = 'некорректный номер телефона';
			makeNotification('alert', header, text);
			error = 1;
		}
		if (error == 0){
			/*loadingOpen();*/
			parameters = {};
			parameters['method'] = 'submit_transport_order';
			parameters['name'] = name;
			parameters['telephone'] = telephone;
			parameters['watsup'] = watsup;
			parameters['from'] = from;
			parameters['to'] = to;
			parameters['volume'] = volume;
			parameters['text'] = text;
			parameters['email'] = email;
			parameters['unit_id'] = parseInt($(this).attr('data-id'));
			makeAjax(parameters);
		}
	});


	//кнопка отправить заявку
	$('#paragraph_content').delegate('#submit_order', 'click', function(){
		name = $('#name').val();
		telephone = $('#telephone').val();
		text = $('#text').val();
		email = $('#email').val();
		watsup = 0;
		if ($('input#telmethod')[0].checked == true){
			watsup = 0;
		} else if ($('input#watsupmethod')[0].checked == true ){
			watsup = 1;
		}
		error = 0;
		//если пустое поле name
		if (name == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле имя';
			makeNotification('alert', header, text);
			error = 1;
		}

		//если пустое поле телефон
		if (telephone == 0){
			header = 'ошибка пользователя';
			text = 'пустое поле телефон';
			makeNotification('alert', header, text)
			error = 1;
		} else if (jQuery.isNumeric(telephone) == false){
			header = 'ошибка пользователя';
			text = 'некорректный номер телефона';
			makeNotification('alert', header, text);
			error = 1;
		}
		if (error == 0){
			/*loadingOpen();*/
			parameters = {};
			parameters['method'] = 'submit_order';
			parameters['name'] = name;
			parameters['telephone'] = telephone;
			parameters['text'] = text;
			parameters['watsup'] = watsup;
			parameters['email'] = email;
			parameters['unit_id'] = parseInt($(this).attr('data-id'));
			makeAjax(parameters);
		}
	});

	//оставить заявку
	$('.content').delegate('#makeorder', 'click', function(){
		data_transport = $(this).attr('data-transport');
		//обычная форма
		if (data_transport == 'None'){
			parameters = {}
			parameters['unit_id'] = parseInt($(this).attr('data-id'));
			parameters['method'] = 'showorderform';
			makeAjax(parameters);	
		} else if (data_transport == 'True'){
			parameters = {};
			parameters['unit_id'] = parseInt($(this).attr('data-id'));
			parameters['method'] = 'showtransportform';
			makeAjax(parameters);
		}
	});

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
			loadingOpen();
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
	//страница поиска
	$('#search').on('click', function(){
		loadingOpen();
		/*search();*/
	});

	//страница контакты
	$('#contact').on('click', function(){
		loadingOpen();
		/*contacts();*/
	})

	//страница заказов
	$('#login_panel').delegate('#orders', 'click', function(){
		loadingOpen();
		/*orders();*/
	});

	//страница войти
	$('#login_panel').delegate('#logbut', 'click', function(){
		loadingOpen();
		/*login();*/
	});

	//страница модерирвать заявки
	$('#login_panel').delegate('#order_moderated', 'click', function(){
		loadingOpen();
		/*order_moderated();*/
	});

	//кнопка отправиться на предыдущую страницу
	/*$('#goto_previous').on('click', function(){
		gotoPrevious();
	})*/

	//кнопка заголовок сайта, отправиться на главную страницу
	$('#mainpage').on('click', function(){
		loadingOpen();
		/*loadingIndex();*/
	});

	/*$('#paragraph_content').foundation('open');*/


	//отобразить содержимое paragraph
	$('.content').delegate('.a_paragraph_item', 'click', function(){
		loadingOpen();
		/*id = parseInt($(this).attr('data-id'));
		$('#paragraph_id').attr('data-id', id);
		paragraphUnit(id);*/
	});

	//наведение мыши на paragraph
	/*var par_pos = 250;
	$('.content').delegate('.a_paragraph_item', 'mouseenter', function(){
		a = $(this).find('#paragraph_name');
		a.animate({top: par_pos+25}, 200);
		a.delay(100).animate({top: 240}, 200);
	});

	$('.content').delegate('.a_paragraph_item', 'mouseleave', function(){
		a = $(this).find('#paragraph_name');
		a.animate({top: par_pos}, 200);
	})*/

	//если загрузился background
	backgroundImageLoaded($('#backgroundimage'), function(){
  		$('#backgroundimage').fadeIn(400);
  		/*$('#page_head').show(400);*/
	});
});

var backgroundImageLoaded = function(x, func){
  bg = x.css('background-image');
  if(bg){
    var src = bg.replace(/(^url\()|(\)$|[\"\'])/g, '');
    var img = $('<img>').attr('src', src).on('load', function(){
    	func();
    });
  }
}

var makeNotification = function(type, header, text){
	parameters = {};
	parameters['method'] = 'notification';
	parameters['type'] = type;
	parameters['header'] = header;
	parameters['text'] = text;
	makeAjax(parameters);
}

//загрузить страничку поиск
var search = function(){
	window.scrollTo(0,0);
	//текущая страничка как предидущая
	updatePreviousCurrent('search');
	//обновляем кнопку предидущая страница
	updateGoToPrevious();
	$('#maincontent').hide(400);
	loadingOpen();
	parameters = {};
	parameters['method'] = 'search';
	// записываем в url браузера
	history.pushState({state:5}, 'search', '/search');
	makeAjax(parameters);
}

// загрузить страничку контакты
var contacts = function(id){
	window.scrollTo(0,0);
	//текущая страница как предидущая
	updatePreviousCurrent('contacts');
	//обновляем кнопку предидушая страница
	updateGoToPrevious();
	$('#maincontent').hide(400);
	loadingOpen();
	parameters = {};
	parameters['method'] = 'contacts';
	// записываем в url браузера
	history.pushState({state:4}, 'contacts', '/contacts');
	makeAjax(parameters);
}

// загрузить страничку заявки
var orders = function(id){
	//текущая страница как предидущая
	updatePreviousCurrent('orders');
	//обновляем кнопку предидущая страница
	updateGoToPrevious();
	$('#maincontent').hide(400);
	loadingOpen();
	parameters = {};
	parameters['method'] = 'orders';
	//записываем в url браузера
	history.pushState({state:1}, 'orders', '/orders/')
	makeAjax(parameters);
}

//загрузить страничку article
var article = function(paragraph_id, unit_id, article_id){
	//текущая страница как предидущая
	updatePreviousCurrent('article');
	//обновляем кнопку предидущая страница
	updateGoToPrevious();
	$('#maincontent').hide(400);
	loadingOpen();
	parameters = {};
	parameters['paragraph_id'] = parseInt(paragraph_id);
	parameters['unit_id'] = parseInt(unit_id);
	parameters['article_id'] = parseInt(article_id);
	parameters['method'] = 'article';
	//записываем в url браузера
	history.pushState({state:7}, 'article', '/paragraph/'+paragraph_id,+'/unit/'+unit_id+'/article/'+article_id);
	makeAjax(parameters);
}

//загрузить страничку paragraph_unit _ unit
var paragraphUnitUnit = function(par_id, unit_id){
	//текущая страница как предидущая
	updatePreviousCurrent('paragraphunitunit');
	//обновляем кнопку предидущая страница
	updateGoToPrevious();
	$('#maincontent').hide(400);
	loadingOpen();
	parameters = {};
	parameters['par_id'] = parseInt(par_id);
	parameters['unit_id'] = parseInt(unit_id);
	parameters['method'] = 'paragraphunitunit';
	// записываем в url браузера
	history.pushState({state:2}, 'paragraphunitunit', '/paragraph/'+par_id+'/unit/'+unit_id);
	makeAjax(parameters);
}

//загрузить страничку paragraph_unit
var paragraphUnit = function(id){
	//текущая страница как как предидущая
	updatePreviousCurrent('paragraphunit');
	//обновляем кнопку предидущая страница
	updateGoToPrevious();
	$('#maincontent').hide(400);
	loadingOpen();
	parameters = {};
	parameters['unit'] = id;
	parameters['method'] = 'paragraphunit';
	//записываем в url браузера
	history.pushState({state:1}, 'paragraphunit', '/paragraph/'+id);
	makeAjax(parameters);
}

//загрузить страничку order_moderated
var order_moderated = function(){
	window.scrollTo(0,0);
	//текущая страница как предидущая
	updatePreviousCurrent('order_moderated');
	//обновляем кнопку предидущая страница
	updateGoToPrevious();
	$('#maincontent').hide(400);
	parameters = {};
	parameters['method'] = 'order_moderated';
	// записываем в url браузера
	history.pushState({state:6}, 'order_moderated', '/order_moderated');
	makeAjax(parameters);
}

//загрузить страничку login
var login = function(){
	window.scrollTo(0,0);
	//текущая страница как как предидущая
	updatePreviousCurrent('login');
	//обновляем кнопку предидущая страница
	updateGoToPrevious()
	$('#maincontent').hide(400);
	loadingOpen();
	parameters = {};
	parameters['method'] = 'login';
	// записываем в url браузера
	history.pushState({state:3}, 'login', '/login');
	makeAjax(parameters);	
}

//загрузить страничку loadingindex
var loadingIndex = function(){
	window.scrollTo(0,0);
	//текущая страница как как предидущая
	updatePreviousCurrent('loadingindex');
	//обновляем кнопку предидущая страница
	updateGoToPrevious()
	loadingOpen();
	parameters = {};
	parameters['method'] = 'loadingindex';
	// записываем в url браузера
	history.pushState({state:0}, 'loadingindex', '/')
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
	/*loadingOpen();*/
	$.ajax({
    	type: "POST",
    	url: "/",
    	data: JSON.stringify(parameters),
    	contentType: "application/json; charset=utf-8",
    	dataType: "json",
    	async: true,
    	success: function(data, textStatus, jqXHR){
    		//если paragraph_unit страница
    		if (parameters['method'] == 'paragraphunit'){
    			$('#maincontent').html(data['string']);
    			$('#maincontent').show(400);
    			loadingClose();
			//показать статья
			} else if (parameters['method'] == 'get_article'){
				$('#paragraph_content').html(data['string']);
				$('#paragraph_content').foundation();
				$('#paragraph_content').foundation('open');
			//удалить модерированную заявку на сырье, транспорт, пожелание и предложение
			} else if (parameters['method'] == 'delete_moderated'){
				if (data['string'] == 'ok'){
					//направляем уведомление
					header = 'уведомление';
					text = 'модерированный заказ или заявка удалена';
					makeNotification('success', header, text);
					// обновляем страницу модерирования заказов
					$('#maincontent').html(data['page']);
					loadingClose();
					$('#maincontent').show(400);
				}
			//удалить завку на сырье, транспорт, пожелание и предложение
			} else if (parameters['method'] == 'delete'){
				if (data['string'] == 'ok'){
					//направляем уведомление
					header = 'уведомление';
					text = 'заказ или заявка удалена';
					makeNotification('success', header, text);
					// обновляем страницу модерирования заказов
					$('#maincontent').html(data['page']);
					loadingClose();
					$('#maincontent').show(400);
				}
			//отправить форму модерации
			} else if (parameters['method'] == 'submit_moderate'){
				if (data['string'] == 'ok'){
					// направляем уведомление
					header = 'уведомление';
    				text = 'заказ промодерирован и доступен в списке в разделе Контакты';
    				makeNotification('success', header, text);
    				// обновляем страничку Модерирования заказов
    				$('#maincontent').html(data['page']);
					loadingClose();
					$('#maincontent').show(400);
				} else {
					//направляем уведомление
					header = 'уведомление';
    				text = 'При записи значений в БД произошла ошибка';
    				makeNotification('alert', header, text);
    				// обновляем страничку Модерирования заказов
    				$('#maincontent').html(data['page']);
					loadingClose();
					$('#maincontent').show(400);
				}
			//форма модерации
			} else if (parameters['method'] == 'moderate_form'){
				$('#moderate_form').html(data['string'])
			//поиск по ключевому слову
			} else if (parameters['method'] == 'searchkeyup'){
				$('#result').html(data['string']);
			//если article страница
			} else if (parameters['method'] == 'article'){
				console.log('asdfajd;l');
				$('#maincontent').html(data['string']);
				$('#maincontent').show(400);
				loadingClose();
				$('#paragraph_content').html(data['article']);
				$('#paragraph_content').foundation();
				$('#paragraph_content').foundation('open');
			//если paragraph_unit unit страница
			} else if (parameters['method'] == 'paragraphunitunit'){
				$('#maincontent').html(data['string']);
				$('#maincontent').show(400);
				loadingClose();
			//если страница заказов
			} else if (parameters['method'] == 'orders'){
				$('#maincontent').html(data['string']);
				loadingClose();
				$('#maincontent').show(400);
			//если страница поиска
			} else if (parameters['method'] == 'search'){
				$('#maincontent').html(data['string']);
				loadingClose();
				$('#maincontent').show(400);
			//если страница контактов
			} else if (parameters['method'] == 'contacts'){
				$('#maincontent').html(data['string']);
				loadingClose();
				$('#maincontent').show(400);
			//если страница модерирования заказов
			} else if (parameters['method'] == 'order_moderated'){
				$('#maincontent').html(data['string']);
    		//если основная страница
    		} else if (parameters['method'] == 'loadingindex'){
    			$('.content').html(data['string']);
    			//загружаем index maincontent
				var no = 0;
		  		$.each($('.paragraph_background'), function(i){
		  			backgroundImageLoaded($(this), function(){
						no += 1;
						if (no == $('.paragraph_background').length){
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
    			/*loadingClose();*/
    			$('#notification_panel').append(data['string']);
			// если trylogin
    		} else if (parameters['method'] == 'trylogin'){
    			loadingClose();
    			if ('login_panel' in data){
    				$('#login_panel').html(data['login_panel']);
    				header = 'уведомление';
    				text = 'выполнен вход';
    				makeNotification('success', header, text);
    				window.location = '/orders';
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
			// eсли оставить заявку 'showtransportform'
			} else if (parameters['method'] == 'showtransportform'){
				$('#paragraph_content').html(data['string']);
				$('#paragraph_content').foundation('open');
    		// если оставить заявку 'showorderform'
    		} else if (parameters['method'] == 'showorderform'){
				$('#paragraph_content').html(data['string']);
				$('#paragraph_content').foundation('open');
			// если отправить заявку на транспорт
			} else if (parameters['method'] == 'submit_transport_order'){
				/*loadingClose();*/
				$('#paragraph_content').foundation('close');
				answer = data['string'];
				if (answer == 'ok'){
    				header = 'уведомление';
	    			text = 'заявка сформирвана';
	    			makeNotification('success', header, text);	
    			} else if (answer == 'notok'){
    				header = 'ошибка сайта';
					text = 'при отправке формы возникла ошибка';
					makeNotification('alert', header, text);
    			}
			// если отправить заявку
    		} else if (parameters['method'] == 'submit_order'){
    			/*loadingClose();*/
    			$('#paragraph_content').foundation('close');
    			answer = data['string'];
    			if (answer == 'ok'){
    				header = 'уведомление';
	    			text = 'заявка сформирована';
	    			makeNotification('success', header, text);	
    			} else if (answer == 'notok'){
    				header = 'ошибка сайта';
					text = 'при отправке формы возникла ошибка';
					makeNotification('alert', header, text);
    			}
			// если оставить пожелание и предложение
			} else if (parameters['method'] == 'getintouch'){
				/*loadingClose();*/
				answer = data['string'];
				if (answer == 'ok'){
					header = 'уведомление';
					text = 'пожелание и предложение отправлено';
					makeNotification('success', header, text);
				} else if (answer == 'notok'){
					header = 'ошибка сайта';
					text = 'при отправке формы возникла ошибка';
					makeNotification('alert', header, text);
				}
				//обновляем страницу
				$('#maincontent').html(data['paragraph_unit']);
    		// если показать карту
    		} else if (parameters['method'] == 'schema'){
    			$('#paragraph_content').html(data['string']);
    			$('#paragraph_content').foundation('open');
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
	} else if ($('#previous_page').html() == 'paragraphunit'){
		id = parseInt($('#paragraph_id').attr('data-id'));
		paragraphUnit(id);
	} else if ($('#previous_page').html() == 'orders'){
		orders();
	} else if ($('#previous_page').html() == 'paragraphunitunit'){
		par_id = parseInt($('#paragraph_id').attr('data-id'));
		unit_id = parseInt($('#unit_id').attr('data-id'));
		paragraphUnitUnit(par_id, unit_id);
	} else if ($('#previous_page').html() == 'article'){
		paragraph_id = parseInt($('#paragraph_id').attr('data-id'));
		unit_id = parseInt($('#unit_id').attr('data-id'));
		article_id = parseInt($('#article_id').attr('data-id'));
		article(paragraph_id, unit_id, article_id);
	}
}