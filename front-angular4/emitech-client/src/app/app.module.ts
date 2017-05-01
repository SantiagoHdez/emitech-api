import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { ProductComponent } from './product/product.component';
import { UserComponent } from './user/user.component';

import { RouterModule } from '@angular/router'; // router 
// urls
import { UrlsRoutes } from './urls';

//services
import { ProductsService } from './products.service'

//alertas
import {ToastyModule} from 'ng2-toasty';

//animaciones

import { BrowserAnimationsModule } from '@angular/platform-browser/animations'

@NgModule({
  declarations: [
    AppComponent,
    ProductComponent,
    UserComponent
  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule,
    HttpModule,
    BrowserAnimationsModule,
    RouterModule.forRoot(new UrlsRoutes().getUrls()),
    ToastyModule.forRoot()
  ],
  providers: [ProductsService],
  bootstrap: [AppComponent]
})
export class AppModule { }
