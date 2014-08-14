jQuery(document).ready( function($) {
	
	$('.app ul li a.button').click(function(){
		$(this).parent().find('ul.level1').slideToggle();
		if( $('.app').hasClass('open') ){
			$('.app').animate({width:'300px'}).removeClass('open');
			$('ul.level2.open').each(function(){ $(this).animate({width: 'toggle'}).removeClass('open'); });
		}
		return false;
	});
	
	$('.app ul li a.parent').click(function(){
		if( !$('.app').hasClass('open') ){ $('.app').animate({width:'604px'}); }
		else{ $('.app').animate({width:'300px'}); }
		$('.app').toggleClass('open');
		$(this).parent().find('ul.level2').animate({width: 'toggle'}).toggleClass('open');
		return false;
	});
	
	
});