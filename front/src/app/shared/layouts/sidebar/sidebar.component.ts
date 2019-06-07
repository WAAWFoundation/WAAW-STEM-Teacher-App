import { Component, OnInit, ElementRef, NgZone} from '@angular/core';
import { Router } from '@angular/router';
import { LocalStorage } from '../../store/index';


@Component({
    selector: 'app-sidebar',
    templateUrl: './sidebar.component.html',
    styleUrls: ['./sidebar.component.scss']
})

export class SidebarComponent implements OnInit {
    constructor() {
    }

    ngOnInit() {}
}
