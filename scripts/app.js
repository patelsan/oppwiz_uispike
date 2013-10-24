//instantiate the view models
navigationViewModel = new Models.NavigationViewModel();
opportunityViewModel = new Models.OpportunityViewModel();

//do apply the bindings
ko.applyBindings(navigationViewModel, document.querySelector('#navbar'));
ko.applyBindings(opportunityViewModel, document.querySelector('#workspace'));

$('.nav-tree').delegate('.btn', 'click', function(e) {
    e.preventDefault();

    var $element = $(e.target.hash + "2");
    var el = $element.closest('.accordion-group').attr('id');
    var isopen = $("#"+el).hasClass('open');
    if( !isopen ){
        $('.accordion-group').removeClass('open').filter("#"+el).addClass('open');
    }
    window.setTimeout(function() {
        window.location.hash = e.target.hash;
        $element.focus();
    }, 5);
});