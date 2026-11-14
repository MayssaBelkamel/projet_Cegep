import { Component, Input, OnInit } from '@angular/core';
import { Card } from 'src/app/models/models';
import { MatCardModule } from '@angular/material/card';
import { lastValueFrom } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';


@Component({
    selector: 'app-card',
    templateUrl: './card.component.html',
    styleUrls: ['./card.component.css'],
    standalone: true,
    imports: [MatCardModule,CommonModule,    MatSelectModule,
    MatFormFieldModule]
})
export class CardComponent implements OnInit {
  champTri='mana';
  ordreTri='cro';
  @Input() card?:Card;
  @Input() show:string = "front";
  @Input() health:number = 0;
  beautifulBackUrl = "https://i.pinimg.com/236x/3c/73/0d/3c730d6df70700a3c912a3c87d6d2027.jpg";
  
  listeCartes:Card[]=[];

  constructor(public http : HttpClient) { }

  ngOnInit() {
    //this.getAllCards()
  }
/*
  async getAllCards(){
 this.listeCartes = await lastValueFrom(this.http.get<any>("https://localhost:7179/api/Card/GetAllCards"));
  console.log(this.listeCartes);
  }
  */

}
