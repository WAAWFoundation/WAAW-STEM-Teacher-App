import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';

import { handleErrors } from '../../shared/helpers';
import { LocalStorage } from '../../shared/store';
import { HeaderService } from '../../shared/services';

@Injectable()
export class LevelsService {
  headers: any;

  constructor(
    private http: HttpClient,
    private localStorage: LocalStorage,
    private headerService: HeaderService
  ) {
    this.headers = this.headerService.getAuthHeader();
  }

  /**
   * Add a new curriculum level
   * @param data
   * @returns {Observable<any>}
   */
  public addLevel(data) {
    return this.http
      .post(environment.api.url + '/levels', data, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
    // .catch(handleErrors);
  }

  /**
   * Returns a list of curriculum levels
   * @returns {Observable<any>}
   */
  public levels() {
    return this.http.get(environment.api.url + '/levels', { headers: this.headers})
      .map((response: Response) => {
        return <any>response;
      });
  }

}
