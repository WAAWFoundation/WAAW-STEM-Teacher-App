import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { LocalStorage } from '../shared/store/index';
import { HeaderService } from '../shared/services/index';

@Injectable()
export class UsersService {
    headers: any;

    constructor(
        private http: HttpClient,
        private localStorage: LocalStorage,
        private headerService: HeaderService
    ) {
        this.headers = this.headerService.getAuthHeader();
    }

    /**
     * Create a new user
     * @param data
     * @returns {Observable<any>}
     */
    public newUser(data) {
      return this.http.post(environment.api.url + '/users', data, { headers: this.headers })
        .map((response: Response) => {
          return <any>response;
        });
    }

    /**
     * Return a list of all users
     * @returns {Observable<any>}
     */
    public getUsers() {
        return this.http.get(environment.api.url + '/users', { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
    }

    /**
     * Get the details foe a given user
     * @param id
     * @returns {Observable<any>}
     */
    public getUserDetails(id) {
        return this.http.get(environment.api.url + '/users/' + id, { headers: this.headers })
            .map((response: Response) => {
                return <any>response;
            });
    }
}
