import { Injectable } from '@angular/core';
// import { Headers, Http, RequestOptions, Response } from '@angular/http';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
// import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';

import { handleErrors } from '../../shared/helpers/index';
import { LocalStorage } from '../../shared/store/index';
import { HeaderService } from '../../shared/services/index';

@Injectable()
export class SubjectsService {

    headers: any;

    constructor(
        private http: HttpClient,
        private localStorage: LocalStorage,
        private headerService: HeaderService
    ) {
        this.headers = this.headerService.getAuthHeader();
    }


    public addSubject(data) {
        return this.http
            .post(environment.api.url + '/subjects', data, { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
        // .catch(handleErrors);
    }

    public getSubjects() {
        return this.http
            .get(environment.api.url + '/subjects', { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
    }

    public getSubjectDetails(id) {
        return this.http
            .get(environment.api.url + '/subjects/' + id, { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
    }






}
