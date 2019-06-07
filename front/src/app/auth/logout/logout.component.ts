import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LocalStorage } from '../../shared/store';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.scss']
})
export class LogoutComponent implements OnInit {

  constructor(
    private router: Router,
    private localStorage: LocalStorage
  ) {
    this.localStorage.ClearStorage();
    this.router.navigateByUrl('/login');
  }

  ngOnInit() {
  }

}
