import { Injectable } from '@angular/core';
// import { Headers, Http, RequestOptions, Response } from '@angular/http';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
// import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';

import { handleErrors } from '../../shared/helpers';
import { LocalStorage } from '../../shared/store';
import { HeaderService } from '../../shared/services';

@Injectable()
export class TopicsService {

  headers: any;

  constructor(
    private http: HttpClient,
    private localStorage: LocalStorage,
    private headerService: HeaderService
  ) {
    this.headers = this.headerService.getAuthHeader();
  }

  /**
   * Add a new topic
   * @param data
   * @returns {Observable<any>}
   */
  public addTopic(data) {
    return this.http
      .post(environment.api.url + '/topics', data, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
    // .catch(handleErrors);
  }

  public editTopic(id, data) {
    return this.http
      .put(environment.api.url + '/topics/' + id, data, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
    // .catch(handleErrors);
  }

  /**
   * Get all topics for a given curriculum
   * @returns {Observable<any>}
   */
  public getTopics(curriculum_id) {
    return this.http
      .get(environment.api.url + '/topics', { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
  }

  /**
   * Get details for a given topic
   * @param id
   * @returns {Observable<any>}
   */
  public getTopicDetails(id) {
    return this.http
      .get(environment.api.url + '/topics/' + id, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
  }
}
