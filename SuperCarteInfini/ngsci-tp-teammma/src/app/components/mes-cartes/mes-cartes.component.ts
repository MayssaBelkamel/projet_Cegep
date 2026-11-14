import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { lastValueFrom } from 'rxjs';
import { Card } from 'src/app/models/models';
import { MyCardsComponent } from '../cards-list/my-cards.component';
import { ApiService } from 'src/app/services/api.service';

@Component({
  selector: 'app-mes-cartes',
  standalone: true,
  imports: [MyCardsComponent],
  templateUrl: './mes-cartes.component.html',
  styleUrl: './mes-cartes.component.css'
})
export class MesCartesComponent {
  constructor(public http : HttpClient, public serviceApi: ApiService) { }
  listeCartes:Card[]=[];
 ngOnInit() {
    this.getMyCards()
  }

  async getMyCards(){
    this.listeCartes=await this.serviceApi.getPlayersCards()
// this.listeCartes = await lastValueFrom(this.http.get<any>("https://localhost:7179/api/Card/GetPlayersCards"));
console.log(this.listeCartes)
  
  }
}
