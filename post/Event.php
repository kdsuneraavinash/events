<?php
class Event{
    public $eventName;
    public $organizer;
    public $location;
    public $description;
    public $startDate;
    public $endDate;
    public $startTime;
    public $endTime;
    public $isAllDay;
    public $tags;
    public $images;
    public $user;
    public $userid;

    public $tagsJSON;
    public $imagesJSON;
    public $isAllDayJSON;
    public $descriptionJSON;

    public $startDateTime;
    public $endDateTime;

    function __construct($post, $session){
        $this->eventName = $post['eventName'];
        $this->organizer = $post['organizer'];
        $this->location = $post['location'];
        
        $this->description = $post['description'];
        $this->description = str_replace("'", '"', $this->description);
        
        $this->startDate = $post['startDate'];
        $this->endDate = $post['endDate'];
        $this->isAllDay = array_key_exists('isAllDay', $post);
        $this->startTime = $post['startTime'];
        $this->endTime = $post['endTime'];
        $this->startTime = $this->isAllDay ? '00:00' : $this->startTime;
        $this->endTime = $this->isAllDay ? '23:59' : $this->endTime;
        
        // Remove spaces from elements
        $this->tags = explode(' ', strtolower($post['tags']));
        $this->tags = array_diff($this->tags, [' ']);
        $this->tags = array_values($this->tags);
        
        $this->images = !array_key_exists('uploaded_images', $post) ?  array() : $post['uploaded_images'];
        foreach ($this->images as $ind => $val) {
            $this->images[$ind] = "https://res.cloudinary.com/kdsuneraavinash/$val";
        }

        $this->tagsJSON = json_encode($this->tags);
        $this->imagesJSON = json_encode($this->images);
        $this->isAllDayJSON = json_encode($this->isAllDay == 1);
        $this->descriptionJSON = json_encode($this->description);
        
        // TODO: Add /n /r in description
        $this->startDateTime = date('Y-m-d H:i:s', strtotime("{$this->startDate} {$this->startTime}:00"));
        $this->endDateTime = date('Y-m-d H:i:s', strtotime("{$this->endDate} {$this->endTime}:00"));

        $this->user = $session["email"];
        $this->userid = $session["uid"];
    }

}

?>
