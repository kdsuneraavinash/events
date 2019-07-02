import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.scss']
})
export class FooterComponent implements OnInit {
  footerIcons: FooterIcon[] = [
    new FooterIcon("fb-ic", "facebook"),
    new FooterIcon("tw-ic", "twitter"),
    new FooterIcon("li-ic", "linkedin"),
    new FooterIcon("ins-ic", "instagram"),
  ];

  constructor() { }

  ngOnInit() {
  }

}

class FooterIcon {
  constructor(public className: string, public iconName: string, public linkAddress: string = "") { }
}