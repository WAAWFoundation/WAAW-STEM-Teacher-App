import { Injectable } from '@angular/core';
// import { ToastrService } from 'toastr-ng2';
import { environment } from '../../../environments/environment';

@Injectable()
export class LocalStorage {

  constructor() {}

  public SaveToken(token: string): void {
    window.localStorage.setItem('token', token);
  }

  public GetToken() {
    return window.localStorage.getItem('token');
  }

  public SaveProfile(profile: string): void {
    window.localStorage.setItem('profile', profile);
  }

  public GetProfile() {
    return window.localStorage.getItem('profile');
  }

  public ClearStorage(){
    window.localStorage.removeItem('token');
    window.localStorage.removeItem('profile');
  }

}
