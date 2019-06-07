import { Component, OnInit } from '@angular/core';
// import { DOCUMENT } from '@angular/platform-browser';
import * as $ from 'jquery';


@Component({
  selector: 'app-app-layout',
  templateUrl: './app-layout.component.html',
  styleUrls: ['./app-layout.component.css']
})

export class AppLayoutComponent implements OnInit {
  private right_sidebar = false;
  private sidebar_mini = false;
  date;
  // @ViewChild('someVar') el: ElementRef;
  constructor() { }

  ngOnInit() {

    this.date = new Date().getFullYear();

    $(document).ready(function () {
      'use strict';

      $('[data-toggle="offcanvas"]').on("click", function () {
        $('.row-offcanvas').toggleClass('active')
      });

      
      //Hoverable-collapse
      //Open submenu on hover in compact sidebar mode and horizontal menu mode
      $(document).on('mouseenter mouseleave', '.sidebar .nav-item', function (ev) {
        const body = $('body');
        const sidebarIconOnly = body.hasClass('sidebar-icon-only');
        const horizontalMenu = body.hasClass('horizontal-menu');
        const sidebarFixed = body.hasClass('sidebar-fixed');
        if (!('ontouchstart' in document.documentElement)) {
          if (sidebarIconOnly || horizontalMenu) {
            if (sidebarFixed) {
              if (ev.type === 'mouseenter') {
                body.removeClass('sidebar-icon-only');
              }
            } else {
              const $menuItem = $(this);
              if (ev.type === 'mouseenter') {
                $menuItem.addClass('hover-open');
              } else {
                $menuItem.removeClass('hover-open');
              }
            }
          }
        }
      });

        const body = $('body');
        const contentWrapper = $('.content-wrapper');
        const scroller = $('.container-scroller');
        const footer = $('.footer');
        const sidebar = $('.sidebar');

        //Add active class to nav-link based on url dynamically
        //Active class can be hard coded directly in html file also as required
        const current = location.pathname.split('/').slice(-1)[0].replace(/^\/|\/$/g, '');
        $('.nav li a', sidebar).each(function () {
          const $this = $(this);
          if (current === '') {
            //for root url
            if ($this.attr('href').indexOf('index.html') !== -1) {
              $(this).parents('.nav-item').last().addClass('active');
              if ($(this).parents('.sub-menu').length) {
                $(this).closest('.collapse').addClass('show');
                $(this).addClass('active');
              }
            }
          } else {
            //for other url
            if ($this.attr('href').indexOf(current) !== -1) {
              $(this).parents('.nav-item').last().addClass('active');
              if ($(this).parents('.sub-menu').length) {
                $(this).closest('.collapse').addClass('show');
                $(this).addClass('active');
              }
            }
          }
        });

        //Close other submenu in sidebar on opening any

        // sidebar.on('show.bs.collapse', '.collapse', function () {
        //   sidebar.find('.collapse.show').collapse('hide');
        // });


        //Change sidebar and content-wrapper height
        applyStyles();
        function applyStyles() {

          //setting content wrapper height
          if (!(body.hasClass('horizontal-menu') && window.matchMedia('(min-width: 992px)').matches)) {
            setTimeout(function () {
              if (contentWrapper.outerHeight() < (sidebar.outerHeight() - footer.outerHeight())) {
                contentWrapper.css({
                  'min-height': sidebar.outerHeight() - footer.outerHeight()
                });
              }

              if (sidebar.outerHeight() < (contentWrapper.outerHeight() + footer.outerHeight())) {
                sidebar.css({
                  'min-height': contentWrapper.outerHeight() + footer.outerHeight()
                });
              }

            }, 1000);
          } else {
            contentWrapper.css({
              'min-height': '100vh'
            });
          }


        }

        $('.sidebar [data-toggle="collapse"]').on('click', function (event) {
          if (!(body.hasClass('sidebar-icon-only') || body.hasClass('horizontal-menu'))) {
            // Updating content wrapper height to sidebar height on expanding a menu in sidebar
            const clickedItem = $(this);
            console.log(clickedItem);
            let scrollTop = 0;
            if (clickedItem.attr('aria-expanded') === 'false') {
              scrollTop = scroller.scrollTop() - 20;
            } else {
              scrollTop = scroller.scrollTop() - 100;
            }
            setTimeout(function () {
              if (contentWrapper.outerHeight() + footer.outerHeight() !== sidebar.outerHeight()) {
                applyStyles();
                scroller.animate({ scrollTop: scrollTop }, 350);
              }
            }, 400);
          } else {
            // Disable click on sidebar menu item when sidebar icon only mode or horizontal menu mode is in use
            // to avoid ambiguity of mixed hover and click on menu item
            return false;
          }
        });
        $('[data-toggle="minimize"]').on('click', function () {
          if ((body.hasClass('sidebar-toggle-display')) || (body.hasClass('sidebar-absolute'))) {
            body.toggleClass('sidebar-hidden');
            applyStyles();
          } else {
            body.toggleClass('sidebar-icon-only');
            applyStyles();
          }
        });

        //checkbox and radios
        $('.form-check label,.form-radio label').append('<i class="input-helper"></i>');

        //fullscreen
        // $("#fullscreen-button").on("click", function toggleFullScreen() {
        //   if ((document.fullScreenElement !== undefined && document.fullScreenElement === null) || (document.msFullscreenElement !== undefined && document.msFullscreenElement === null) || (document.mozFullScreen !== undefined && !document.mozFullScreen) || (document.webkitIsFullScreen !== undefined && !document.webkitIsFullScreen)) {
        //     if (document.documentElement.requestFullScreen) {
        //       document.documentElement.requestFullScreen();
        //     } else if (document.documentElement.mozRequestFullScreen) {
        //       document.documentElement.mozRequestFullScreen();
        //     } else if (document.documentElement.webkitRequestFullScreen) {
        //       document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
        //     } else if (document.documentElement.msRequestFullscreen) {
        //       document.documentElement.msRequestFullscreen();
        //     }
        //   }
        //   else {
        //     if (document.cancelFullScreen) {
        //       document.cancelFullScreen();
        //     } else if (document.mozCancelFullScreen) {
        //       document.mozCancelFullScreen();
        //     } else if (document.webkitCancelFullScreen) {
        //       document.webkitCancelFullScreen();
        //     } else if (document.msExitFullscreen) {
        //       document.msExitFullscreen();
        //     }
        //   }
        // })



    });
  }

  toggleRightSidebar(event) {
    event.preventDefault();
    console.log(document.body);
    if (this.right_sidebar == false) {
      this.right_sidebar = true;
        // document.body
        alert('toogle');
      window.document.querySelector('body').classList.add('sidenav-toggled');
      // this.renderer.addClass(this.elRef.nativeElement, 'sidenav-toggled');
    } else if (this.right_sidebar == true) {
      this.right_sidebar = false;
      // this.renderer.removeClass(this.elRef.nativeElement, 'sidenav-toggled');
      window.document.querySelector('body').classList.remove('sidenav-toggled');

    }
  }

}
