import { Component } from '@angular/core';
import { Router, Event, NavigationEnd} from '@angular/router';
import { FormControl, FormGroup, Validators } from '@angular/forms'
import { UserService } from './user.service';
import { ToastyService } from 'ng2-toasty';

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
  constructor(private router: Router, private userService: UserService, private toasty: ToastyService) {
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
      username : new FormControl(),
      password : new FormControl()
    });
  }

  log_in = function($formValues){
    this.userService.set_user_and_password($formValues.username, $formValues.password);
    this.userService.get_token().subscribe(($data)=>{
      if($data.access_token){
        localStorage.setItem('token', $data.access_token);
        localStorage.setItem('user', $formValues.username);
        this.toasty.success("Ya estás identificado ante el sistema.");

      }
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
