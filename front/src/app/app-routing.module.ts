import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {AuthGuardService, LocalStorage} from './shared/index';

// Layouts
import { AppLayoutComponent } from './shared/layouts/app-layout/app-layout.component';
import { NavbarComponent } from './shared/layouts/navbar/navbar.component';
import { SidebarComponent } from './shared/layouts/sidebar/sidebar.component';
import { UsersService } from './users/users.service';
import { AuthLayoutComponent } from './shared/layouts/auth-layout/auth-layout.component';

// Pages
import { AppComponent } from './app.component';
import { LoginComponent } from './auth/login/login.component';
import { LogoutComponent } from './auth/logout/logout.component';
import { RegisterComponent } from './auth/register/register.component';
import { UsersComponent } from './users/users/users.component';
import { UserDetailsComponent } from './users/user-details/user-details.component';
// import { RegisterComponent } from './auth/register/register.component';

import { DashboardComponent } from './dashboard/dashboard.component';
import { NotFoundComponent } from './not-found/not-found.component';

// Subject
import { SubjectsComponent } from './cman/subjects/subjects/subjects.component';
import { SubjectDetailsComponent } from './cman/subjects/subject-details/subject-details.component';

// Curriculum
import { CurriculumsComponent } from './cman/curriculums/curriculums/curriculums.component';
import { CurriculumDetailsComponent } from './cman/curriculums/curriculum-details/curriculum-details.component';

// Level
import { LevelsComponent } from './cman/levels/levels.component';

// Types
import { TypesComponent } from './cman/types/types.component';

const routes: Routes = [
  {
    path: '',
    component: AuthLayoutComponent,
    canActivate: [AuthGuardService],
    children: [
      { path: '', redirectTo: '/login', pathMatch: 'full' },
      { path: 'login', component: LoginComponent },
      { path: 'logout', component: LogoutComponent },
      { path: 'register', component: RegisterComponent }
    ]
  },
  {
    path: 'app',
    component: AppLayoutComponent,
    canActivate: [AuthGuardService],
    data: { title: 'WAAW Foundation' },
    children: [
      { path: '', component: DashboardComponent },
      { path: 'dashboard', component: DashboardComponent },
      {
        path: 'users',
        component: AuthLayoutComponent,
        canActivate: [AuthGuardService],
        children: [
          { path: '', component: UsersComponent },
          { path: ':id', component: UserDetailsComponent }
        ]
      },
      {
        path: 'curriculums',
        component: AuthLayoutComponent,
        canActivate: [AuthGuardService],
        children: [
          { path: '', component: CurriculumsComponent },
          { path: ':id', component: CurriculumDetailsComponent },
        ]
      },
      {
        path: 'subjects',
        component: AuthLayoutComponent,
        canActivate: [AuthGuardService],
        children: [
          { path: '', component: SubjectsComponent },
          { path: ':id', component: SubjectDetailsComponent },
        ]
      },
      {
        path: 'levels',
        component: LevelsComponent,
        canActivate: [AuthGuardService],
        children: [
          {path: '', component: LevelsComponent}
        ]
      },
      {
        path: 'types',
        component: TypesComponent,
        canActivate: [AuthGuardService],
        children: [
          {path: '', component: TypesComponent}
        ]
      }
    ],
  }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
