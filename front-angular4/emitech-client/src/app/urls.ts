import { ProductComponent } from './product/product.component';
import { UserComponent } from './user/user.component';
export class UrlsRoutes {
  private routerUrls = [
      {
        path : 'products', 
        component : ProductComponent
      },
      {
        path : 'user', 
        component : UserComponent
      }
  ];
  public getUrls(){
    return this.routerUrls;
  }
}