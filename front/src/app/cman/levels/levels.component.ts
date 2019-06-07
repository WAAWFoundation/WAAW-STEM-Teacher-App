import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { LevelsService } from './levels.service';
import { Router} from '@angular/router';
import {NgbModal} from '@ng-bootstrap/ng-bootstrap';
import { LocalStorage } from '../../shared/store';
import {ToastService} from '../../shared/services';

@Component({
  selector: 'app-levels',
  templateUrl: './levels.component.html',
  styleUrls: ['./levels.component.scss']
})
export class LevelsComponent implements OnInit {

  levels = [];
  account_id: string;
  levelForm: FormGroup;

  // Modal reference
  modalReference: any;

  constructor(
    private fb: FormBuilder,
    private localStorage: LocalStorage,
    private levelService: LevelsService,
    private modal: NgbModal,
    private toastrService: ToastService,
    private router: Router
  ) {
    this.account_id = JSON.parse(this.localStorage.GetProfile()).account.id;
    this.levelForm = fb.group({
      'name': [null, Validators.required],
      'account_id': [this.account_id, Validators.required]
    });
  }

  ngOnInit() {
    this.levelService.levels().subscribe((response) => {
      if (response.data) {
        this.levels = response.data;
      } else {
        this.toastrService.showError(response.error, 'No Curriculum!');
      }
    }, (error) => {
      this.toastrService.showError(error, 'Cannot retrieve curriculums!');
    });
  }

  /**
   * Open modal to add a new level
   * @param content
   */
  open(content) {
    this.modalReference = this.modal.open(content, {ariaLabelledBy: 'createLevelTitle'});
  }

  /**
   * Add a new level
   * @param data
   */
  addNewLevel(data) {
    if (data.name.length < 3) {
      alert('Name should be at least 3 characters!');
      return false;
    }

    this.levelService.addLevel({'level': data}).subscribe((response) => {
      this.levels.push(response.data);
      this.modalReference.dismiss();
    });
  }

  /**
   * View list of curriculums based on level
   * @param level
   */
  levelDetail(level) {
    this.router.navigateByUrl('/app/curriculums?level=' + level.id.toString());
  }

  /**
   * Search function
   * @param query
   */
  onSearch(query) {
    console.log(query);
  }
}
