import { Component, OnInit } from '@angular/core';
import { ProductsService }  from '../products.service';
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
  

  constructor(private productsService: ProductsService,private toastyService:ToastyService, private toastyConfig: ToastyConfig) {
    this.toastyConfig.theme = 'material';
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
    this.toastyService.wait("hola");
  };

}
