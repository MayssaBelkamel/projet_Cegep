import { Component, OnInit } from '@angular/core';
import { MatchService } from './services/match.service';
import { Router, RouterOutlet, RouterLink } from '@angular/router';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatIconModule } from '@angular/material/icon';
import { MatChipsModule } from '@angular/material/chips';
import { MatButtonModule } from '@angular/material/button';
import { AccountService } from './services/account.service';

@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  imports: [
    MatToolbarModule,
    MatIconModule,
    MatChipsModule,
    RouterOutlet,
    RouterLink,
    MatButtonModule,
  ],
})
export class AppComponent {
  title = 'supercartesinfinies';
  username: string | null = ''
  constructor(public router: Router, public matchService: MatchService, public accService : AccountService) { }
  
  isLogged() {
    // TODO: Gérer l'affichage du joueur lorsqu'il est connecté
    return true ;
  }

  getUsername() {
    let nom : string |null = sessionStorage.getItem("playerName");
    return nom;
  }

  async logout() {
    // TODO: Gérer le logout
    this.accService.logout();
  }

  privateData(){
    this.accService.privateData()
  }
}
