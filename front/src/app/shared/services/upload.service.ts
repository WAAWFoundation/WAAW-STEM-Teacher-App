import { Injectable } from '@angular/core';
import {HttpHeaders, HttpClient} from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { handleErrors } from '../helpers/index';
import {Observable} from 'rxjs';
import {HeaderService} from './header.service';

@Injectable()

export class UploadService {
  fileHeaders: any;
  private headers = new HttpHeaders({}); // 'multipaxrt/form-data' 'Content-Type': undefined

  constructor(
    private http: HttpClient,
    private headerService: HeaderService
  ) {
    this.fileHeaders = this.headerService.getFileHeader();
  }

  /**
   *
   * @param data
   * @param url
   */
  fileUpload(data, url) {
    return this.http.post(environment.api.url + url, data, {headers: this.fileHeaders})
      .map((response) => {
        return response;
      });
  }

  // import {Http, RequestOptions} from '@angular/http';
  /**
   *
   * @param uploadUrl
   * @param file
   * @param {string} filename
   * @returns {Observable<any>}
   */
  // singleUpload(uploadUrl, file, filename = 'media') {
  //   const formData = new FormData();
  //   if (filename !== 'media') {
  //     formData.append(filename, file);
  //   } else {
  //     formData.append(filename, file);
  //   }
  //     // formData.append(file.name, file)
  //
  //     // Optional, append other kev:val rest data to the form.
  //     // Object.keys(restObj).forEach(key => {
  //     //   formData.append(key, restObj[key]);
  //     // });
  //     return this.http.post(environment.api.url + uploadUrl, formData, { headers: this.headers, reportProgress: true, observe: 'events'})
  //        .map((response) => {
  //             return <any>response.json().data;
  //         })
  //        .catch(handleErrors);
  //   }

  // import {Http, RequestOptions} from '@angular/http';
  /**
   *
   * @param uploadUrl
   * @param files
   * @returns {Observable<any>}
   */
  // multiUpload(uploadUrl, files): Observable<any> {
  //   const formData = new FormData();
  //     // Append files to the virtual form.
  //     for (const file of files) {
  //       formData.append(file.name, file);
  //     }
  //     // formData.append("image", fileBrowser.files[0]);
  //     // formData.append(file.name, file)
  //
  //     // Optional, append other kev:val rest data to the form.
  //     // Object.keys(restObj).forEach(key => {
  //     //   formData.append(key, restObj[key]);
  //     // });
  //     return this.http.post(uploadUrl, formData, { headers: this.headers})
  //        .map((response) => {
  //             return <any>response.json().data;
  //         })
  //        .catch(handleErrors);
  //   }

  // import {Http, RequestOptions} from '@angular/http';
  /**
   *
   * @param uploadUrl
   * @param files
   * @param {string} filename
   * @returns {Observable<any>}
   */
  // upload(uploadUrl, files, filename = 'media'): Observable<any> {
  //   // let url = uploadUrl; //`${ environment.api.url }${ this.domain } ` +
  //   const formData = new FormData();
  //   if (filename !== 'media') {
  //     formData.append(filename, files);
  //   } else {
  //     formData.append(filename, files);
  //   }
  //
  //   return this.http.post(uploadUrl, formData, { headers: this.headers })
  //     .map((response) => {
  //       return <any>response.json().data;
  //     })
  //     .catch(handleErrors);
  // }

   // filesToUpload: Array<File>;
    // upload() {
    //     this.makeFileRequest("http://localhost:3000/upload", [], this.filesToUpload).then((result) => {
    //         console.log(result);
    //     }, (error) => {
    //         console.error(error);
    //     });
    // }

    // fileChangeEvent(fileInput: any){
    //     this.filesToUpload = <Array<File>> fileInput.target.files;
    // }
}
