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
    var validText = $("#valid_text");
    var invalidText = $("#invalid_text");

    // Hide all error messages
    formControls.removeClass("is-invalid");
    timeControls.removeClass("is-invalid");
    validText.css("display", "none");
    invalidText.css("display", "none");

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
    if (!validateTags(tags, invalidText)) return false;

    // Validated
    validText.css("display", "inline");
    console.log("Form validated");

    return true;
    //return true;
  } catch (error) {
    console.error(error.description);
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
      setErrorMessage("Empty Field");
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
  if (!isValid) setErrorMessage("No Images Selected");
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
    setErrorMessage("Invalid Date : Event cannot have already ended.");
    return false;
  }

  if (startDateVal > endDateVal) {
    // Start Date Greater than End Date
    startDate.addClass("is-invalid");
    endDate.addClass("is-invalid");
    startTime.addClass("is-invalid");
    endTime.addClass("is-invalid");
    setErrorMessage("Invalid Date : Event should end after starting date.");
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
    setErrorMessage("Invalid Tags : No of Tags exceed 15.");
    return false;
  }

  return true;
}


/**
 * Helper function to change submitted text
 */
function setErrorMessage(text) {
  var element = $("#invalid_text");
  element.find(".text").text(text);
  element.css("display", "inline");
}