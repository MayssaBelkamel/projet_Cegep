import { Component, OnInit } from '@angular/core';
import { Router, RouterModule, RouterOutlet } from '@angular/router';
import { MatchService } from '../../services/match.service';
import { MatButtonModule } from '@angular/material/button';
import { MatchHubService } from 'src/app/services/match-hub.service.service';
import { CommonModule } from '@angular/common';
import { AccountService } from 'src/app/services/account.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
  standalone: true,
  imports: [MatButtonModule, RouterOutlet, RouterModule, CommonModule]
})
export class HomeComponent implements OnInit {


  rechercheMatch: boolean = false;
  constructor(public router: Router, public match: MatchService, public accService: AccountService, private matchHub: MatchHubService) { }

  async ngOnInit() {
    if (this.accService.isLoggedIn()) {
      await this.matchHub.startConnection();
      this.match.onMatchJoined = (joiningData) => {
        this.rechercheMatch = false;
        this.router.navigate(['/match/' + joiningData.match.id]);
      };
    }
  }

  async joinMatch() {
    if (!this.accService.isLoggedIn() || this.rechercheMatch) return;

    this.rechercheMatch = true;
    try {
      await this.matchHub.joinMatch();
    } catch (e) {
      this.rechercheMatch = false;
      throw e;
    }
  }

  async cancelMatchSearch() {
    this.rechercheMatch = false;
    await this.matchHub.stopConnection();
  }
}


