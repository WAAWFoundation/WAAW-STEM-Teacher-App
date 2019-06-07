import { Injectable} from '@angular/core';
// import { Headers, Http, RequestOptions, Response } from '@angular/http';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
// import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';

import { handleErrors } from '../../shared/helpers';
import { LocalStorage } from '../../shared/store';
import { HeaderService } from '../../shared/services';

@Injectable()
export class CurriculumService{

    headers: any;

    constructor(
        private http: HttpClient,
        private localStorage: LocalStorage,
        private headerService: HeaderService
    ) {
        this.headers = this.headerService.getAuthHeader();
    }

    public addCurriculum(data) {
        return this.http
            .post(environment.api.url + '/curriculums' , data, { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
    }

    

    public getCurriculums() {
      return this.http.get(environment.api.url + '/curriculums', {headers: this.headers})
        .map((response: Response) => {
          return <any>response;
        });
    }
    

    public getStats() {
        if (this.headers != null){
        return this.http.get(environment.api.url + '/dashboard', { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
        }
    }

    public getCurriculum(id: number) {
      return this.http.get(environment.api.url + '/curriculums/' + id.toString(), {headers: this.headers})
        .map((response: Response) => {
          return <any>response;
        });
    }

    public daleteCurriculums(id: number) {
        return this.http.delete(environment.api.url + '/curriculums/' + id.toString(), { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
    }



     jsonk(){
       var j =  [
            {
            "type": "text",
            "content": "text",
            }
            ]
        
    }


}
