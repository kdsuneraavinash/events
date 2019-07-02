import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Event } from '../event';
import { EventsService } from '../events.service';

@Component({
  selector: 'app-event-page',
  templateUrl: './event-page.component.html',
  styleUrls: ['./event-page.component.scss']
})
export class EventPageComponent implements OnInit {
  eventId: string;
  event: Event;

  constructor(private route: ActivatedRoute, public eventsService: EventsService) {
  }

  ngOnInit() {
    this.route.paramMap.subscribe((v) => this.loadEvent(v));
  }

  loadEvent(params: ParamMap) {
    this.eventId = params.get('id');
    this.eventsService.getEvent(this.eventId).subscribe((v) => this.event = v);
  }

}
