import { Injectable } from '@angular/core';
import {Http, Headers, Response, URLSearchParams} from '@angular/http';

@Injectable()
export class UserService {
  url = "http://localhost:8000";
  user:string;
  password:string;
  client_id:string = "bIjauvdthxsCOV9odYVUngdP1ZuQFazbM8CgkJKV";
  client_secret:string = "hPDXoSatfNGFsJSWrdKIrzihbhUtVo9vk0gdKek5AGLsk61hP0wmbw241psT3OAAnd5RYJ9UEYuevxIaxrgS03cb7TrM7Q2W4McmkKkUjB3F4lVYqrRA4CIVB4lTMXrg";

  constructor(private http: Http) { }

  createAuthorizationHeader(headers: Headers) {
    headers.append('Content-Type', 'application/x-www-form-urlencoded');
  }

  createTokenHeader(headers : Headers){
    headers.append("Authorization" , "Bearer "+localStorage.getItem('token'));
  }

  set_user_and_password($user, $password){
    this.user = $user;
    this.password = $password;
  }

  get_token(){
    let headers = new Headers();
    this.createAuthorizationHeader(headers);
    console.log(headers);
    var $data = new URLSearchParams();
    $data.set('username', this.user);
    $data.set('password', this.password);
    $data.set('grant_type', 'password');
    $data.set('client_id' , this.client_id);
    $data.set('client_secret', this.client_secret);
    return this.http.post(this.url+"/o/token/" ,$data, {headers: headers})
    .map(this.extractData)
    .do(this.logData)
    .catch(this.catchError);

  }
 
 
  private catchError(error : Response | any){
    console.log(error); 
    return error.json();
  }
  private logData(res : Response){
    console.log(res);
  }
  private extractData(res : Response){
    return res.json();
  }

}
