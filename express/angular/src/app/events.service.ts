import { Injectable } from '@angular/core';
import { Event } from './event';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class EventsService {
  public getEvents(): Observable<Event[]> {
    return this.httpClient.get<Event[]>("/api/events");
  }

  public getEvent(id: string): Observable<Event> {
    return this.httpClient.get<Event>(`/api/event/${id}`);
  }

  constructor(private httpClient: HttpClient) { }
}

