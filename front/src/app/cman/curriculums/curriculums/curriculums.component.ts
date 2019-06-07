import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ToastService } from '../../../shared/services';
import { CurriculumService } from '../curriculum.service';
import { LevelsService } from '../../levels/levels.service';
import { SubjectsService } from '../../subjects/subjects.service';
import { TypesService } from '../../types/types.service';
import {ActivatedRoute, Params, Router} from '@angular/router';
import {NgbModal} from '@ng-bootstrap/ng-bootstrap';
import {logging} from 'selenium-webdriver';
import { LocalStorage } from '../../../shared/store';
import Level = logging.Level;

@Component({
  selector: 'app-curriculums',
  templateUrl: './curriculums.component.html',
  styleUrls: ['./curriculums.component.css']
})
export class CurriculumsComponent implements OnInit {
  // forms
  curriculumForm: FormGroup;
  queryParams: any;

  // search entry
  // search_query = '';

  // Modal reference
  modalReference: any;
  account_id: string;
  curriculums = [];
  levels = [];
  types = [];
  subjects = [];
  noCurriculums = true;
  noLevels = true;
  noTypes = true;
  noSubjects = true;
  submitPending = false;

  constructor(
    private fb: FormBuilder,
    private curriculumService: CurriculumService,
    private levelsService: LevelsService,
    private subjectService: SubjectsService,
    private typeService: TypesService,
    private toastrService: ToastService,
    private router: Router,
    private route: ActivatedRoute,
    private modalService: NgbModal,
    private localStorage: LocalStorage
  ) {
    this.account_id = JSON.parse(this.localStorage.GetProfile()).account.id;
    this.curriculumForm = fb.group({
      'level_id': [null, Validators.required],
      'subject_id': [null, Validators.required],
      'curriculum_type_id': [null, Validators.required],
      'account_id': [this.account_id]
    });
  }

  ngOnInit() {
    // Get query params if any
    this.getQueryParams();
    // alert(this.queryParams);

    this.curriculumService.getCurriculums().subscribe(response => {
        if (response.data) {
          if (response.data.length > 0) {
            this.curriculums = response.data;
            this.noCurriculums = false;
          }
        } else {
          this.toastrService.showError(response.error, 'No Curriculum!');
        }
      }, (error) => {
        this.toastrService.showError(error, 'Cannot retrieve curriculums!');
      });

    this.levelsService.levels().subscribe(response => {
      if (response.data) {
        if (response.data.length > 0) {
          this.levels = response.data;
          this.noLevels = false;
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
          this.noTypes = false;
        }
      } else {
        this.toastrService.showError(response.error, 'No Type!');
      }
    }, (error) => {
      this.toastrService.showError(error, 'Cannot retrieve types!');
    });

    this.subjectService.getSubjects().subscribe(response => {
      if (response.data) {
        if (response.data.length > 0) {
          this.subjects = response.data;
          this.noSubjects = false;
        }
      } else {
        this.toastrService.showError(response.error, 'Cannot retrieve types!');
      }
    }, (error) => {
      this.toastrService.showError(error, 'Cannot retrieve subjects!');
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
   * Search through list of curriculums based on given query
   * @param query
   */
  onSearch(query) {
    // this.curriculums = this.curriculums.map((curriculum, index) => {
    //   if (curriculum.subject.name.toString().search(query) ) {
    //     return curriculum;
    //   } else {
    //     console.log(curriculum.subject.name);
    //   }
    //
    //   return curriculum;
    // });
  }

  /**
   * Add a new curriculum
   * @param data
   */
  addNew(data) {
    this.submitPending = true;
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
  createCurriculum() {
    this.addNew(this.curriculumForm.value);
  }

  /**
   * Navigate to curriculum detail view
   * @param curriculum
   */
  curriculumDetail(curriculum) {
    this.router.navigate([`/app/curriculums/${curriculum.id}`]);
  }

  /**
   *
   * @param {FormControl} control
   * @returns {any}
   */
  selectedIDValidator(control: FormControl) {
    const id = control.value;
    if (id === '0') {
      return {
        selectedID: {
          parsedID: id
        }
      };
    }

    return null;
  }

  /**
   * Get the params in route
   * @returns {Params}
   */
  getQueryParams() {
    this.route.queryParams.subscribe((params: Params) => {
      this.queryParams = params;
    });
  }

}
