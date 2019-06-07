import { Component, OnInit } from '@angular/core';
import { SubjectsService } from '../subjects.service';
import { ToastService } from '../../../shared/services/index';
import { CurriculumService } from '../../curriculums/curriculum.service';
import { LevelsService } from '../../levels/levels.service';
import { TypesService } from '../../types/types.service';
import { Router, ActivatedRoute } from '@angular/router';
import {NgbModal} from '@ng-bootstrap/ng-bootstrap';
import { FormControl, FormGroup, FormBuilder, Validators } from '@angular/forms';
import { LocalStorage } from '../../../shared/store';


@Component({
  selector: 'app-subject-details',
  templateUrl: './subject-details.component.html',
  styleUrls: ['./subject-details.component.css']
})
export class SubjectDetailsComponent implements OnInit {
  // forms
  curriculumForm: FormGroup;
  searchForm: FormGroup;

  subject = null;
  subject_id = 0;
  curriculums = [];
  types = [];
  levels = [];
  account_id: 0;

  // Modal reference
  modalReference: any;

  noUsers = true;
  constructor(
    private fb: FormBuilder,
    private subjectsService: SubjectsService,
    private toastrService: ToastService,
    private router: Router,
    private snapshot: ActivatedRoute,
    private curriculumService: CurriculumService,
    private levelsService: LevelsService,
    private typeService: TypesService,
    private modalService: NgbModal,
    private localStorage: LocalStorage
  ) {
    this.account_id = JSON.parse(this.localStorage.GetProfile()).account.id;
    this.curriculumForm = fb.group({
      'level_id': [null, Validators.required],
      'subject_id': [null, Validators.required],
      'curriculum_type_id': [null, Validators.required],
      'account_id': [this.account_id, Validators.required]
    });
  }

  ngOnInit() {
    const id = this.snapshot.snapshot.params['id'];
    this.subjectsService.getSubjectDetails(id).subscribe(response => {
      if (response.data) {
        this.subject = response.data;
        this.subject_id = this.subject.id;
        this.noUsers = false;
        this.curriculums = this.subject.curriculums;
      } else {
        this.toastrService.showError(response.error, 'Failed');

      }
    }, (error) => {
      // this.updateUI();
      this.toastrService.showError(error, 'Failed');
    });

    this.levelsService.levels().subscribe(response => {
      if (response.data) {
        if (response.data.length > 0) {
          this.levels = response.data;
        }
      } else {
        this.toastrService.showError(response.error, 'No Level!');
      }
    }, (error) => {
      this.toastrService.showError(error, 'Cannot retrieve levels!');
    });

    this.typeService.types().subscribe(response => {
      if (response.data) {
        if (response.data.length > 0) {
          this.types = response.data;
        }
      } else {
        this.toastrService.showError(response.error, 'No Type!');
      }
    }, (error) => {
      this.toastrService.showError(error, 'Cannot retrieve types!');
    });
  }
  /**
   * Open modal to add a new curriculum
   * @param content
   */
  open(content) {
    this.modalReference = this.modalService.open(content, {ariaLabelledBy: 'createCurriculumTitle'});
  }

  /**
   * Add a new curriculum
   * @param data
   */
  addNewCurriculum(data) {
    this.curriculumService.addCurriculum({'curriculum': data}).subscribe((response) => {
      if (response.ok !== false) {
        this.toastrService.showSuccess('Curriculum has been added!', 'Curriculum Added!');
        this.curriculums.push(response.data);
        this.modalReference.dismiss();
      }
    });
  }

  /**
   * Button on-click event to add a new curriculum
   */
  createCurriculum($event) {
    $event.preventDefault();
    const formValues = this.curriculumForm.value;
    formValues.subject_id = this.subject_id;
    this.addNewCurriculum(formValues);
  }

  /**
   * Navigate to a curriculum detail view
   * @param curriculum
   */
  view_curriculum(curriculum) {
    this.router.navigate([`/app/curriculums/${curriculum.id}`]);
  }


}
