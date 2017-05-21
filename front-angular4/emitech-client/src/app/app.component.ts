import { Component } from '@angular/core';
import { Router, Event, NavigationEnd} from '@angular/router';
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
      if(this.i == 1){
        if(event instanceof NavigationEnd ){
          this.separateUrl(event.url);
        }        
      }
        
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
    if(url[1] == "")
      this.isIndex = true;
    else 
      this.isIndex = false;
    this.actualPage = url[1];
    
  }
}
