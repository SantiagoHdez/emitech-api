import { ProductComponent } from './product/product.component';
import { UserComponent } from './user/user.component';
import { MyCartComponent } from './my-cart/my-cart.component';
import { RegistermachineComponent } from './registermachine/registermachine.component'
import { Component } from '@angular/core';
export let routerUrls = [
      {
        path : 'products', 
        component : ProductComponent
      },
      {
        path : 'user', 
        component : UserComponent
      },
      {
        path : 'my-cart', 
        component : MyCartComponent
      },
      {
        path : 'register-machine',
        component : RegistermachineComponent
      }
  ];
