//instantiate the view models
navigationViewModel = new Models.NavigationViewModel();
opportunityViewModel = new Models.OpportunityViewModel();

//do apply the bindings
ko.applyBindings(navigationViewModel, document.querySelector('#navbar'));
ko.applyBindings(opportunityViewModel, document.querySelector('#workspace'));