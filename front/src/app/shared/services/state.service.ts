import { Injectable } from '@angular/core';
import { Headers, Http, RequestOptions, Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';
import {
    handleErrors
} from '../helpers/index';
import { LocalStorage } from '../store/index';

@Injectable()
export class StateService {

  constructor(
      private http: Http,
      private localStorage: LocalStorage
  ) {}

  private headers = new Headers({ 'Content-Type': 'application/json'});


  GetStates(): Observable<any[]>{
    return this.http.get(`${ environment.api.url }/states`, { headers: this.headers})
      .map((response: Response) => {
          return <any>response.json().data;
      })
      .catch(handleErrors);
  }
}
