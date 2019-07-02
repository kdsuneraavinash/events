import { Component, OnInit } from '@angular/core';
import { Event } from '../event';
import { EventsService } from '../events.service';

@Component({
  selector: 'app-event-list',
  templateUrl: './event-list.component.html',
  styleUrls: ['./event-list.component.scss']
})
export class EventListComponent implements OnInit {
  events: Event[];

  constructor(public eventsService: EventsService) { }

  ngOnInit() {
    this.eventsService.getEvents().subscribe((e) => this.events = e);
  }
}
