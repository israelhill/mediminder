var UserForm = (function() {
    var userFirstName;
    var userLastName;
    var userPhone;
    var userEmail;

    var childFirstName;
    var childLastName;
    var childPhone;
    var relationshipType;

    var drugName_1;
    var drugDosage_1;
    var drugFreq_1;
    var drugTimes_1;

    var drugName_2;
    var drugDosage_2;
    var drugFreq_2;
    var drugTimes_2;

    var drugName_3;
    var drugDosage_3;
    var drugFreq_3;
    var drugTimes_3;

    var submitButton = $('.submit-form-button');
    var userObj;
    var childObj;
    var drug1Obj;
    var drug2Obj;
    var drug3Obj;

    var bigData;

    submitButton.click(function() {
        createUserObject();
        createChildObject();
        createDrugObject_1();
        createDrugObject_2();
        createDrugObject_3();
        sendFormData();
    });

    $('.relationship-ul li').click(function(){
        $('.relationship-type-button').html($(this).text() + '  ' + '<span class="caret"></span>');
    });

    function sendFormData() {
        bigData = {
            user: userObj,
            child: childObj,
            drug1: drug1Obj,
            drug2: drug2Obj,
            drug3: drug3Obj
        };

        $.ajax({
            url: "/form_data",
            type: 'POST',
            data: bigData
        });
    }

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
        childFirstName = $('.child-first-name').val();
        childLastName = $('.child-last-name').val();
        childPhone = $('.child-phone').val();
        relationshipType = $('.relationship-type-button').html().split(' ')[0];

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
        drugTimes_1 = getActiveTimes('#drugFreqList1');

        if(drugName_1 === '') {
            drug1Obj = null;
        }
        else {
            drug1Obj = {
                drug_name: drugName_1,
                drug_dosage: drugDosage_1,
                drug_freq: drugFreq_1,
                drugTimes: drugTimes_1
            };
        }
    }

    function createDrugObject_2() {
        drugName_2 = $('.drug-2-name').val();
        drugDosage_2 = $('.drug-2-dosage').val();
        drugFreq_2 = $('.drug-2-freq').val();
        drugTimes_2 = getActiveTimes('#drugFreqList2');

        if(drugName_2 === '') {
            drug2Obj = null;
        }
        else {
            drug2Obj = {
                drug_name: drugName_2,
                drug_dosage: drugDosage_2,
                drug_freq: drugFreq_2,
                drugTimes: drugTimes_2
            };
        }
    }

    function createDrugObject_3() {
        drugName_3 = $('.drug-3-name').val();
        drugDosage_3 = $('.drug-3-dosage').val();
        drugFreq_3 = $('.drug-3-freq').val();
        drugTimes_3 = getActiveTimes('#drugFreqList3');

        if(drugName_3 === '') {
            drug3Obj = null;
        }
        else {
            drug3Obj = {
                drug_name: drugName_3,
                drug_dosage: drugDosage_3,
                drug_freq: drugFreq_3,
                drugTimes: drugTimes_3
            };
        }
    }

    function getFreq(listNum) {
        var count = 0;
        var listName = 'drugFreqList' + listNum;
        var listElements = $('#' + listName).children().children('li');
        listElements.each(function() {
            count++;
        });

        return count;
    }

    function getActiveTimes(listName) {
        var listElements = $(listName).children().children('li');
        var drugTimes = [];
        var count = 0;
        listElements.each(function(index, element) {
            var listElement = $(element);
            var time = listElement.text();
            if(listElement.hasClass('active')) {
                count++;
                drugTimes.push(time);
                console.log(time);
            }
        });

        return drugTimes;
    }

    /******************************************************************************************************/

    $('.list-group.checked-list-box .list-group-item').each(function () {

        // Settings
        var $widget = $(this),
            $checkbox = $('<input type="checkbox" class="hidden" />'),
            color = ($widget.data('color') ? $widget.data('color') : "primary"),
            style = ($widget.data('style') == "button" ? "btn-" : "list-group-item-"),
            settings = {
                on: {
                    icon: 'glyphicon glyphicon-check'
                },
                off: {
                    icon: 'glyphicon glyphicon-unchecked'
                }
            };

        $widget.css('cursor', 'pointer')
        $widget.append($checkbox);

        // Event Handlers
        $widget.on('click', function () {
            $checkbox.prop('checked', !$checkbox.is(':checked'));
            $checkbox.triggerHandler('change');
            updateDisplay();
        });
        $checkbox.on('change', function () {
            updateDisplay();
        });


        // Actions
        function updateDisplay() {
            var isChecked = $checkbox.is(':checked');

            // Set the button's state
            $widget.data('state', (isChecked) ? "on" : "off");

            // Set the button's icon
            $widget.find('.state-icon')
                .removeClass()
                .addClass('state-icon ' + settings[$widget.data('state')].icon);

            // Update the button's color
            if (isChecked) {
                $widget.addClass(style + color + ' active');
            } else {
                $widget.removeClass(style + color + ' active');
            }
        }

        // Initialization
        function init() {

            if ($widget.data('checked') == true) {
                $checkbox.prop('checked', !$checkbox.is(':checked'));
            }

            updateDisplay();

            // Inject the icon if applicable
            if ($widget.find('.state-icon').length == 0) {
                $widget.prepend('<span class="state-icon ' + settings[$widget.data('state')].icon + '"></span>');
            }
        }
        init();
    });
});