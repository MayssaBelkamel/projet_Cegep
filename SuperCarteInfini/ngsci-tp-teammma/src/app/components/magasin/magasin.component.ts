import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { lastValueFrom } from 'rxjs';
import { Card } from 'src/app/models/models';
import { MyCardsComponent } from '../cards-list/my-cards.component';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { ApiService } from 'src/app/services/api.service';

@Component({
  selector: 'app-magasin',
  standalone: true,
  imports: [MyCardsComponent,MatSelectModule,
      MatFormFieldModule],
  templateUrl: './magasin.component.html',
  styleUrl: './magasin.component.css'
})
export class MagasinComponent {
   constructor(public http : HttpClient, public serviceApi: ApiService) { }
listeCartes:Card[]=[];
 

 ngOnInit() {
    this.getAllCards()
  }

  async getAllCards(){
      this.listeCartes=await this.serviceApi.getAllCards()
 //this.listeCartes = await lastValueFrom(this.http.get<any>("https://localhost:7179/api/Card/GetAllCards"));

  
  }
}
