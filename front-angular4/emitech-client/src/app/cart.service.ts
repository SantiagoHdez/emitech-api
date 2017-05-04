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
    $product["numProductos"] = this.numProductos;
    this.myCartProducts.push($product);
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
