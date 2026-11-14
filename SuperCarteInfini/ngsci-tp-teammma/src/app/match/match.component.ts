import { Component, OnInit } from '@angular/core';
import { MatchService } from './../services/match.service';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { ApiService } from '../services/api.service';
import { HealthComponent } from './health/health.component';
import { MatButtonModule } from '@angular/material/button';
import { PlayerhandComponent } from './playerhand/playerhand.component';
import { EnemyhandComponent } from './enemyhand/enemyhand.component';
import { BattlefieldComponent } from './battlefield/battlefield.component';
import { EventDebuggerService } from '../services/event-debugger.service';
import { MatchHubService } from '../services/match-hub.service.service';


@Component({
  selector: 'app-match',
  templateUrl: './match.component.html',
  styleUrls: ['./match.component.css'],
  standalone: true,
  imports: [BattlefieldComponent, EnemyhandComponent, PlayerhandComponent, MatButtonModule, HealthComponent,RouterModule]
})
export class MatchComponent implements OnInit {
  matchId: number = -1;

  constructor(private eventDebuggerService: EventDebuggerService, private route: ActivatedRoute, public router: Router, public matchService: MatchService, public apiService: ApiService, public matchHub: MatchHubService) { }

  async ngOnInit() {
    let matchId: number = parseInt(this.route.snapshot.params["id"]);
    this.matchId = matchId;

    await this.matchHub.startConnection();

    if (this.matchService.match) {
      console.log('Match already loaded, skipping join');
      this.matchId = this.matchService.match.id;
      return;
    }

    await this.matchHub.joinMatch(matchId);
  }

  async endTurn() {
    // TODO Tâche Hub: Faire l'action sur le Hub et retirer fakeEndTurn
    await this.matchHub.endTurn(this.matchId);
  }

  

  async surrender() {
    // TODO Tâche Hub: Faire l'action sur le Hub et retirer fakeSurrender
    await this.matchHub.surrender(this.matchId);
  }


  endMatch() {
    this.matchService.clearMatch();
    this.router.navigate(['/home'])
  }

  isVictory() {
    if (this.matchService.matchData?.winningPlayerId)
      return this.matchService.matchData!.winningPlayerId === this.matchService.playerData!.playerId
    return false;
  }

  isMatchCompleted() {
    return this.matchService.matchData?.match.isMatchCompleted;
  }
}
