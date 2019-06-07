import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';

import { handleErrors } from '../../shared/helpers';
import { LocalStorage } from '../../shared/store';
import { HeaderService } from '../../shared/services';

@Injectable()
export class ContentsService {
  headers: any;

  constructor(
    private http: HttpClient,
    private localStorage: LocalStorage,
    private headerService: HeaderService
  ) {
    this.headers = this.headerService.getAuthHeader();
  }

  /**
   *
   * @param data
   * @returns {Observable<any>}
   */
  public addTopicContent(data) {
    return this.http
      .post(environment.api.url + '/contents/', data, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
  }

  /**
   *
   * @param {number} topic_id
   * @returns {Observable<any>}
   */
  public getTopicContents(topic_id: number) {
    return this.http.get(environment.api.url + '/contents/topic/' + topic_id.toString(), {headers: this.headers})
      .map((response: Response) => {
        return <any>response;
      });
  }

  /**
   *
   * @param {number} content_id
   * @returns {Observable<any>}
   */
  public deleteTopicContent(content_id: number) {
    return this.http.delete(environment.api.url + '/contents/' + content_id.toString(), {headers: this.headers})
      .map((response: Response) => {
        return <any>response;
      });
  }

  public updateContent(content_id: number, data) {
    return this.http.put(environment.api.url + '/contents/' + content_id + '/body', data, {headers: this.headers})
      .map((response: Response) => {
      return <any>response;
    });
  }

  public addContentSection(content_id: number, data) {

  }
}
