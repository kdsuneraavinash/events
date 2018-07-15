<?php include("header.php"); ?>

<div class="container" id="addevent_content">
  <div class="card p-3 content">

    <!-- Title -->
    <h2>Fill this Form and Submit Event Details.</h2>
    <!-- Info Text -->
    <h4>
      <small>All fields are required.</small>
    </h4>
    <hr />

    <form onsubmit="return validate()" id="event_form">

      <!-- Event Name Text -->
      <div class="form-group">
        <label for="eventName">Event Name:</label>
        <input type="text" class="form-control addevent" id="eventName" placeholder="Event" />
      </div>
      <!-- Event Otganizer Text -->
      <div class="form-group">
        <label for="organizer">Organizer:</label>
        <input type="text" class="form-control addevent" id="organizer" placeholder="Organizing Society" />
      </div>
      <!-- Event Description Text Area -->
      <div class="form-group">
        <label for="description">Description:</label>
        <textarea rows="5" class="form-control addevent" id="description" placeholder="Describe event and its purpose here"></textarea>
      </div>

      <br />

      <!-- Event Venue Text -->
      <div class="form-group">
        <label for="location">Venue:</label>
        <input type="text" class="form-control addevent" id="location" aria-describedby="locationHelp" placeholder="Venue" />
        <small class="form-text text-muted" id="locationHelp">
          If inside the university, mention location name. Otherwise include address of the location.
        </small>
      </div>

      <br />

      <!-- Event Start Date -->
      <div class="form-group">
        <label for="startDate">Start Date:</label>
        <input type="date" class="form-control addevent" id="startDate" />
      </div>
      <!-- Event End Date -->
      <div class="form-group">
        <label for="endDate">End Date:</label>
        <input type="date" class="form-control addevent" id="endDate" aria-describedby="dateHelp" />
        <small class="form-text text-muted" id="dateHelp">
          Event end date must be on or after start date.
        </small>
      </div>


      <br />

      <!-- Event Start Time -->
      <div class="form-group">
        <label for="startTime">Start Time:</label>
        <input type="time" class="form-control addevent" id="startTime" />
      </div>
      <!-- Event End Time -->
      <div class="form-group">
        <label for="endTime">End Time:</label>
        <input type="time" class="form-control addevent" id="endTime" aria-describedby="timeHelp" />
        <small class="form-text text-muted" id="timeHelp">
          Enter a general start/end time if time is not definite. Event end time must be at or after start time.
        </small>
      </div>


      <br />

      <!-- Event Image URL Text Area -->
      <div class="form-group" aria-describedby="imageHelp">
        <label for="images">Image Links:</label>
        <input type="url" class="form-control images_form my-2 addevent" id="images_url0" placeholder="https://www.website.com/path/to/image.png" novalidate
        />
      </div>
      <button class="btn btn-default" type="button" id="addURL">Add Another URL</button>
      <button class="btn btn-default" type="button" id="removeURL">Remove Last URL</button>
      <small class="form-text text-muted" id="imageHelp">
        Enter each URL in a seperate box. Add only direct links. (Links ending in .jpg/.png) Input in https://website/image.jpg format.
        First image will be cover image.
      </small>

      <br />

      <div class="form-group">
        <label for="tags">Tags:</label>
        <input type="text" class="form-control addevent" id="tags" placeholder="sport gaming computer" aria-describedby="tagHelp" />
        <small class="form-text text-muted" id="tagHelp">
          Add tags here seperated by spaces. Tags will help others to find your event. Maximum no of tags available is 15. Other tags
          will be discarded.
        </small>
      </div>

      <hr />

      <!-- Event Submit Button and Texts -->
      <button type="submit" class="btn btn-primary">Submit</button>
      <span class="submit_text" id="invalid_text">
        <span class="fas fa-exclamation-triangle ml-3 mr-1"></span>
        <span class="text">Invalid Field</span>
      </span>
      <span class="submit_text" id="valid_text">
        <span class="fas fa-check-circle ml-3 mr-1"></span>
        <span class="text">Submitted</span>
      </span>

    </form>
  </div>
</div>

<?php include("footer.php"); ?>