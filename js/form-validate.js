/**
 * ************************************
 * FORM FUNCTIONS
 *  ***********************************
 */

// Event handlers
$("#addURL").click(addAnotherUrl);
$("#removeURL").click(removeURL);

/** 
 * Add another URL text box
 **/
function addAnotherUrl() {
  var images = $(".images_form");
  var newText = images.first().clone();
  newText.val("");
  images.parent().append(newText);
}

/** 
 * ARemove last URL text box
 * If only one text box, just clear it
 **/
function removeURL() {
  var images = $(".images_form");
  if (images.length == 1) {
    images.last().val("");
  } else {
    images.last().remove();
  }
}


/**
 * ************************************
 * FORM VALIDATION
 *  ***********************************
 */

/**
 * Validate for empty fields and invalid fields
 */
function validate() {
  var startDate = $("#startDate");
  var endDate = $("#endDate");
  var startTime = $("#startTime");
  var endTime = $("#endTime");
  var urlFields = $('[id^="images_url"]');
  var tags = $("#tags");

  var formControls = $(".form-control");

  var validText = $("#valid_text");
  var invalidText = $("#invalid_text");

  // Hide all error messages
  formControls.removeClass("is-invalid");
  validText.css("display", "none");
  invalidText.css("display", "none");

  // Check for empty field
  if (!validateEmptyFields(formControls, invalidText)) return false;
  // Check for invalid date field
  if (!validateDateFields(startDate, endDate, invalidText)) return false;
  // Check for invalid time field
  if (!validateTimeFields(startTime, endTime, invalidText)) return false;
  // Check for invalid URL field
  if (!validateURLFields(urlFields, invalidText)) return false;
  // Check for invalid no of tags
  if (!validateTags(tags, invalidText)) return false;

  // Validated
  validText.css("display", "inline");
  return false;
}

/**
 * Validate empty fields
 */
function validateEmptyFields(formControls, invalidText) {
  var isEmptyField = false;
  formControls.each(function (_, element) {
    if ($(element).val() === "") {
      $(element).addClass("is-invalid");
      $(element).parent().get(0).scrollIntoView();
      isEmptyField = true;
      changeSubmitObjText(invalidText, "Empty Field");
      return false;
    }
  });
  return (!isEmptyField);
}

/**
 * Validate for date fields
 */
function validateDateFields(startDate, endDate, invalidText) {
  var startDateVal = new Date(startDate.val());
  var endDateVal = new Date(endDate.val());
  var today = new Date()
  if (today > endDateVal) {
    // Today Greater than End Date
    endDate.addClass("is-invalid");
    changeSubmitObjText(invalidText, "Invalid Date : Event cannot have already ended.");
    return false;
  }
  // Chack if 2 dates are valid
  if (startDateVal > endDateVal) {
    // Start Date Greater than End Date
    startDate.addClass("is-invalid");
    endDate.addClass("is-invalid");
    changeSubmitObjText(invalidText, "Invalid Date : Event should end after starting date.");
    return false;
  }
  return true;
}

/**
 * validate for time fields
 */
function validateTimeFields(startTime, endTime, invalidText) {
  // Chack if 2 times are valid
  if (startTime.val() > endTime.val()) {
    // Start Time Greater than End Time
    startTime.addClass("is-invalid");
    endTime.addClass("is-invalid");
    changeSubmitObjText(invalidText, "Invalid Time : Event should end after starting time.");
    return false;
  }
  return true;
}

/**
 * Validate for url fields by matching extension
 */
function validateURLFields(urlFields, invalidText) {
  var isValidField = true;
  urlFields.each(function (_, element) {
    var extMatch = new RegExp("(\.jpg|\.png|\.jpeg)$").test($(element).val());
    if (!extMatch) {
      $(element).addClass("is-invalid");
      changeSubmitObjText(invalidText, "Invalid URL : URL is not a valid direct image link.");
      isValidField = false;
      return false;
    }
  });
  return isValidField;
}

/**
 * validate for tags by getting no of tags
 */
function validateTags(tags, invalidText) {
  // Chack if 2 times are valid
  if (tags.val().split(" ").length > 15) {
    // Start Time Greater than End Time
    tags.addClass("is-invalid");
    changeSubmitObjText(invalidText, "Invalid Tags : No of Tags exceed 15.");
    return false;
  }
  return true;
}

/**
 * Helper function to change submitted text
 */
function changeSubmitObjText(element, text) {
  element.find(".text").text(text);
  element.css("display", "inline");
}