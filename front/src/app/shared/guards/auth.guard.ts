import { Injectable } from '@angular/core';
import { CanActivate, Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { LocalStorage } from '../store/index';
import { Observable } from 'rxjs/Observable';
@Injectable()
export class AuthGuardService implements CanActivate {

  constructor(
    private localStorage: LocalStorage,
     private router: Router,
  ) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    if (this.localStorage.GetToken()) {
      if (state.url === '/' || state.url === '/login' || state.url === '/register') {
        this.router.navigate(['/app']);
      }
      return true;

    } else {
      // Allow route to './' to get authenticated
      if (state.url === '/' || state.url === '/login') {
        //  this.router.navigate(['/login']);
        return true;
      }

      // 	// Explicit navigation to any URL while not being authenticated
      this.localStorage.ClearStorage();
      this.router.navigate(['/login']);
      // return false;
    }
  }

  canActivateChild() {
    console.log('checking child route access');
    return true;
  }

}
