import { Component, OnInit } from '@angular/core';
import { ProductsService }  from '../products.service';
import { CartService } from '../cart.service';

import { FormControl, FormGroup, Validators } from '@angular/forms'
import {ToastyService, ToastyConfig, ToastOptions, ToastData} from 'ng2-toasty';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit {
  registeredProducts = [];
  isSuggestedPrice: boolean = false; 
  addProductForm: FormGroup;
  idPendingProduct = 0;
  

  constructor(private productsService: ProductsService,private toastyService:ToastyService, private toastyConfig: ToastyConfig, private cartService : CartService) {
    this.toastyConfig.theme = 'bootstrap';
  }
  ngOnInit(){
    this.getRegisteredProducts();
    this.addProductForm = new FormGroup({
      name: new FormControl("",Validators.required),
      model: new FormControl("", Validators.required),
      code: new FormControl("", Validators.required),
      price: new FormControl("",Validators.required),
      suggested_price : new FormControl()
    });
  }
  getRegisteredProducts(){
    this.productsService.getRegisteredProducts().subscribe(data => this.registeredProducts = data);
  }
  showData(){
    console.log(this.registeredProducts);
  }

  add_suggested_price = function(){
    this.isSuggestedPrice = true;
  };

  add_product = function(product){
    console.log(this.addProductForm.controls.name);
    if(!this.addProductForm.invalid){
      if(!this.isSuggestedPrice)
        delete product.suggested_price;
      this.productsService.addNewProduct(product).subscribe(data => console.log(data));
      this.isSuggestedPrice = false; 
      this.getRegisteredProducts();
    }
    this.toastyService.wait("Se ha agregado correctamente el producto.");
  };

  set_pending_id = function($idProduct){
    this.idPendingProduct = $idProduct;
  }
  add_to_cart = function(){
    let numProductos = parseFloat((<HTMLInputElement>document.getElementById("numeroProducto"+this.idPendingProduct)).value);
    this.cartService.get_product(this.idPendingProduct,numProductos).subscribe((data) => this.cartService.add_product(data));
    this.toastyService.success("Se ha agregado el producto a tus compras.Puedes ver tus productos registrados en el apartado 'Mi carrito'");
  };

}
