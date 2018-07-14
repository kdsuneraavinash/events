// Event handlers
$("#addURL").click(addAnotherUrl);
$("#removeURL").click(removeURL);

// Add another URL text box
function addAnotherUrl() {
  var images = $(".images_form");
  var newText = images.first().clone();
  newText.val("");
  images.parent().append(newText);
}

// Remove last URL text box
// If only one text box, just clear it
function removeURL() {
  var images = $(".images_form");
  if (images.length == 1) {
    images.last().val("");
  } else {
    images.last().remove();
  }
}

// Validate for empty fields and invalid fields
function validate() {
  var startDate = $("#startDate");
  var endDate = $("#endDate");
  var startTime = $("#startTime");
  var endTime = $("#endTime");

  var fromControls = $(".form-control");

  var emptyText = $("#empty_text");
  var validText = $("#valid_text");
  var invalidText = $("#invalid_text");

  // Hide all error messages
  fromControls.removeClass("is-invalid");
  validText.css("display", "none");
  invalidText.css("display", "none");

  // Check for empty field
  var isEmptyField = false;
  fromControls.each(function(index, element) {
    if ($(element).val() === "") {
      $(element).addClass("is-invalid");
      invalidText.css("display", "inline");
      $(element).get(0).scrollIntoView();
      isEmptyField = true;
      return false;
    }
  });
  if (isEmptyField) return false;

  // Chack if 2 dates are valid
  if (startDate.val() > endDate.val()) {
    // Start Date Greater than End Date
    startDate.addClass("is-invalid");
    endDate.addClass("is-invalid");
    invalidText.css("display", "inline");
    startDate.get(0).scrollIntoView();
    return false;
  }

  // Chack if 2 times are valid
  if (startTime.val() > endTime.val()) {
    // Start Time Greater than End Time
    startTime.addClass("is-invalid");
    endTime.addClass("is-invalid");
    invalidText.css("display", "inline");
    startTime.get(0).scrollIntoView();
    return false;
  }

  validText.css("display", "inline");
  return false;
}
