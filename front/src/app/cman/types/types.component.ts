import { Component, OnInit } from '@angular/core';
import { TypesService } from './types.service';
import { Router} from '@angular/router';
import {NgbModal} from '@ng-bootstrap/ng-bootstrap';
import { LocalStorage } from '../../shared/store';
import {ToastService} from '../../shared/services';
import {FormControl, FormGroup, FormBuilder, ReactiveFormsModule, Validators, Form} from '@angular/forms';

@Component({
  selector: 'app-types',
  templateUrl: './types.component.html',
  styleUrls: ['./types.component.scss']
})
export class TypesComponent implements OnInit {
  types = [];
  typeForm: FormGroup;
  modalReference: any;
  account_id = 0;

  constructor(
    private fb: FormBuilder,
    private modal: NgbModal,
    private localStorage: LocalStorage,
    private typesService: TypesService,
    private toastrService: ToastService,
    private router: Router
  ) {
    this.account_id = JSON.parse(this.localStorage.GetProfile()).account.id;
    this.typeForm = fb.group({
      'name': [null, Validators.required],
      'type': [null, Validators.required],
      'account_id': [this.account_id, Validators.required]
    });
  }

  ngOnInit() {
    this.typesService.types().subscribe((response) => {
      if (response.data) {
        this.types = response.data;
      }
    }, (error) => {
      this.toastrService.showError(error, 'Cannot retrieve curriculums!');
    });
  }

  /**
   * Open modal window
   * @param content
   */
  open(content) {
    this.modalReference = this.modal.open(content, {ariaLabelledBy: 'createTypeTitle'});
  }

  /**
   * Add a new curriculum type
   * @param data
   * @returns {boolean}
   */
  addNewType(data) {
    if (data.name.length < 5) {
      alert('Name should be at least 5 characters!');
      return false;
    }

    data.type = data.name;
    this.typesService.addType({'curriculum_type': data}).subscribe((response) => {
      this.types.push(response.data);
      this.modalReference.dismiss();
    });
  }

  /**
   * View list of curriculums based on type
   * @param type
   */
  typeDetail(type) {
    this.router.navigateByUrl('/app/curriculums?type=' + type.id.toString());
  }

  onSearch(query){
    console.log(query);
  }
}
