var Login = function(response) {

    var dashBoardButton = $('.dashboard-button');
    var firstName;
    var lastName;
    var userID;


    dashBoardButton.click(function() {
        console.log("Testing datapassing: "  + response.name);
        //FB.api('/me', function(response) {
        //    console.log('My Test: ' + response.name + " ID: " + response.id);
        //    createUser(response);
        //});
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
            },
            success: function(data) {
                console.log("Success: " + data.first_name);
                firstName = data.first_name;
                lastName = data.last_name;
                userID = data.user_id;
            }
        });
    }
};