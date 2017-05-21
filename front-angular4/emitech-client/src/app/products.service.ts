import { Injectable } from '@angular/core';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Observable';

import { Http, Response } from '@angular/http';
@Injectable()
export class ProductsService {
  private url = "http://django-env.hsphtebmem.us-west-2.elasticbeanstalk.com";
  constructor(private http : Http ) {
  }
  
  getRegisteredProducts() {
    //return this.http.get("http://127.0.0.1:8000/products/?format=json")
    return this.http.get(this.url+"/products/?format=json")
    .map(this.extractData)
    .do(this.logData)
    .catch(this.catchError);
  }
  addNewProduct(product){
    //return this.http.post("http://127.0.0.1:8000/products/", product)
    return this.http.post(this.url+"/products/",product)
    .map(this.extractData)
    .do(this.logData)
    .catch(this.catchError);
  }
  updateProduct(id,product){
    //return this.http.put("http://127.0.0.1:8000/products/"+id+"/", product)
    return this.http.put(this.url+"/products/"+id+"/",product)
    .map(this.extractData)
    .do(this.logData)
    .catch(this.catchError);
  }


  private catchError(error : Response | any){
    console.log(error); 
    return Observable.throw(error.json().error || "Something happened");
  }
  private logData(res : Response){
    console.log(res);
  }
  private extractData(res : Response){
    return res.json();
  }

}
