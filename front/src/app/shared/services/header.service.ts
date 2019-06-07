///<reference path="../../../../node_modules/@angular/common/http/src/headers.d.ts"/>
import { Injectable } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { LocalStorage } from '../store';


@Injectable()
export class HeaderService {
    token: string;
    constructor(
        private localStorage: LocalStorage
     ) {
        this.token = localStorage.GetToken();
     }

    public getHeader() {
      return new HttpHeaders({'Content-Type': 'application/json'});
    }

    public getAuthHeader() {
      return new HttpHeaders({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + this.token});
    }

    public getFileHeader() {
      return new HttpHeaders({'Authorization': 'Bearer ' + this.token});
    }
}

