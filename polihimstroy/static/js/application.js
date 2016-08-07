$(document).ready(function(){
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
		a.animate({top: par_pos}, 200);
	})

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
    		}
    	}
	});
}