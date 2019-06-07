// import { Component, OnInit } from '@angular/core';
// import * as $ from 'jquery';
// @Component({
//   selector: 'app-root',
//   templateUrl: './app.component.html',
//   styleUrls: ['./app.component.scss']
// })

// export class AppComponent implements OnInit {
//   title = 'Look jQuery Animation working in action!';

//   public ngOnInit() {
//     $(document).ready(function () {
//      alert("fdfdfdfdf");
//     });
//   }
// }

import { Component } from '@angular/core';
// import { ToastService } from "./shared/services/toastr.service";

// @Component({
//   selector: 'app-root',
//   templateUrl: './app.component.html',
//   styleUrls: ['./app.component.css']
// })



// export class AppComponent {
//   title = 'app';
// }

@Component({
  selector: 'body',
  template: '<router-outlet></router-outlet>'
})
export class AppComponent {
  constructor() {
  }
}

