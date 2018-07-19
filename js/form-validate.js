// DEPENDANCY: jQuery
// DEPENDANCY: firebase-auth

/**
 * Validate for empty fields and invalid fields
 */
function validate() {
  try {
    if (!firebase_auth.currentUser) {
      // User not logged in
      $("#signupNotice").modal('show');
      return false;
    }

    var isAllDay = $("#isAllDay");
    var formControls = $(".form-control.addevent");
    var timeControls = $(".form-control.addevent-isallday");

    // Hide all error messages
    formControls.removeClass("is-invalid");
    timeControls.removeClass("is-invalid");

    // Check for empty field
    if (!validateEmptyFields(formControls)) return false;
    // Check for no images
    if (!validateNoImages()) return false;
    // Check for invalid time 
    if (!isAllDay.is(":checked")) {
      // Check for invalid date field
      if (!validateEmptyFields(timeControls)) return false;
    } else {
      // Change time fields
      startTime.val("00:00");
      endTime.val("23:59");
    }
    if (!validateDateFields()) return false;

    // Check for invalid no of tags
    if (!validateTags(tags)) return false;

    // Validated
    console.log("Form validated");

    return true;
    //return true;
  } catch (error) {
    console.error(error.message);
    return false;
  }
}

/**
 * Validate empty fields
 */
function validateEmptyFields(controlsArray) {

  var isEmptyField = false;
  controlsArray.each(function (_, element) {
    if ($(element).val() === "") {
      $(element).addClass("is-invalid");
      isEmptyField = true;
      setErrorMessage("You have to fill all of the fields.", "Empty Field");
      return false;
    }
  });

  return (!isEmptyField);
}


/**
 * Validate no of images
 */
function validateNoImages() {
  var urlFields = $('input[name^="uploaded_images"]');

  var isValid = (urlFields.length != 0);
  if (!isValid) setErrorMessage("Select at least one image to be shown.", "No Images Selected");
  return isValid;
}


/**
 * Validate for date fields
 * FIXME: Not sure if this algo is correct
 */
function validateDateFields() {
  var startDate = $("#startDate");
  var endDate = $("#endDate");
  var startTime = $("#startTime");
  var endTime = $("#endTime");

  var startDateVal = startDate.val() + " " + startTime.val();
  startDateVal = new Date(startDateVal);
  var endDateVal = endDate.val() + " " + endTime.val();
  endDateVal = new Date(endDateVal);
  var today = new Date();

  if (today > endDateVal) {
    // Today Greater than End Date
    $(endDate).addClass("is-invalid");
    setErrorMessage("Event cannot have already ended. Please check your end date.", "Invalid Date");
    return false;
  }

  if (startDateVal > endDateVal) {
    // Start Date Greater than End Date
    startDate.addClass("is-invalid");
    endDate.addClass("is-invalid");
    startTime.addClass("is-invalid");
    endTime.addClass("is-invalid");
    setErrorMessage("Event should end after starting date. Please check your end date and start date.", "Invalid Date");
    return false;
  }

  return true;
}


/*
 * validate for tags by getting no of tags
 * FIXME: If divided by 2 spaces, detecting no of tags becomes incorrect.
 */
function validateTags() {
  var tags = $("#tags");

  if (tags.val().split(" ").length > 15) {
    tags.addClass("is-invalid");
    setErrorMessage("No of Tags exceed 15. Remove unnecessary tags.", "Invalid Tags");
    return false;
  }

  return true;
}


/*
 * Helper function to change submitted text
 */
function setErrorMessage(text, title) {
  $("#msgbox_title").text(title);
  $("#msgbox_text").text(text);
  $("#msgbox").modal("show");
}