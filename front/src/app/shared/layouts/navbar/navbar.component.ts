import { Component, OnInit, ElementRef, NgZone} from '@angular/core';
import { Router } from '@angular/router';
import { LocalStorage } from '../../store';


@Component({
    selector: 'app-navbar',
    templateUrl: './navbar.component.html',
    styleUrls: ['./navbar.component.scss']
})

export class NavbarComponent implements OnInit {
    // Auth and related
    accountID = 0;

    constructor(
      private localStorage: LocalStorage,
      private router: Router,
    ) {
      this.accountID = JSON.parse(this.localStorage.GetProfile()).account.id;
    }

    ngOnInit() {

    }

    /**
     * View user's detail
     * @param {number} accountID
     * @param $event
     */
    viewUserDetail(accountID: number, $event) {
      $event.preventDefault();
      if (this.accountID !== accountID) {
        accountID = this.accountID;
      }

      console.log(accountID);
      this.router.navigateByUrl('/app/users/' + accountID.toString());
    }

    logout(e){
      e.preventDefault();
      this.localStorage.ClearStorage();
      this.router.navigateByUrl('/login');
    }
}
