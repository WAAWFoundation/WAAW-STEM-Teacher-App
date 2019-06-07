import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';

@Injectable()
export class ToastService {

    constructor(
        private toastr: ToastrService,
    ) {}

    public showSuccess(message, title, timeout=3000, position='toast-top-right', tapDismiss=false, closeButton=true) {
        this.toastr.success(message, title, {timeOut: timeout, positionClass: position, tapToDismiss: tapDismiss,
          closeButton: closeButton, enableHtml: true});
    }

    public showError(message, title, timeout=3000, position='toast-top-right', tapDismiss=false, closeButton=true) {
        this.toastr.error(message, title, {timeOut: timeout, positionClass: position, tapToDismiss: tapDismiss,
          closeButton: closeButton, enableHtml: true});
    }

    public showInfo(message, title, timeout=3000, position='toast-top-right', tapDismiss=false, closeButton=true) {
        this.toastr.info(message, title, {timeOut: timeout, positionClass: position, tapToDismiss: tapDismiss,
          closeButton: closeButton, enableHtml: true});
    }
}


// constructor(private toastr: ToastrService) { }

// showSuccess() {
//     this.toastr.success('Hello world!', 'Toastr fun!');
// }
