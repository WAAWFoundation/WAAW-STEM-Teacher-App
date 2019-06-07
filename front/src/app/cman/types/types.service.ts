import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';

import { handleErrors } from '../../shared/helpers';
import { LocalStorage } from '../../shared/store';
import { HeaderService } from '../../shared/services';

@Injectable()
export class TypesService {
  headers: any;

  constructor(
    private http: HttpClient,
    private localStorage: LocalStorage,
    private headerService: HeaderService
  ) {
    // this.partner = localStorage.getPartner()
    this.headers = this.headerService.getAuthHeader();
  }

  /**
   * Add a new curriculum type
   * @param data
   * @returns {Observable<any>}
   */
  public addType(data) {
    return this.http
      .post(environment.api.url + '/curriculumtypes', data, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
    // .catch(handleErrors);
  }

  /**
   * Returns a list of curriculum types
   * @returns {Observable<any>}
   */
  public types() {
    return this.http.get(environment.api.url + '/curriculumtypes', { headers: this.headers})
      .map((response: Response) => {
        return <any>response;
      });
  }

}
