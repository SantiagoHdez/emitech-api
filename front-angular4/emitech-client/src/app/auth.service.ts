import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import 'rxjs/add/operator/filter';
import * as auth0 from 'auth0-js';


@Injectable()
export class AuthService {
  auth0 = new auth0.WebAuth({
    clientID: 'bIjauvdthxsCOV9odYVUngdP1ZuQFazbM8CgkJKV',
    domain: 'http://localhost:8000',
    responseType: 'token id_token',
    audience: 'http://localhost:8000/o/userinfo',
    redirectUri: 'http://localhost:4200/',      
    scope: 'openid'
  });

  constructor(public router: Router) { }

  public login(): void {
    this.auth0.authorize();
  }

}
