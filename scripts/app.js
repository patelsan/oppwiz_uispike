//instantiate the view models
navigationViewModel = new Models.NavigationViewModel();
opportunityViewModel = new Models.OpportunityViewModel();

//do apply the bindings
ko.applyBindings(navigationViewModel, document.querySelector('#navbar'));
ko.applyBindings(opportunityViewModel, document.querySelector('#workspace'));

$('.nav-tree').delegate('button','click',function(e){
	$('.in').collapse('hide');
	$('#' + e.target.dataset.href1).collapse('show');
	window.location.hash = e.target.dataset.href2;
	$('#' + e.target.dataset.href2+'2').focus();
});
//$('#'+$parent.GroupID).collapse('show');