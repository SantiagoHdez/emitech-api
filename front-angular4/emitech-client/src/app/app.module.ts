import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { ProductComponent } from './product/product.component';
import { UserComponent } from './user/user.component';

import { RouterModule } from '@angular/router'; // router 
// urls
import { UrlsRoutes } from './urls';

@NgModule({
  declarations: [
    AppComponent,
    ProductComponent,
    UserComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    RouterModule.forRoot(new UrlsRoutes().getUrls()),
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
