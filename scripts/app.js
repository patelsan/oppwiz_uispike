var myViewModel = {
    userAge: null,
    userName: ko.observable()
};
myViewModel.userName("bob");

ko.applyBindings(myViewModel);