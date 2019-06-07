import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ContextMenuModule } from 'ngx-contextmenu';
import { NgxWigModule } from 'ngx-wig';
import { LoadingBarHttpClientModule } from '@ngx-loading-bar/http-client';
import { LoadingBarHttpModule } from '@ngx-loading-bar/http';
import { LoadingBarRouterModule } from '@ngx-loading-bar/router';

import { HttpClientModule, HttpClient } from '@angular/common/http';

// SERVICES
import { ToastService } from './shared/services/toastr.service';
import { AuthService } from './auth/auth.service';
import { HeaderService } from './shared/services/index';

// COMPONENTS
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { PerfectScrollbarModule } from 'ngx-perfect-scrollbar';
import { PERFECT_SCROLLBAR_CONFIG } from 'ngx-perfect-scrollbar';
import { PerfectScrollbarConfigInterface } from 'ngx-perfect-scrollbar';
import { ToastrModule } from 'ngx-toastr';
import { Ng2SmartTableModule } from 'ng2-smart-table';

const DEFAULT_PERFECT_SCROLLBAR_CONFIG: PerfectScrollbarConfigInterface = {
  suppressScrollX: true
};
import {
  AuthGuardService,
  LocalStorage
} from './shared/index';

// layouts
import { AppLayoutComponent } from './shared/layouts/app-layout/app-layout.component';
import { NavbarComponent } from './shared/layouts/navbar/navbar.component';
import { SidebarComponent  } from './shared/layouts/sidebar/sidebar.component';


import { AuthLayoutComponent } from './shared/layouts/auth-layout/auth-layout.component';

// pages
import { AppComponent } from './app.component';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { NotFoundComponent } from './not-found/not-found.component';

// Subject
import { SubjectsService } from './cman/subjects/subjects.service';
import { SubjectsComponent } from './cman/subjects/subjects/subjects.component';
import { SubjectDetailsComponent } from './cman/subjects/subject-details/subject-details.component';

// Curriculum
import { CurriculumService } from './cman/curriculums/curriculum.service';
import { CurriculumsComponent } from './cman/curriculums/curriculums/curriculums.component';
import { CurriculumDetailsComponent } from './cman/curriculums/curriculum-details/curriculum-details.component';

// Level
import { LevelsService } from './cman/levels/levels.service';
import { LevelsComponent } from './cman/levels/levels.component';

// Topics
import { TopicsComponent } from './cman/topics/topics.component';
import {TopicsService} from './cman/topics/topics.service';

// Type
import { TypesService } from './cman/types/types.service';
import { TypesComponent } from './cman/types/types.component';

// Content
import { ContentsComponent } from './cman/contents/contents.component';
import { ContentsService } from './cman/contents/contents.service';
import { ContentSectionService } from './cman/contents/content-section.service';

import { UploadService } from './shared/services/index';

import { AppRoutingModule } from './app-routing.module';
import { LogoutComponent } from './auth/logout/logout.component';

// Users
import { UsersComponent } from './users/users/users.component';
import { UserDetailsComponent } from './users/user-details/user-details.component';
import { UsersService } from './users/users.service';
import { ServiceWorkerModule } from '@angular/service-worker';
import { environment } from '../environments/environment';

@NgModule({
  declarations: [
    // App Layout
    AppComponent,
    AppLayoutComponent,
    AuthLayoutComponent,
    NavbarComponent,
    SidebarComponent,

    // Auth
    LoginComponent,
    RegisterComponent,

    // App Pages
    NotFoundComponent,
    DashboardComponent,


    // Curriculums
    CurriculumsComponent,
    CurriculumDetailsComponent,

    // Subject
    SubjectsComponent,
    SubjectDetailsComponent,

    // Types
    TypesComponent,

    // Levels
    LevelsComponent,

    // Topics
    TopicsComponent,

    // Contents
    ContentsComponent,

    LogoutComponent,
    UsersComponent,
    UserDetailsComponent
  ],
  imports: [
    BrowserModule,
    // RouterModule.forRoot(
    //   appRoutes,
    //   // { enableTracing: true } // <-- debugging purposes only
    // ),
    AppRoutingModule,
    CommonModule,
    BrowserAnimationsModule, // required animations module
    ToastrModule.forRoot(), // ToastrModule added
    PerfectScrollbarModule,
    FormsModule,
    ReactiveFormsModule,
    Ng2SmartTableModule,
    HttpClientModule,
    NgbModule.forRoot(),
    ContextMenuModule.forRoot({useBootstrap4: true, autoFocus: true}),
    NgxWigModule,
    LoadingBarHttpModule,
    LoadingBarRouterModule,
    LoadingBarHttpClientModule,
    ServiceWorkerModule.register('/ngsw-worker.js', { enabled: environment.production }),
  ],
  providers: [
    FormBuilder,
    HttpClient,
    AuthGuardService,
    LocalStorage,
    ToastService,
    AuthService,
    HeaderService,
    CurriculumService,
    SubjectsService,
    TypesService,
    LevelsService,
    TopicsService,
    ContentsService,
    ContentSectionService,
    UploadService,
    UsersService,
    {
      provide: PERFECT_SCROLLBAR_CONFIG,
      useValue: DEFAULT_PERFECT_SCROLLBAR_CONFIG
    }
  ],
  bootstrap: [AppComponent],
})



export class AppModule { }
