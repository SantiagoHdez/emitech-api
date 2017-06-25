import { Component, OnInit } from '@angular/core';
import { CartService } from '../cart.service'
import { FormGroup, FormControl, Validators } from '@angular/forms';
import {ToastyService, ToastyConfig, ToastOptions, ToastData} from 'ng2-toasty';

@Component({
  selector: 'app-my-cart',
  templateUrl: './my-cart.component.html',
  styleUrls: ['./my-cart.component.css']
})
export class MyCartComponent implements OnInit {
  dropIdPending;
  cartProducts = []; 
  dropProductCart : FormGroup;
  precio_pagar = 0;

  paymentFormHtml : FormGroup;
  constructor(private cartService : CartService,private toastyService:ToastyService, private toastyConfig: ToastyConfig){
    this.toastyConfig.theme = 'bootstrap';
   }
  
  ngOnInit() {
    this.cartProducts =  this.cartService.get_cart_products();
    this.dropProductCart = new FormGroup({
      numProducts : new FormControl()
    });

    this.paymentFormHtml = new FormGroup({
      payment_method : new FormControl("",Validators.required)
    });
    this.calculate_price(this.cartProducts);
  }

  drop_product_pending = function($id){
    this.dropIdPending = $id;
    this.dropProductCart.reset({
      numProducts : this.cartProducts[$id].quantity
    });
  };

  drop_product = function(){
    console.log(this.cartProducts[this.dropIdPending])
    if(this.dropProductCart.controls.numProducts.value == this.cartProducts[this.dropIdPending].quantity){
      this.cartService.drop_product(this.cartProducts[this.dropIdPending].id).subscribe((data)=> {
        console.log(data)
        this.cartProducts.splice(this.dropIdPending, 1);
      this.toastyService.success("Se ha eliminado el producto.");
    
    });
    }else{
      this.cartProducts[this.dropIdPending].quantity = this.cartProducts[this.dropIdPending].quantity - this.dropProductCart.controls.numProducts.value;
      this.toastyService.success("Se han eliminado "+this.dropProductCart.controls.numProducts.value+" productos");
    }
    this.calculate_price(this.cartProducts); 
  };

  calculate_price = function($cartProducts){
    this.precio_pagar= 0;
    for(let producto of $cartProducts){
      this.precio_pagar += producto.quantity* producto.price;
    }
  };


  send_cart = function($formValues){
    this.cartService.send_payment_method_to_api($formValues).subscribe((data)=>{
      this.toastyService.success("Se ha hecho el pago correctamente");
    });    
  };


}
