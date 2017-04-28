import { Component, OnInit } from '@angular/core';
import { ProductsService }  from '../products.service';


@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit {
  dataFromService = [];
  constructor(private productsService: ProductsService) { 
  this.testHttp();
  }
  ngOnInit(){

  }
  testHttp(){
    this.productsService.getUsersTest().subscribe(data => this.dataFromService = data);
  }
  showData(){
    console.log(this.dataFromService);
  }

}
