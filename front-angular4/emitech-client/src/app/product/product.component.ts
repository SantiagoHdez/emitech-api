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

  loading : boolean = true;
  registeredProducts = new Array();
  isSuggestedPrice: boolean = false; 
  addProductForm: FormGroup;
  idPendingProduct = 0;
  
  //busquedaProductos
  lookProduct : FormGroup;
  searchProducts = [];
  ProductIsSelected = false; 
  SelectedProduct;
  toUpdateProductId =0;
  modifyProductForm : FormGroup;

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
      units_aviable : new FormControl("", Validators.required),
      suggested_price : new FormControl()
    });

    this.lookProduct = new FormGroup({
      name : new FormControl("", Validators.required)
    });
  }
  getRegisteredProducts(){
    this.registeredProducts = new Array();
    this.loading = true;
    this.productsService.getRegisteredProducts().subscribe(data => this.registeredProducts = data);
    setTimeout(() => 
        this.loading = false
    , 1000);
  }
  showData(){
    console.log(this.registeredProducts);
  }

  add_suggested_price = function(){
    this.isSuggestedPrice = true;
  };

  add_product = function(product){
    if(!this.addProductForm.invalid){
      if(!this.isSuggestedPrice)
        delete product.suggested_price;
      this.productsService.addNewProduct(product).subscribe(() =>this.getRegisteredProducts());
      this.isSuggestedPrice = false; 
    }
    this.toastyService.wait("Se ha agregado correctamente el producto.");
  };

  set_pending_id = function($idProduct){
    this.idPendingProduct = $idProduct;
  }
  add_to_cart = function(){
    let numProductos = parseFloat((<HTMLInputElement>document.getElementById("numeroProducto"+this.idPendingProduct)).value);
    this.cartService.get_product(this.idPendingProduct,numProductos).subscribe((data) => {
      if(numProductos <= data.units_aviable){
        this.cartService.add_product(data);
        this.toastyService.success("Se ha agregado el producto a tus compras.Puedes ver tus productos registrados en el apartado 'Mi carrito'");
      }else{
        this.toastyService.error("No se ha podido agregar los productos a la compra, no existen unidades disponibles o estás excediendo el número de unidades disponibles.");
      }
      
    });
  };



  look_product = function($product){
    this.searchProducts = [];
    this.ProductIsSelected = false;
    if($product.name.length != 0){
      let regExx = new RegExp($product.name.toLowerCase());
      for(let producto of this.registeredProducts){
        if(producto.model.toLowerCase().search(regExx) != -1){
         this.searchProducts.push(producto);
        }
      }
    }
  };


  update_product = function(product){
    if(!this.modifyProductForm.invalid){
      if(!this.isSuggestedPrice)
        delete product.suggested_price;
      this.productsService.updateProduct(this.toUpdateProductId,product).subscribe(() => {
        this.getRegisteredProducts();
      });
      this.isSuggestedPrice = false; 
      this.toastyService.wait("Se ha modificado correctamente el producto.");
      this.reset_values_busqueda();
    }
  };
  
  show_data_selected_product = function($id){
    this.ProductIsSelected = true; 
    this.searchProducts = [];
    this.toUpdateProductId = $id;
    for(let producto of this.registeredProducts){
        if(producto.id == $id){
         this.SelectedProduct = producto;
        }
    }
    this.modifyProductForm = new FormGroup({
      name: new FormControl(this.SelectedProduct.name,Validators.required),
      model: new FormControl(this.SelectedProduct.model, Validators.required),
      code: new FormControl(this.SelectedProduct.code, Validators.required),
      price: new FormControl(this.SelectedProduct.price,Validators.required),
      units_aviable : new FormControl(this.SelectedProduct.units_aviable, Validators.required),
      suggested_price : new FormControl()
    });
  };
  reset_values_busqueda = function(){
    this.ProductIsSelected = false; 
    this.searchProducts = [];
  };

  async delay(ms: number) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

}
