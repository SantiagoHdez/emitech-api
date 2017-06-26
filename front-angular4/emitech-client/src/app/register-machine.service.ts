import { Injectable } from '@angular/core';
import { CartService } from './cart.service';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import { UserService } from './user.service';

@Injectable()
export class RegisterMachineService {

  private registerMachineActualProducts = new Array();

  private url = "http://localhost:8000";

  payment = 0;

  constructor(private cartService: CartService, private http: Http, private auth:UserService) { }

  private send_cart_to_api($product){
        let $product_delete = Object.create($product);
        $product_delete["quantity"] = 1;
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

  add_new_product($product){
    var registered = false;

    for(let $productIterator of this.registerMachineActualProducts){
      if($productIterator.code == $product.code){
        registered = true;
        this.cartService.get_product($product.id,$productIterator.num_products).subscribe((data) => {
          if($productIterator.num_products <= data.units_aviable){
            $productIterator.num_products++;
            this.send_cart_to_api($productIterator).subscribe(($data)=>{
              console.log($data);
              this.payment = $data.total_cost;
            });
          }
        });
        break;
      }
        
    }
    if(!registered){
      $product["num_products"] = 1;
      this.cartService.get_product($product.id,$product.num_products).subscribe((data) => {
          if($product.num_products <= data.units_aviable){
            this.registerMachineActualProducts.push($product);
            this.send_cart_to_api($product).subscribe(($data)=>{
              console.log($data);
              this.payment = $data.total_cost;
            });
          }
        });
      
    }
  }

  get_products(){
    return this.registerMachineActualProducts;
  }

  drop_products($id, $products_to_drop){
    this.registerMachineActualProducts[$id].num_products -= $products_to_drop;
    if(this.registerMachineActualProducts[$id].num_products <= 0){
      this.registerMachineActualProducts.splice($id, 1);
    }
    return this.registerMachineActualProducts; 
  }

  get_payment_mont(){
    
    return this.payment;
  }


  private drop_product_api($id){
    let producto = {"product_id": String($id)};
    let headers = new Headers({ 'Content-Type': 'application/json' });
    this.auth.createTokenHeader(headers);
    let options = new RequestOptions({ headers: headers, body: JSON.stringify({"product_id": String($id)}) });
    return this.http.delete(this.url+"/cart/", options)
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
