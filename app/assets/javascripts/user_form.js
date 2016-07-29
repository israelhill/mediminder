var UserForm = (function() {
    var userFirstName;
    var userLastName;
    var userPhone;
    var userEmail;

    var childFirstName;
    var childLastName;
    var childPhone;

    var drugName_1;
    var drugDosage_1;
    var drugFreq_1;

    var drugName_2;
    var drugDosage_2;
    var drugFreq_2;

    var drugName_3;
    var drugDosage_3;
    var drugFreq_3;

    var submitButton = $('.submit-form-button');
    var userObj;
    var childObj;
    var drug1Obj;
    var drug2Obj;
    var drug3Obj;

    submitButton.click(function() {
        createUserObject();
        createChildObject();
        createDrugObject_1();
        createDrugObject_2();
        createDrugObject_3();
    });

    function createUserObject() {
        userFirstName = $('.user-first-name').val();
        userLastName = $('.user-last-name').val();
        userPhone = $('.user-phone').val();
        userEmail = $('.user-email').val();

        userObj = {
            userFirstName: userFirstName,
            userLastName: userLastName,
            userPhone: userPhone,
            userEmail: userEmail
        };

        console.log(userFirstName + " " + userLastName + " " + userPhone + " " + userEmail);
    }

    function createChildObject() {
        childFirstName = $('child-first-name');
        childLastName = $('child-last-name');
        childPhone = $('child-phone');

        childObj = {
            childFirstName: childFirstName,
            childLastName: childLastName,
            childPhone: childPhone
        };
    }

    function createDrugObject_1() {
        drugName_1 = $('.drug-1-name').val();
        drugDosage_1 = $('.drug-1-dosage').val();
        drugFreq_1 = $('.drug-1-freq').val();

        if(drugName_1 === '') {
            drug1Obj = null;
        }
    }

    function createDrugObject_2() {
        drugName_2 = $('.drug-2-name').val();
        drugDosage_2 = $('.drug-2-dosage').val();
        drugFreq_2 = $('.drug-2-freq').val();

        if(drugName_2 === '') {
            drug2Obj = null;
        }
    }

    function createDrugObject_3() {
        drugName_3 = $('.drug-3-name').val();
        drugDosage_3 = $('.drug-3-dosage').val();
        drugFreq_3 = $('.drug-3-freq').val();

        if(drugName_3 === '') {
            drug3Obj = null;
        }
    }
});