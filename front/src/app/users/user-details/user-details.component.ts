import { Component, OnInit } from '@angular/core';
import { UsersService } from '../users.service';
import { ToastService } from '../../shared/services';
import { Router, ActivatedRoute } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-user-details',
  templateUrl: './user-details.component.html',
  styleUrls: ['./user-details.component.css']
})
export class UserDetailsComponent implements OnInit {
  user: any;
  modalReference: any;

  constructor(
    private userService: UsersService,
    private toastrService: ToastService,
    private router: Router,
    private snapshot: ActivatedRoute,
    private modal: NgbModal
  ) {
    const id = this.snapshot.snapshot.params['id'];
    this.userService.getUserDetails(id).subscribe(
      response => {
        if (response.data) {
          if (response.data) {
            this.user = response.data;
          }
        } else {
          this.toastrService.showError(response.error, 'Failed');
        }
      },
      error => {
        this.toastrService.showError(error, 'Failed');
      }
    );
  }

  ngOnInit() {}
}
