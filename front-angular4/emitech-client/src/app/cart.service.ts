import { Injectable } from '@angular/core';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Observable';

import { Http, Response } from '@angular/http';


@Injectable()
export class CartService {

  private myCartProducts = [];
  private numProductos = 0;
  constructor(private http:Http) { }


  public get_product($id,$numProductos){
    this.numProductos = $numProductos;
    let url = "http://127.0.0.1:8000/products/"+$id+"/?format=json";
    return this.http.get(url)
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
    let url = "http://127.0.0.1:8000/cart/1/";
      delete $product.name;
      delete $product.model;
      delete $product.price;
      delete $product.suggested_price;
      delete $product.units_aviable;
      delete $product.code;
      $product['product_id'] = $product.id;
      delete $product.id;      
      return this.http.post(url,$product)
      .map(this.extractData)
      .catch(this.catchError);
    //return this.http.post(url,$product)
    //.map(this.extractData)
    //.catch(this.catchError);
  }

  public send_payment_method_to_api($method){
    let url = "http://127.0.0.1:8000/cart/1/ops/";
    return this.http.post(url,$method)
    .map(this.extractData)
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
