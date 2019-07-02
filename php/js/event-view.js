// Load the docID into page - called after GET
function loadIntoEventView(docID) {
    $("#loadingDataModel").show();
    $("#showevent_content").hide();
    readDocument(docID, applyDataToViewData);
}

// Apply data to the page
// Every field is checked before using
// TODO: Add a good way to format date and time
// TODO: Add a good way to view images
function applyDataToViewData(doc) {
    var data = doc.data();

    if (defined(data.eventName)) $("#eventName").text(data.eventName);
    if (defined(data.organizer)) $("#organizer").text(data.organizer);
    if (defined(data.location)) $("#location").text(data.location);

    // Add line breaks for \n characters
    if (defined(data.description)) {
        var text = data.description;
        text = urlify(text);
        text = text.replace(/\r?\n/g, '<br />');
        $("#description").html(text);
    }

    // Get start date
    if (defined(data.start)) {
        $("#startDate").text(formatDate(data.start.toDate()));
        if (!data.isAllDay) $("#startTime").text(formatTime(data.start.toDate()));
    }
    if (defined(data.end)) {
        $("#endDate").text(formatDate(data.end.toDate()));
        if (!data.isAllDay) $("#endTime").text(formatTime(data.end.toDate()));
    }

    // Get end date
    if (defined(data.images)) {
        // Change background image
        $('body').css('background-image', "linear-gradient( rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)), url(" + data.images[0] + ")");

        // Create image buttons and add them to the page
        var imagesHTML = [];
        for (i = 0; i < data.images.length; i++) {
            var item = '<div class="col-md-4 gallery slideanim" style="background-image:url(' + data.images[i] + ');" ' +
                'onclick="window.open(\'' + data.images[i] + '\',\'_blank\');">' +
                '</div>'
            imagesHTML.push(item);
        }
        var images = imagesHTML.join(" ");
        $("#images").html(images);
    }

    // Show page
    $("#showevent_content").show();
    $("#loadingDataModel").hide();
}

// Check whether a variable is defined
function defined(variable) {
    return (typeof variable !== 'undefined');
}

// Format time
function formatTime(timeObj) {
    var time = timeObj.toLocaleTimeString();
    time = time.split(':');
    var ampm = time[2].split(' ')[1];
    return time[0] + ":" + time[1] + " " + ampm;
}

// Format date into readable date
function formatDate(dateObj) {
    var date = dateObj.toLocaleDateString();
    date = date.split('/');
    var month = new Array();
    month[0] = "January";
    month[1] = "February";
    month[2] = "March";
    month[3] = "April";
    month[4] = "May";
    month[5] = "June";
    month[6] = "July";
    month[7] = "August";
    month[8] = "September";
    month[9] = "October";
    month[10] = "November";
    month[11] = "December";
    date = date[1] + " " + month[date[0] - 1] + " " + date[2];
    return date
}

// Replace urls with links
// https://stackoverflow.com/questions/1500260/detect-urls-in-text-with-javascript
function urlify(text) {
    // https://www.regextester.com/96504
    var urlRegex = /(https?:\/\/[^\s]+)/ig
    return text.replace(urlRegex, function (url) {
        return '<u><a class="text-white" href="' + url + '" target="_blank">' + url + '</a></u>';
    })
    // or alternatively
    // return text.replace(urlRegex, '<a href="$1">$1</a>')
}