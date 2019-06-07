import { Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';

export function handleErrors(error: Response) {
     switch (error.status) {
        case 500:
          return Observable.throw(error.json().message);
        case 404:
          return Observable.throw(error.json().message);
        case 400:
          return Observable.throw(error.json().message);
        case 501:
          return Observable.throw(error.json().message);
        case 422:
         // TODO: find ways to display the validation message better
         //  Unprocessable Entity ( likely form validation error )
         // console.log(error);
         // return Observable.throw(error.json().message);
         let stringError  = '';
          for (const i in error.json().errors) {
              //console.log(i);
              stringError = stringError + i;
          }
          // return Observable.throw( "Validation Error: "+JSON.stringify(error.json().errors));
          return Observable.throw('Validation Error: ' + stringError);

        default:
          return Observable.throw('We could not perform the requested action at this time. Please check your network connectivity.');
     }
   }

export function getRandomIntInclusive(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min; // The maximum is inclusive and the minimum is inclusive
}
