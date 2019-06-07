import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormControl, FormGroup, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../auth.service';
import { ToastService } from '../../shared/services';
import { LocalStorage } from '../../shared/store';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  // form
  loginForm: FormGroup;
  forgetForm: FormGroup;

  flipped = false;
  post: any;
  submitPending = false;
  private password = '';
  private email = '';

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private authService: AuthService,
    private localStorage: LocalStorage,
    private toastrService: ToastService
  ) {

    this.loginForm = fb.group({
      'email': [null, Validators.required],
      'password': [null, Validators.compose([Validators.required])]
    });

    this.forgetForm = fb.group({
      'email': [null, Validators.required],
    });
  }

  ngOnInit() {
  }

  addNew(data) {
    this.submitPending = true;
    this.authService.Authenticate(data)
      .subscribe(response => {
        if (response.token) {
          this.toastrService.showSuccess('You\'ll be redirected in a moment.', 'Login successful');
          this._handleRequest(response);
          // this.updateUI();
          this.submitPending = false;
        } else {
          // if user login fails, trigger toastr error here with
          // response.error
          // this.updateUI();
          this.toastrService.showError(response.error, 'Login failed');
          this.submitPending = false;
          this.router.navigate(['/login']);
        }
      }, (error) => {
        // this.updateUI();
        this.toastrService.showError(error, 'Login failed');
        this.submitPending = false;
        this.router.navigate(['/login']);
      });
  }

  // onuw4478
  private _handleRequest(response) {
    // log current logged in user token and details on local storage.
    this.localStorage.SaveProfile(JSON.stringify(response.user));
    this.localStorage.SaveToken(response.token);
    this.router.navigateByUrl('/app');
  }
}
