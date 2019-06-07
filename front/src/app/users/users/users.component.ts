import { Component, OnInit } from '@angular/core';
import { UsersService } from '../users.service';
import { ToastService } from '../../shared/services';
import { Router} from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import {FormGroup, FormBuilder, Validators} from '@angular/forms';


@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  users = [];
  noUsers = true;
  modalReference: any;
  userForm: FormGroup;

  constructor(
    private userService: UsersService,
    private toastrService: ToastService,
    private router: Router,
    private modal: NgbModal,
    private fb: FormBuilder,
  ) {
    this.userForm = fb.group({
      'email': [null, Validators.required],
      'password': [null, Validators.required],
      'confirm_password': [null, Validators.required],
      'first_name': [null, Validators.required],
      'last_name': [null, Validators.required],
      'other_name': [null],
      'phone': [null, Validators.required]
    });
  }

  ngOnInit() {
    this.userService.getUsers().subscribe(response => {
        if (response.data) {
          if (response.data) {
            this.users = response.data;
            this.noUsers = false;
          }
        } else {
          this.toastrService.showError(response.error,  'An Error Occurred');
        }

      }, (error) => {
        this.toastrService.showError(error, 'An Error Occurred');
      });
  }

  details(user) {
    this.router.navigate([`/app/users/${user.id}`]);
  }

  createUser() {
    const formData = this.userForm.value;
    if (formData.confirm_password !== formData.password) {
      this.toastrService.showError('Please ensure your passwords match and try again', 'Passwords Do Not Match');
      return false;
    }

    this.userService.newUser(formData).subscribe((response) => {
      if (response.data) {
        this.users.push(response.data);
        this.modalReference.dismiss();
        this.resetUserForm();
      }
    });
  }

  /**
   * Open a new modal
   * @param content
   */
  open(content) {
    this.modalReference = this.modal.open(content, {
      ariaLabelledBy: 'createUserTitle',
      keyboard: false,
      backdrop: 'static'
    });
  }

  /**
   * Reset the values of the user form
   */
  resetUserForm() {
    this.userForm.reset({
      'email': '',
      'password': '',
      'first_name': '',
      'last_name': '',
      'other_name': '',
      'phone': ''
    });
  }
}
