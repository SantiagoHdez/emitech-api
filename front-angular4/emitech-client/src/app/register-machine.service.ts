import { Injectable } from '@angular/core';

@Injectable()
export class RegisterMachineService {

  private registerMachineActualProducts = new Array();

  constructor() { }

  add_new_product($product){
    var registered = false;
    for(let $productIterator of this.registerMachineActualProducts){
      if($productIterator.code == $product.code){
        registered = true;
        $productIterator.num_products++;
        break;
      }
        
    }
    if(!registered){
      $product["num_products"] = 1;
      this.registerMachineActualProducts.push($product);
      
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
    var payment = 0;
    for(let $product of this.registerMachineActualProducts){
      payment += $product.num_products*$product.price;
    }
    return payment;
  }

}
