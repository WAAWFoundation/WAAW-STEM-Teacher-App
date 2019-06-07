import { Injectable } from '@angular/core';
// import { Headers, Http, RequestOptions, Response } from '@angular/http';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
// import { Observable } from 'rxjs/Rx';
import { environment } from '../../environments/environment';
import { handleErrors } from '../shared/helpers';
import { LocalStorage } from '../shared/store';
import { HeaderService } from '../shared/services';

@Injectable()
export class AuthService {
    headers: any;

    constructor(
        private http: HttpClient,
        private headerService: HeaderService,
        private localStorage: LocalStorage
    ) {
        this.headers = this.headerService.getAuthHeader();
    }

    /**
     *
     * @param data
     * @returns {Observable<any>}
     * @constructor
     */
    public Authenticate(data) {
        return this.http.post(environment.api.url + '/login', data, { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
    }

    /**
     *
     * @param data
     * @returns {Observable<any>}
     * @constructor
     */
    public signup(data) {
       return this.http.post(environment.api.url, data, { headers: this.headers })
          .map((response: Response) => {
              return <any>response;
          });
    }

  /**
   * Remove profile and token from storage
   */
  public logout() {
      this.localStorage.ClearStorage();
    }
}
