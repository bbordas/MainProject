import {Component, OnDestroy, OnInit} from '@angular/core';
import { MediaObserver, MediaChange } from '@angular/flex-layout'
import { Subscription } from 'rxjs'

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit, OnDestroy {
  title = 'project1';
  mediaSub: Subscription;
  deviceXs: boolean;

  constructor(public mediaObserver: MediaObserver) {
  }

  ngOnInit() {
    this.mediaSub= this.mediaObserver.media$.subscribe(
        (result: MediaChange) => {
          this.deviceXs = result.mqAlias === 'xs' ? true : false;
          console.log(result.mqAlias);
          console.log(this.deviceXs);
    })
  }

  ngOnDestroy() {
    this.mediaSub.unsubscribe();
  }
}
