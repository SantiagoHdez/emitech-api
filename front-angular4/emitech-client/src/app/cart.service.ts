import { Injectable } from '@angular/core';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Observable';

import { Http, Response, Headers, RequestOptions } from '@angular/http';
import { UserService } from './user.service';

@Injectable()
export class CartService {

  private myCartProducts = [];
  private numProductos = 0;
  private url = "http://django-env.hsphtebmem.us-west-2.elasticbeanstalk.com";
  constructor(private http:Http, private auth: UserService) { }


  public get_product($id,$numProductos){
    this.numProductos = $numProductos;
    //let url = "http://127.0.0.1:8000/products/"+$id+"/?format=json";
    let headers = new Headers();
    this.auth.createTokenHeader(headers);
    return this.http.get(this.url+"/products/"+$id+"/?format=json")
    .map(this.extractData)
    .catch(this.catchError);
  }

  public add_product($product){
    $product["quantity"] = this.numProductos;
    this.myCartProducts.push($product);
    this.send_cart_to_api($product).subscribe((data)=>console.log(data));    
  }

  public get_cart_products(){
    return this.myCartProducts;
  }

  public send_cart_to_api($product){
      let $product_delete = Object.create($product);
      //let url = "http://127.0.0.1:8000/cart/1/";
      let headers = new Headers();
      this.auth.createTokenHeader(headers);
      delete $product_delete.name;
      delete $product_delete.model;
      delete $product_delete.price;
      delete $product_delete.suggested_price;
      delete $product_delete.units_aviable;
      delete $product_delete.code;
      $product_delete['product_id'] = $product.id;
      delete $product_delete.id;      
      return this.http.post(this.url+"/cart/",$product_delete, {headers:headers})
      .map(this.extractData)
      .catch(this.catchError);
  }

  public send_payment_method_to_api($method){
    //let url = "http://127.0.0.1:8000/cart/1/ops/";
    let headers = new Headers();
    this.auth.createTokenHeader(headers);
    return this.http.post(this.url+"/cart/1/ops/",$method, {headers:headers})
    .map(this.extractData)
    .catch(this.catchError);

  }
  public drop_product($id){
    let producto = {"product_id": String($id)};
    let headers = new Headers({ 'Content-Type': 'application/json' });
    this.auth.createTokenHeader(headers);
    let options = new RequestOptions({ headers: headers, body: JSON.stringify({"product_id": String($id)}) });
    return this.http.delete(this.url+"/cart/1/", options)
    .map(this.extractData)
    .catch(this.catchError);
  }


  private catchError(error : Response | any){
    console.log(error); 
    //return Observable.throw(error.json().error || "Something happened");
    return error.json();
  }
  private logData(res : Response){
    console.log(res);
  }
  private extractData(res : Response){
    return res.json();
  }
}
