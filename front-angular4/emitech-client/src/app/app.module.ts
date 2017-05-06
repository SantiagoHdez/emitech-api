import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { ProductComponent } from './product/product.component';
import { UserComponent } from './user/user.component';

import { RouterModule } from '@angular/router'; // router 
// urls
import { routerUrls } from './urls';

//services
import { ProductsService } from './products.service';
import { CartService } from './cart.service';


//alertas
import {ToastyModule} from 'ng2-toasty';

//animaciones

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MyCartComponent } from './my-cart/my-cart.component'

@NgModule({
  declarations: [
    AppComponent,
    ProductComponent,
    UserComponent,
    MyCartComponent
  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule,
    HttpModule,
    BrowserAnimationsModule,
    RouterModule.forRoot(routerUrls),
    ToastyModule.forRoot()
  ],
  providers: [ProductsService,CartService],
  bootstrap: [AppComponent]
})
export class AppModule { }
