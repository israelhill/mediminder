var Login = function(response) {

    var dashBoardButton = $('.dashboard-button');


    dashBoardButton.click(function() {
        FB.api('/me', function(response) {
            console.log('My Test: ' + response.name + " ID: " + response.id);
            createUser(response);
        });
        console.log("Testing datapassing: "  + response.name);
    });

    function createUser(fbResponseObj) {
        var firstName = fbResponseObj.name.split(" ")[0];
        var lastName = fbResponseObj.name.split(" ")[1];
        $.ajax({
            url: "/users",
            type: 'POST',
            data: {
                user: {
                    first_name: firstName,
                    last_name: lastName,
                    user_id: fbResponseObj.id
                }
            }
        });
    }
};