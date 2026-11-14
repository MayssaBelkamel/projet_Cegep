import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { lastValueFrom } from 'rxjs';
import { Card, OwnedCard } from '../models/models';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  serverUrl = "https://localhost:7179/";


  constructor(public http: HttpClient) { }

  async getAllCards(): Promise<Card[]> {
    let result = await lastValueFrom(this.http.get<Card[]>(this.serverUrl+'api/card/GetAllCards'));
    console.log(result);
    return result;
  }

  async getPlayersCards(): Promise<Card[]> {
    const userId = sessionStorage.getItem('UserId');

    if (!userId) {
      return [];
    }

    const ownedCards = await lastValueFrom(this.http.get<OwnedCard[]>(this.serverUrl + 'api/card/GetPlayersCards?userId=' + userId));
    const allCards = await this.getAllCards();
    const result: Card[] = [];

    for (const ownedCard of ownedCards ?? []) {
      const card = allCards.find(c => c.id === ownedCard.cardId);
      if (card) {
        result.push(card);
      }
    }

    console.log(result);
    return result;
  }

}
