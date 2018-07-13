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
  var successText = $("#success_text");
  var invalidText = $("#invalid_text");

  // Hide all error messages
  fromControls.parent().removeClass("has-error");
  fromControls.parent().removeClass("has-warning");
  emptyText.css("display", "none");
  successText.css("display", "none");
  invalidText.css("display", "none");

  // Check for empty field
  var isEmptyField = false;
  fromControls.each(function(index, element) {
    if ($(element).val() === "") {
      $(element).parent().addClass("has-warning");
      emptyText.css("display", "block");
      isEmptyField = true;
      return false;
    }
  });
  if (isEmptyField) return false;


  // Chack if 2 dates are valid
  var startDateObj = new DateObj(startDate.val());
  var endDateObj = new DateObj(endDate.val());
  if (startDateObj.isGreaterThan(endDateObj)) {
    // Start Date Greater than End Date
    startDate.parent().addClass("has-error");
    endDate.parent().addClass("has-error");
    invalidText.css("display", "block");
    return false;
  }

  // Chack if 2 times are valid
  var startTimeObj = new TimeObj(startTime.val());
  var endTimeObj = new TimeObj(endTime.val());
  if (startTimeObj.isGreaterThan(endTimeObj)) {
    // Start Time Greater than End Time
    startTime.parent().addClass("has-error");
    endTime.parent().addClass("has-error");
    invalidText.css("display", "block");
    return false;
  }

  successText.css("display", "block");
  return false;
}

// Create a Date Object
function DateObj(dateString) {
  // [YYYY/MM/DD]
  this.year = dateString.split('-')[0];
  this.month = dateString.split('-')[1];
  this.date = dateString.split('-')[2];

  this.isGreaterThan = function(exp_bigger) {
    return (this.year > exp_bigger.year ||
      this.month > exp_bigger.month ||
      this.date > exp_bigger.date);
  }
}

// Create a Time Object
function TimeObj(timeString) {
  // [HH:MM] in 24 Hours
  this.hour = timeString.split(':')[0];
  this.minute = timeString.split(':')[1];

  this.isGreaterThan = function(exp_bigger) {
    return (this.hour > exp_bigger.hour ||
      this.minute > exp_bigger.minute);
  }
}
