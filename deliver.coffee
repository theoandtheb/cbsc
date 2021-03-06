$(document).ready ->
	$('.wpcf7-submit').addClass('apiSubmit').removeClass('wpcf7-submit').removeClass('wpcf7-form-control')

	$(document).on('click', '.apiSubmit', ( ->
		$.post 'http://api.cbsc.ca/got_it',
	        stationName: $('input[name=station-name]').val()
	        programmeName: $('input[name=program-name]').val()
	        dateOfProgram: $('input[name=date-of-program]').val()
	        timeOfProgram: $('input[name=time-of-program]').val()
	        specificConcern: $('textarea[name=specific-concern]').val()
	        yourAddress: $('input[name=your-address]').val()
	        yourCity: $('input[name=your-city]').val()
	        yourProvince: $('select[name=your-province]').val()
	        yourPostalCode: $('input[name=your-postal-code]').val()
	        firstName: $('input[name=first-name]').val()
	        lastName: $('input[name=last-name]').val()
	        yourTitle: $('select[name=your-title]').val()
	        yourEmail: $('input[name=your-email]').val()

    	alert 'Your complaint has been submitted successfully to the CBSC.'
	));