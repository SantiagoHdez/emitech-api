import { Component, OnInit } from '@angular/core';
import { CartService } from '../cart.service'
import { FormGroup, FormControl } from '@angular/forms';
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
  constructor(private cartService : CartService,private toastyService:ToastyService, private toastyConfig: ToastyConfig){
    this.toastyConfig.theme = 'bootstrap';
   }
  
  ngOnInit() {
    this.cartProducts =  this.cartService.get_cart_products();
    console.log(this.cartProducts);
    this.dropProductCart = new FormGroup({
      numProducts : new FormControl()
    });
    this.calculate_price(this.cartProducts);
  }

  drop_product_pending = function($id){
    this.dropIdPending = $id;
    this.dropProductCart.reset({
      numProducts : this.cartProducts[$id].numProductos
    });
  };

  drop_product = function(){
    if(this.dropProductCart.controls.numProducts.value == this.cartProducts[this.dropIdPending].numProductos){
      this.cartProducts.splice(this.dropIdPending, 1);
      this.toastyService.success("Se ha eliminado el producto.");
    }else{
      this.cartProducts[this.dropIdPending].numProductos = this.cartProducts[this.dropIdPending].numProductos - this.dropProductCart.controls.numProducts.value;
      this.toastyService.success("Se han eliminado "+this.dropProductCart.controls.numProducts.value+" productos");
    }
    this.calculate_price(this.cartProducts); 
  };

  calculate_price = function($cartProducts){
    this.precio_pagar= 0;
    for(let producto of $cartProducts){
      this.precio_pagar += producto.numProductos* producto.price;
    }
  };


}
