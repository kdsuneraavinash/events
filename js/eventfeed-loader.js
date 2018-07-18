eventList = Array();

function readAllDataStramProcessor(doc){
    var id = doc.id;
    var event = doc.data();

    var table="<tr>";
    table+="<td>"+id+"</td>";
    table+="<td>"+event.eventName+"</td>";
    table+="<td>"+event.description+"</td>";
    table+="</tr>";
    eventList.push(table);

    var html = "<table  class='table table-striped table-bordered table-hover'>";
    html+='<thead class="thead-dark">';
    html+='<tr><th scope="col">ID</th>';
    html+='<th scope="col">Event Name</th>';
    html+='<th scope="col">Description</th></tr></thead>';
    for (var i = 0; i < eventList.length; i++) {
        html+=eventList[i];
    }
    html+="</table>";

    document.getElementById("box").innerHTML = html;
}


readAllData(readAllDataStramProcessor);


