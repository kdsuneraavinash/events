import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomePageComponent } from './home-page/home-page.component';
import { EventListComponent } from './event-list/event-list.component';
import { EventPageComponent } from './event-page/event-page.component';
import { LocationStrategy, HashLocationStrategy } from '@angular/common';

const routes: Routes = [
  { path: 'home', component: HomePageComponent },
  { path: 'events', component: EventListComponent },
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'event/:id', component: EventPageComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule],
})
export class AppRoutingModule { }
