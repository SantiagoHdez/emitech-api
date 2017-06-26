import { Component, OnInit } from '@angular/core';

//rubenmurga postcardfrom1952
//client id bIjauvdthxsCOV9odYVUngdP1ZuQFazbM8CgkJKV
//client secret hPDXoSatfNGFsJSWrdKIrzihbhUtVo9vk0gdKek5AGLsk61hP0wmbw241psT3OAAnd5RYJ9UEYuevxIaxrgS03cb7TrM7Q2W4McmkKkUjB3F4lVYqrRA4CIVB4lTMXrg

import { FormControl, FormGroup, Validators } from '@angular/forms'
import { ProductsService } from '../products.service';
import { ToastyService, ToastyConfig, ToastOptions, ToastData} from 'ng2-toasty';
import { RegisterMachineService } from '../register-machine.service';

@Component({
  selector: 'app-registermachine',
  templateUrl: './registermachine.component.html',
  styleUrls: ['./registermachine.component.css']
})
export class RegistermachineComponent implements OnInit {

  registerMachineInputForm : FormGroup;
  dropProductRegisterMachine : FormGroup;
  actualProducts = new Array();
  pending_id_to_drop = 0;
  payment_money = 0;
  constructor(private productService: ProductsService, private registerMachineService : RegisterMachineService,private toastyService:ToastyService) { }

  ngOnInit() {
    this.registerMachineInputForm = new FormGroup({
      codigo_barras: new FormControl()
    });

    this.dropProductRegisterMachine = new FormGroup({
      numProducts : new FormControl()
    });
  }

  look_for_product = function($formData){
    this.productService.getProductRegisterMachine($formData.codigo_barras).subscribe(($product) => {
      try{
        this.registerMachineService.add_new_product($product);
        this.actualProducts = this.registerMachineService.get_products();
        this.toastyService.success("Se ha agregado el producto " +$product.name);
        this.payment_money = this.registerMachineService.get_payment_mont();

      }catch($error){
        this.toastyService.error("No se ha podido agregar el producto.");
      }  
    });
    this.registerMachineInputForm.reset({
      codigo_barras: ""
    });
  }
  add_pending_to_drop_id = function($id){
    this.pending_id_to_drop = $id;
    console.log(this.pending_id_to_drop);
    this.dropProductRegisterMachine.reset({
      numProducts : this.actualProducts[$id].num_products
    });
  }

  drop_product = function($formValues){
    this.actualProducts = this.registerMachineService.drop_products(this.pending_id_to_drop, $formValues.numProducts);
    this.toastyService.success("Has eliminado "+ $formValues.numProducts + " productos.");
    this.payment_money = this.registerMachineService.get_payment_mont();
  }

  


  
}
