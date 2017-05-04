import { Component } from '@angular/core';
import { Router, Event } from '@angular/router';
import { FormControl, FormGroup, Validators } from '@angular/forms'


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
  logInForm : FormGroup;
  constructor(private router: Router) {
  this.router.events.subscribe((event: Event) => {            
      if(this.i == 1)
        this.separateUrl(window.location.pathname);
      this.i++; 
      }); 
  }
  ngOnInit(){
    this.isIndex = true;
    this.logInForm = new FormGroup({
      none : new FormControl()
    });
  }
  changeView(){
    this.isIndex = false;
    this.i = 0;
  }
  separateUrl($url){
    let url = $url.split('/');
    if(url[1] != "")
      this.isIndex = false;
    else 
      this.isIndex = true;
    this.actualPage = url[1];
    
  }
}
