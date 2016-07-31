var Login = (function() {

    var dashBoardButton = $('.dashboard-button');


    dashBoardButton.click(function() {
        FB.api('/me', function(response) {
            console.log('My Test: ' + response.name + " ID: " + response.id);
        });
    });
});