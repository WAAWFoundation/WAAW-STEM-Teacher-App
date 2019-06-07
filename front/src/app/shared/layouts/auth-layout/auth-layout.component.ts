import { Component, OnInit } from '@angular/core';

// @Component({
//   selector: 'app-auth-layout',
//   templateUrl: './auth-layout.component.html',
//   styleUrls: ['./auth-layout.component.css']
// })
// export class AuthLayoutComponent implements OnInit {

//   constructor() { }

//   ngOnInit() {
//   }

// }

@Component({
  selector: 'app-public',
  template: '<router-outlet></router-outlet>',
})

export class AuthLayoutComponent implements OnInit {

  constructor() { }

  ngOnInit() { }
}