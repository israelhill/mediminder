var Login = (function() {

    console.log("Hello");
    var submitButton = $('.login-button');

    function printUsername() {
        var username = $('.username-field').val();
        var password = $('.password-field').val();
        console.log(username + " " + password);

    }

    submitButton.click(function() {
        printUsername();
    });
});