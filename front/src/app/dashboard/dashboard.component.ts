import { Component, OnInit } from '@angular/core';
import { Router } from "@angular/router";
import { CurriculumService } from "../cman/curriculums/curriculum.service";
@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {
  stats;
  constructor(
    private curriculumService: CurriculumService,
    private router: Router
  ) { }

  ngOnInit() {


    this.curriculumService.getStats().subscribe(response => {
      this.stats = response;
    }, (error) => {
      this.router.navigateByUrl('/app/dashboard');
    });

  }

}
