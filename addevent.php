<?php include("header.php"); ?>

<div class="container">
  <div class="card p-3 content">

    <!-- Title -->
    <h2>Fill this Form and Submit Event Details.</h2>
    <h4>
      <small>All fields are required.</small>
    </h4>
    <hr />

    <?php 
    if (!isset($_SESSION['uid'])){
      echo "<div class='alert alert-warning alert-dismissible fade show' role='alert'>
            You are not logged in. You <strong>must</strong> be logged in in order to submit an event.
            <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
              <span aria-hidden='true'>&times;</span>
            </button>
          </div>";
    }
    ?>

    <form onsubmit="return validate();" id="event_form" action="post.php" method="post">

      <!-- Event Name Text -->
      <div class="form-group">
        <label for="eventName">Event Name:</label>
        <input type="text" class="form-control addevent" id="eventName" name="eventName" placeholder="Event" />
      </div>

      <!-- Event Otganizer Text -->
      <div class="form-group">
        <label for="organizer">Organizer:</label>
        <input type="text" class="form-control addevent" id="organizer" name="organizer" placeholder="Organizing Society">
      </div>

      <!-- Event Description Text Area -->
      <div class="form-group">
        <label for="description">Description:</label>
        <textarea rows="5" class="form-control addevent" id="description" name="description" placeholder="Describe event and its purpose here"></textarea>
      </div>

      <br />

      <!-- Event Venue Text -->
      <div class="form-group">
        <label for="location">Venue:</label>
        <input type="text" class="form-control addevent" id="location" name="location" aria-describedby="locationHelp" placeholder="Venue"
        />
        <small class="form-text text-muted" id="locationHelp">
          If inside the university, mention location name. Otherwise include address of the location.
        </small>
      </div>

      <br />

      <!-- Event Start Date -->
      <div class="form-group">
        <label for="startDate">Start Date:</label>
        <input type="date" class="form-control addevent" id="startDate" name="startDate" />
      </div>

      <!-- Event End Date -->
      <div class="form-group">
        <label for="endDate">End Date:</label>
        <input type="date" class="form-control addevent" id="endDate" name="endDate" aria-describedby="dateHelp" />
        <small class="form-text text-muted" id="dateHelp">
          Event end date must be on or after start date.
        </small>
      </div>

      <br />

      <div class="form-group">
        <div class="custom-control custom-checkbox">
          <input type="checkbox" class="custom-control-input addevent" id="isAllDay" name="isAllDay" checked="checked" />
          <label for="isAllDay" class="custom-control-label">This is an all day event</label>
          <small class="form-text text-muted" id="allDayHelp">
            Check this if the item is an allday event and time cannot be specified exactly. If you uncheck this you can provide exact
            time.
          </small>
        </div>
      </div>

      <div class="collapse" id="collapseTimeSelect">
        <!-- Event Start Time -->
        <div class="form-group">
          <label for="startTime">Start Time:</label>
          <input type="time" class="form-control addevent-isallday" id="startTime" name="startTime" />
        </div>
        <!-- Event End Time -->
        <div class="form-group">
          <label for="endTime">End Time:</label>
          <input type="time" class="form-control addevent-isallday" id="endTime" name="endTime" aria-describedby="timeHelp" />
          <small class="form-text text-muted" id="timeHelp">
            Enter a general start/end time if time is not definite. Event end time must be at or after start time.
          </small>
        </div>
      </div>

      <br />

      <!-- Event Image Uploader -->
      <div class="form-group uploader">
        <a href="#" id="uploadImages">Please wait...</a>
        <small class="form-text text-muted" id="imagesHelp">
          Upload images to use in app. First image will be used as Cover Image.
        </small>
        <div class="feature_thumb"></div>
      </div>

      <br />

      <div class="form-group">
        <label for="tags">Tags:</label>
        <input type="text" class="form-control addevent" id="tags" name="tags" placeholder="sport gaming computer" aria-describedby="tagHelpTags"
        />
        <small class="form-text text-muted" id="tagHelpTags">
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