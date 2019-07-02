import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {
  activeNabarLink: NavbarLink;

  navbarLinks: NavbarLink[] = [
    new NavbarLink("Home", "/home"),
    new NavbarLink("Events", "/events"),
    new NavbarLink("Add Event", "/addevent"),
    new NavbarLink("About", "/about")
  ];

  constructor() { }

  ngOnInit() {
    this.activeNabarLink = this.navbarLinks[0];
  }

  onNavbarLinkClick(clickedNavbarLink: NavbarLink) {
    this.activeNabarLink = clickedNavbarLink;
  }

}

class NavbarLink {
  constructor(public text: string, public link: string = "#") { }
}