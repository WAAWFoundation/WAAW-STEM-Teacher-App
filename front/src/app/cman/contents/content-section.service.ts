import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { LocalStorage } from '../../shared/store';
import { HeaderService } from '../../shared/services';

@Injectable()
export class ContentSectionService {
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
  public addContentSection(data) {
    return this.http
      .post(environment.api.url + '/content-sections/', data, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
  }

  public updateContentSection(content_id: number, data){
    return this.http.put(environment.api.url + '/content-sections/' + content_id, data, { headers: this.headers })
      .map((response: Response) => {
        return <any>response;
      });
  }

  /**
   *
   * @param id
   * @returns {Observable<any>}
   */
  public getSectionContent(id) {
   return this.http.get(environment.api.url + '/content-sections/' + id.toString(), {headers: this.headers})
     .map((response: Response) => {
       return <any>response;
     });
  }

  /**
   * Delete a section of a topic
   * @param id
   * @returns {Observable<any>}
   */
  public deleteSectionContent(id) {
    return this.http.delete(environment.api.url + '/content-sections/' + id.toString(), {headers: this.headers})
      .map((response: Response) => {
        return <any>response;
      });
  }

  public getSectionsForContent(content_id) {}
}
