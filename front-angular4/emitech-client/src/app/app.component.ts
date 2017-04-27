import { Component } from '@angular/core';
import { Router, Event } from '@angular/router';

@Component(
  {
    selector: 'navigation-component',
    templateUrl: './app.component.html',
  }
)
export class AppComponent {
  isIndex: boolean;
  actualPage : String;
  i = 0;
  constructor(private router: Router) {
  this.router.events.subscribe((event: Event) => {            
      if(this.i == 1)
        this.separateUrl(window.location.pathname);
      this.i++; 
  });
    
  }
  ngOnInit(){
    this.isIndex = true;
  }


  changeView(){
    this.isIndex = false;
    this.i = 0;
  }
  separateUrl($url){
    let url = $url.split('/');
    if(url[1] != "")
      this.isIndex = false;
    this.actualPage = url[1];
    
  }
}
