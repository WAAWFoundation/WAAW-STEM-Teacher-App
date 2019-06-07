import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { Location } from '@angular/common';
import { LocalStorage } from '../../../shared/store';
import { CurriculumService } from '../curriculum.service';
import { TopicsService } from '../../topics/topics.service';
import { ContentsService } from '../../contents/contents.service';
import { ContentSectionService } from '../../contents/content-section.service';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { ToastService } from '../../../shared/services';
import { FormControl, FormGroup, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import * as $ from 'jquery';
import { toTitleCase } from '../../../shared/helpers/string.helpers';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { UploadService } from '../../../shared/services';
import { HttpClient } from '@angular/common/http';
import { HeaderService } from '../../../shared/services';
import { getFileExtension } from '../../../shared/helpers/string.helpers';
import { environment } from '../../../../environments/environment';
import { ContextMenuComponent, ContextMenuService } from 'ngx-contextmenu';
import { NgxWigComponent, NgxWigToolbarService } from 'ngx-wig';
import { async } from 'rxjs/internal/scheduler/async';

@Component({
  selector: 'app-curriculum-details',
  templateUrl: './curriculum-details.component.html',
  styleUrls: ['./curriculum-details.component.css']
})
export class CurriculumDetailsComponent implements OnInit, AfterViewInit {
  title = 'Curriculum Detail';

  curriculum = {
    account_id: 0,
    id: 0,
    level: { name: '', id: 0, account_id: 1 },
    level_name: '',
    subject: { id: 0, name: '', code: '', account_id: 1 },
    subject_name: '',
    topics: [],
    type: { type: '', name: '', id: 0, account_id: 1 }
  };

  textInput: any;
  textInitialInput = '';
  topic: any;
  /**
   * Keep an array of all contents for a topic.
   * @type {any[]}
   */
  topicContents = [];
  activeContent: any;
  activeContentID: any;
  curriculumID = 0;
  selectedTopicID = 0;
  curriculumTopics = [];
  queryParams = null;

  // Modal reference
  modalReference: any;

  // Forms and related
  TopicForm: FormGroup;
  SectionForm: FormGroup;
  formErrors = false;



  showSectionTitleForm = false;
  topicmeta = [];

  topicTitle = '';
  topicDescription = '';
  topicDurration = '';
  topicOutcome = '';

  // edit vars
  editedSection;
  editedContent;

  // edit topic
  editTopic = false; // check if edit button was cliked
  editedTopicContent;


  apiURL = environment.api.url;
  assetURL = environment.api.asset;

  // Auth and related
  accountID: 0;

  @ViewChild(ContextMenuComponent)

  public sectionActionMenu: ContextMenuComponent;
  @ViewChild(NgxWigComponent) public ngxWix: NgxWigComponent;

  constructor(
    private tFB: FormBuilder,
    private sFB: FormBuilder,
    private sCFB: FormBuilder,
    private curriculumService: CurriculumService,
    private toastrService: ToastService,
    private router: Router,
    private route: ActivatedRoute,
    private location: Location,
    private snapshot: ActivatedRoute,
    private localStorage: LocalStorage,
    private topicService: TopicsService,
    private modalService: NgbModal,
    private uploadService: UploadService,
    private contentService: ContentsService,
    private contentSectionService: ContentSectionService,
    private http: HttpClient,
    private contextMenuService: ContextMenuService,
    private ngxToolbarService: NgxWigToolbarService
  ) {
    this.accountID = JSON.parse(this.localStorage.GetProfile()).account.id;
    this.curriculumID = this.snapshot.snapshot.params['id'];

    this.TopicForm = tFB.group({
      title: [this.topicTitle, Validators.required],
      description: [this.topicDescription, Validators.required],
      durration: [this.topicDurration, Validators.required],
      outcome: [this.topicOutcome, Validators.required],
      account_id: [this.accountID],
      curriculum_id: [this.curriculumID],
      // topicmeta: [this.topicmeta]
    });

    this.SectionForm = sFB.group({
      title: [null, Validators.required],
      sections: [[], Validators.required],
      account_id: [this.accountID, Validators.required],
      topic_id: [this.selectedTopicID, Validators.required]
    });
  }

  ngOnInit() {
    this.curriculumID = this.snapshot.snapshot.params['id'];
    this.curriculumService.getCurriculum(this.curriculumID).subscribe(
      response => {
        if (response.data) {
          this.curriculum = response.data;
          if (response.data.topics.length > 0) {
            this.curriculumTopics = this.curriculum.topics.reverse();
            // If topic exists in query params, set as the selectedTopic, then retrieve that topic.
            // Else, use the first topic in list of curriculum topics and set URL location state

            this.renderTopicFromRouteParam();
            this.location.replaceState(`/app/curriculums/${this.curriculumID}?topic=${this.selectedTopicID}`
            );
          }
        } else {
          this.toastrService.showError(response.error, 'Failed');
        }
      },
      error => {
        this.toastrService.showError(error, 'Failed');
      }
    );
  }

  ngAfterViewInit() {
    async.schedule(() => {
      if (this.selectedTopicID !== 0) {
        $('#topic_item_' + this.selectedTopicID.toString()).addClass('active');
      }
    }, 1000);
  }

  /**
   * Open modal to add a new topic
   * @param content
   */
  open(content) {
    this.editTopic = false;
    this.TopicForm.patchValue({
      title: '',
      description: '',
      durration: '',
      outcome: '',
    });

    this.modalReference = this.modalService.open(content, {
      ariaLabelledBy: 'createTopicTitle',
      size: 'lg',
      keyboard: false,
      backdrop: 'static'
    });
  }



  openEdit(content, topic) {
    this.editedTopicContent = topic;

    this.TopicForm.patchValue({
      title: topic.title,
      description: topic.description,
      durration: topic.durration,
      outcome: topic.outcome,
    });

    this.editTopic = true;
    this.modalReference = this.modalService.open(content, {
      ariaLabelledBy: 'editTopicTitle',
      size: 'lg',
      keyboard: false,
      backdrop: 'static'
    });
  }

  /**
   * Open a new content section
   * @param content The topic content being worked on.
   * @param id The prefixed id for the related input controls
   * @param type The type of section being added.
   * @param evt The event object
   */
  addSection(content, id, type, evt: Event) {
    evt.preventDefault();

    $('.nw-editor__res').html('');

    this.activeContent = content;
    this.activeContentID = content.id;
    $('.editParagraph').hide();
    // Show the text block form
    if (type === 'image') {
      $('#textBlock_' + id).hide();
      $('#imageBlock_' + id).toggle();
    } else {
      $('#imageBlock_' + id).hide();
      $('#textBlock_' + id).toggle();
    }
  }

  /**
   * Add a text section to a  content block.
   * @param content
   * @param id
   * @param evt
   */
  addParagraph(content, id, evt) {
    this.activeContent = content;
    this.activeContentID = content.id;
    const value = this.textInput;
    const weditor = $('.nw-editor__res');

    const _activeContent = this.activeContent;
    const order = _activeContent.body.length + 1;
    const data = {
      type: 'text',
      value: value,
      content_id: this.activeContentID,
      order: order
    };

    this.contentSectionService
      .addContentSection({ content_section: data })
      .subscribe((response) => {
          if (response.data) {
            _activeContent.body.push(response.data);
            weditor.html('');
            $('#textBlock_' + id).toggle();
          }
        },
        error => {
          if (error.status === 422) {
            alert('Please enter valid values');
          }
        }
      );

    this.activeContent = _activeContent;
  }

  editParagraph(content, id, $event) {
    this.activeContent = content;
    const weditor = $('.nw-editor__res');

    const data = {
      value: this.textInput,
    };

    this.contentSectionService
      .updateContentSection(this.editedSection.id, { content_section: data })
      .subscribe(
        response => {
          if (response.data) {
            weditor.html('');
            $('#text_' + this.editedSection.id).html(this.textInput);
            $('#textEditBlock_' + id).toggle();
          }
        },
        error => {
          if (error.status === 422) {
            alert('Please enter valid values');
          }
        }
      );
  }

  cancelEditParagraph(id, $event) {
    this.textInitialInput = '';
    this.textInput = '';
    const textInput = $('#textEditBlock_' + id + '_Content');
    textInput.val('');
    // Show all contents (text and image)
    $('.content_' + id).show();
    $('.nw-editor__res').html('');
    $('#textEditBlock_' + id).toggle();
  }

  /**
   * Add an image section to a content block
   * @param content
   * @param id
   * @param evt
   */
  addImage(content, id, evt) {
    this.activeContent = content;
    this.activeContentID = content.id;

    // Shim for IE8 browsers
    if (!Date.now) {
      Date.now = function() {
        return new Date().getTime();
      };
    }

    const file = evt.target.files[0];
    const extension = getFileExtension(file.name);
    const filename = Math.floor(Date.now() / 1000).toString() + '.' + extension;
    const uploadData = new FormData();

    const _activeContent = this.activeContent;
    const order = _activeContent.body.length + 1;
    uploadData.append('media', file, filename);
    uploadData.append('content_id', this.activeContentID);
    uploadData.append('order', order);

    ///
    // Upload image
    this.uploadService
      .fileUpload(uploadData, '/content-sections/upload')
      .subscribe(response => {
        if (response["data"]) {
          _activeContent.body.push(response["data"]);

          $('#imageBlock_' + id).toggle();
        }

       
        },
        error1 => {
          this.toastrService.showError(
            'Image could not be uploaded!',
            'Upload Error'
          );
        }
      );
  }

  /**
   * View details of a topic
   * @param id
   * @param evt
   */
  viewTopic(id: number, evt) {
    evt.preventDefault();

    // Highlight selected topic
    const target = evt.target;
    $('.list-group-item').removeClass('active');
    $(target).addClass('active');

    // Retrieve topic details and
    this.selectedTopicID = id;
    this.location.replaceState(
      `/app/curriculums/${this.curriculumID}?topic=${id}`
    );

    // If there's a selected topic, render the topic contents
    if (this.selectedTopicID !== null) {
      this.topicService
        .getTopicDetails(this.selectedTopicID)
        .subscribe((response) => {
          if (response.data) {
            this.topic = response.data;
            this.topicContents = this.topic.contents.sort(function(a, b) {
              return a.order > b.order;
            });
          }
        });
    }
  }

  /**
   * Key up event to update section title
   * @param value
   */
  // setSectionTopic(value) {   this.sectionTitle = value; }

  /**
   * Add a new curriculum topic
   * @param data
   */
  addNewTopic(data) {
    let formData;
    if (this.editTopic) {
      formData = data;
      this.topicService.editTopic(this.editedTopicContent.id, { topic: formData }).subscribe(
        response => {
          // alert("like");
          // this.router.navigate([`/app/curriculums/${this.curriculumID}`], { queryParams: { topic: this.editedTopicContent.id } });
          this.modalReference.dismiss();
          //  this.location.;
          this.router.navigateByUrl(`/app/curriculums/${this.curriculumID}?topic=${this.editedTopicContent.id}`,
            { skipLocationChange: true });

          // return this.router.navigate(['app', 'curriculums', this.curriculumID], { queryParams: { topic: this.editedTopicContent.id } });
          // this.router.navigate([`/app/curriculums/${this.curriculumID}?topic=${this.editedTopicContent.id}`],
          // { queryParams: { topic: this.editedTopicContent.id } });

        },
        error => {
          if (!error.ok) {
            this.formErrors = true;
          }
        }
      );
    } else {
      formData = data;
      this.topicService.addTopic({ topic: formData }).subscribe(
        response => {
          if (response.data) {
            this.curriculum.topics.push(response.data);
            this.topic = response.data;
            this.topicContents = [];
            this.activeContent = null;
            this.activeContentID = 0;

            // Set URL query param to topic id
            this.selectedTopicID = this.topic.id;
            this.location.replaceState(
              `/app/curriculums/${this.curriculumID}?topic=${
              this.selectedTopicID
              }`
            );

            // Highlight the just added item  FIXME: JQuery not finding element here. Not sure why.... yet.
            console.log('Loading....');
            console.log($('.list-group-item'));
            $('#topic_item_' + this.selectedTopicID).addClass('active');

            this.modalReference.dismiss();
            // this.resetTopicForm();
          } else {
            this.formErrors = true;
            console.log(this.formErrors);
          }
        },
        error => {
          if (!error.ok) {
            this.formErrors = true;
          }
        }
      );

    }


  }

  /**
   * Add new topic content
   * @param data
   * @param id
   */
  addContentTitle(data, id) {
    data.topic_id = id;
    data.order = this.topicContents.length + 1;
    this.contentService
      .addTopicContent({ content: data })
      .subscribe((response) => {
        if (response.data) {
          console.log(response);

          this.topicContents.push(response.data);
          this.toggleShowSectionTitleForm();
        }
      },
      error => {
        if (error.status === 422) {
          this.toastrService.showError(
            'Please ensure all fields contain valid values!',
            'Validation Error'
          );
        } else {
          this.toastrService.showError(
            'An error just occurred. Please restart the page and try again. If error,' +
              ' persists, contact the web administrator!',
            'Error'
          );
        }
      }
    );
  }

  /**
   * Show/Hide section title form
   */
  toggleShowSectionTitleForm() {
    if (this.showSectionTitleForm) {
      this.showSectionTitleForm = false;
      this.formErrors = false;
    } else {
      this.showSectionTitleForm = true;
    }
  }

  /**
   * Reset the fields of topic form
   */
  resetTopicForm() {
    this.TopicForm.reset({
      title: '',
      description: '',
      durration: 0,
      outcome: ''
    });
  }

  /**
   * Converts string to title case
   * @param {string} title
   * @returns {any}
   */
  titleCase(title: string) {
    return toTitleCase(title);
  }

  /**
   * Checks the route for a topic param, if it exists, set selectedTopicID to the value of the param
   * Where selected topic exists, retrieve the topic
   */
  renderTopicFromRouteParam(topic_id = null) {
    // If topic is equal to null, then that means that there's most likely a topic param in the URL request
    // hence, get it and assign it to selectedTopicID.
    // Else, know that there's most likely no topic param and selectedTopicID is already set
    let _topic = [];
    if (topic_id == null) {
      this.getQueryParams();
      if (this.queryParams.hasOwnProperty('topic')) {
        this.selectedTopicID = this.queryParams.topic;
      }
    } else {
      if (this.selectedTopicID.toString() !== topic_id.toString()) {
        this.selectedTopicID = topic_id;
      }
    }

    topic_id = this.selectedTopicID;
    _topic = this.getIfTopicExists(topic_id);
    if (_topic.length > 0 && _topic.length === 1) {
      this.topic = _topic[0];
    } else {
      this.topic = this.curriculumTopics[0];
      this.selectedTopicID = this.topic.id;
    }

    // Get details for the topic
    this.topicService
      .getTopicDetails(this.selectedTopicID)
      .subscribe(response => {
        if (response.data) {
          this.topic = response.data;
          this.topicContents = this.topic.contents.sort(function(a, b) {
            return a.order > b.order;
          });
        }
      });
  }

  /**
   * Get the params in route
   * @returns {Params}
   */
  getQueryParams() {
    this.queryParams = this.snapshot.snapshot.queryParams;
  }

  /**
   * Returns a topic (in an array) if a given topic exists
   * @param topic_id
   * @return {Array} An array containing one topic.
   */
  getIfTopicExists(topic_id) {
    return this.curriculumTopics.filter(function(topic, index) {
      return topic.id.toString() === topic_id.toString();
    });
  }

  /**
   *
   * @param section
   * @param $event
   */
  deleteText(section, $event) {
    console.log(section);
    this.contentSectionService
      .deleteSectionContent(section.id)
      .subscribe(response => {
        const _contents = this.topicContents.map(function(content, index) {
          return content;
        });

        console.log('Getting _contents...');
        console.log(_contents);

        this.topicContents = _contents.filter(function(__section, __index) {
          return __section.id !== section.id;
        });

        console.log(this.topicContents);
      });
  }

  /**
   * To be used for keyboard or mouse events
   * @param {MouseEvent} $event
   * @param item
   */
  public onContextMenu($event: MouseEvent, item: any): void {
    this.contextMenuService.show.next({
      anchorElement: $event.target,
      // Optional - if unspecified, all context menu components will open
      contextMenu: this.sectionActionMenu,
      event: <any>$event,
      item: item
    });
    $event.preventDefault();
    $event.stopPropagation();
  }

  /**
   * Delete a content block
   * @param content
   * @param i
   * @param $event
   * @returns {boolean}
   */
  deleteContent(content, i, $event) {
    console.log(this.topicContents);
    const content_id = content.id;
    let deleted = false;

    if (confirm('Are you sure you want to delete this content block?')) {
      // If content has sections, do not allow delete
      const contents = $('.content_' + content.id);
      if (contents.length > 0) {
        this.toastrService.showError(
          'Delete all text and images within the content block and try again.',
          'Cannot Delete Content Block',
          8000
        );
        return false;
      }

      this.contentService.deleteTopicContent(content.id).subscribe(
        response => {
          $('#content_' + content.id).remove();
        },
        error => {
          this.toastrService.showError(error, 'An error occurred!');
          return false;
        }
      );

      deleted = true;
    }

    console.log('Getting value of deleted....');
    console.log(deleted);

    if (deleted) {
      this.topicContents = this.topicContents.filter(function(
        __content,
        index
      ) {
        return __content.id !== content_id;
      });
    }

    console.log(this.topicContents);
  }

  /**
   * Delete a section block
   * @param section
   * @param content
   */
  deleteSection(section, content) {
    const _type = section.type;

    this.contentSectionService.deleteSectionContent(section.id).subscribe(
      response => {
        _type === 'text'
          ? $('#text_' + section.id.toString()).remove()
          : $('#image_' + section.id.toString()).remove();
      },
      error => {
        console.log(error);
        return false;
      }
    );
  }

  /**
   *
   * @param section
   * @param content
   */
  editSection(section, content) {
    this.editedSection = section;
    this.editedContent = content;
    if (section.type === 'text') {
      // The text content
      const text = $('#text_' + section.id);
      const textHTML = text.html();

      // hide add paragraph
      $('.addParagraph').hide();

      // Show all text contents, then hide the specific one to be edited
      $('.content_' + content.id).each(function(__index, __element) {
        $(__element).show();
      });
      // text.hide();

      // Show the text input block
      $('#textEditBlock_' + content.id).show();
      const textBox = $('#textEditBlock_' + content.id + '_Content');
      $('.nw-editor__res').html(textHTML);
      // console.log(content);
      // console.log(section);
      // console.log('editBlock_' + content.id + '_Content');
      // console.log(textHTML);
      // update edit text preview
      $('#editBlock_' + content.id + '_Content').html(textHTML);

    }

    if (section.type === 'image') {
      // this.toastrService.showInfo()
    }
  }

  getTextInput($event: {}) {
    this.textInput = $event;
  }

  delete(id) {

    var r = confirm("You are about to delete a curriculum, this step is not reversible. Confirm to continue");
    if (r == true) {
      console.log("id");
      console.log(id);
      this.curriculumService
        .daleteCurriculums(id)
        .subscribe((response) => {
          this.toastrService.showSuccess(
            'Deleted Successfully!',
            'Curriculum'
          );
        });
    } 
   

  }

}
