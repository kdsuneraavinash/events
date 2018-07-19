// TODO: Add methods to handle Event delete etc...

// Loads all events into the grid
// Called when document is loaded
function loadAllEvents() {
    $("#events_content").hide();
    $("#loadingDataModel").show();

    readAllData(readNewDocument, doneReading);
}

// Loaded documents
var addedDocuments = 0;

// Reads a document and adds it into the grid
// Wrapped by firestore all event load function
function readNewDocument(doc) {
    var data = doc.data();
    card = "<div class='col-lg card'>" +
        "<div class='event_image mb-2' style='background-image: url(" + data.images[0] + ");' "+
        "onclick=\"location.href='showevent.php?eventid=" + doc.id + "';\" >" +
        "</div>" +
        "<h4 class='card-title'>" + data.eventName + "</h4>" +
        "<h6 class='card-subtitle mb-2 text-muted'>" + data.organizer + "</h6>" +
        "<div class='mt-auto'>" +
        "<button class='btn btn-primary w-100' onclick=\"location.href='showevent.php?eventid=" + doc.id + "';\" >View Event</button>" +
        "</div>" +
        "</div>";

    addedDocuments += 1;
    // Attach this html code to the page
    $("#events").children().last().append(card);

    // Row breaker (3 Columns per row)
    if (addedDocuments % 3 == 0) $("#events").append("<div class='row'></div>");
}

// After events are done reading
function doneReading() {
    $("#events_content").show();
    $("#loadingDataModel").hide();
}