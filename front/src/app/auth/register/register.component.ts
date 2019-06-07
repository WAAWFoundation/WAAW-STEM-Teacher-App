import { Component, OnInit } from '@angular/core';

import { Router } from "@angular/router";
import { AuthService } from "../auth.service";
import { ToastService } from '../../shared/services/index';
import { LocalStorage } from '../../shared/store/index';

import { FormControl, FormGroup, FormBuilder, ReactiveFormsModule, Validators } from "@angular/forms";
@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {



  //form
  newForm: FormGroup;

  responseConfirm: boolean = false;
  post: any
  cac: any = "rerer"
  licience: any = "dddd"
  step1: boolean = true;
  step2: boolean = false;

  submitPending: boolean = false;

  private first_name: string = "";
  private last_name: string = "";
  private password: string = "";
  private email: string = "";
  private company_name: string = "";
  private company_address: string = "";
  private phone: string = "";
  private website: string = "";
  private support_email: string = "";
  private support_phone: string = "";



constructor(
  private fb: FormBuilder,
  private localStorage: LocalStorage,
  private toastrService: ToastService,
  private authService: AuthService,
  private router: Router
) {

  this.newForm = fb.group({
    "first_name": [null, Validators.required],
    "last_name": [null, Validators.required],
    "email": [null, Validators.required],
    "phone": [null, Validators.required],
    "company_name": [null, Validators.required],
    "terms": [null, Validators.required],
    "password": [null, Validators.compose([Validators.required, Validators.minLength(6)])]
  })
}

  ngOnInit() {
  }


  addNew(data){
    let partner = { "partner": data };
    this.submitPending = true;

    this.authService.signup(partner)
      .subscribe(response => {
        if (response.data) {
          this.responseConfirm = true;
          this.toastrService.showSuccess("Please check your email to verify account!", "signup successful");
          this.submitPending = false;
        }else {
          this.toastrService.showError(response.error, "Login failed");
          this.submitPending = false;
          this.router.navigate(['/register'])
        }
      },(error) => {
        this.toastrService.showError(error, "Login failed");
        this.submitPending = false;
        this.router.navigate(['/register'])
      })
  }

  // onuw4478
  private _handleRequest(response) {

    console.log(response);
    // // log current logged in user token and details on local storage.
    this.localStorage.SaveProfile(JSON.stringify(response.data));
    this.localStorage.SaveToken(response.token);
    // this.router.navigate(['/app/dashboard']);
    this.router.navigateByUrl('/app', { skipLocationChange: true });

  }

}



