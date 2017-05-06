import { Component, OnInit } from '@angular/core';
import { CartService } from '../cart.service'

@Component({
  selector: 'app-my-cart',
  templateUrl: './my-cart.component.html',
  styleUrls: ['./my-cart.component.css']
})
export class MyCartComponent implements OnInit {
  dropIdPending;
  cartProducts = []; 
  constructor(private cartService : CartService) { }
  
  ngOnInit() {
    this.cartProducts =  this.cartService.get_cart_products();
    console.log(this.cartProducts);
  }

  drop_product_pending = function($id){
    this.dropIdPending = $id;
  };

  drop_product = function(){
    this.cartProducts.splice(this.dropIdPending, 1);
  };


}
