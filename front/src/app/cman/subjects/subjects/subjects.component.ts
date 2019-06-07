import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { SubjectsService  } from '../subjects.service';
import { ToastService } from '../../../shared/services/index';
import { Router} from '@angular/router';
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';
import {LocalStorage} from '../../../shared/store';

@Component({
  selector: "app-subjects",
  templateUrl: "./subjects.component.html",
  styleUrls: ["./subjects.component.css"]
})
export class SubjectsComponent implements OnInit {
  // form
  subjectForm: FormGroup;

  // Data
  subjects = [];
  noSubjects = true;
  modalReference: any;
  account_id: string;
  textColors = ['text-primary', 'text-info', 'text-secondary', 'text-dark', 'text-success', 'text-warning', 'text-danger'];

  constructor(
    private fb: FormBuilder,
    private subjectsService: SubjectsService,
    private toastrService: ToastService,
    private router: Router,
    private modalService: NgbModal,
    private localStorage: LocalStorage
  ) {
    this.account_id = JSON.parse(this.localStorage.GetProfile()).account.id;
    this.subjectForm = fb.group({
      'name': [null, Validators.required],
      'code': [null, Validators.required],
      'account_id': [this.account_id]
    });
  }

  ngOnInit() {
    this.subjectsService.getSubjects().subscribe(
      response => {
        if (response.data) {
          if (response.data.length > 0) {
            this.subjects = response.data;
            this.noSubjects = false;
          }
        } else {
          this.toastrService.showError(response.error, 'Subjects could not be retrieved!');
        }
      }, (error) => this.toastrService.showError(error, 'Error in connection!'));
  }

  /**
   * Add a new subject and update UI
   * @param data
   */
  addNew(data) {
    this.subjectsService.addSubject({'subject': data}).subscribe((response) => {
      if (response !== false) {
        this.toastrService.showSuccess('Subject has been added', 'New Subject');
        this.subjects.push(response.data);
        this.modalReference.close();
      }
    }, (error) => {
      if (error.status === 422) {
        this.toastrService.showError('Please ensure to fill all field correctly', 'Validation Error');
      } else {
        this.toastrService.showError('An error just occurred. Please refresh the page and try again!', 'Error');
      }
    });
  }

  /**
   * Open modal to add a new subject
   * @param content
   */
  open(content) {
    this.modalReference = this.modalService.open(content, {ariaLabelledBy: 'createSubjectTitle'});
  }

  /**
   * Navigate to Subject details view
   * @param subject
   */
  details(subject) {
    this.router.navigate([`/app/subjects/${subject.id}`]);
  }

  /**
   * On click event to create a new subject
   */
  createSubject() {
    this.addNew(this.subjectForm.value);
  }

  /**
   * Search through list of subjects based on given query
   * @param query
   */
  onSearch(query) {}
}
