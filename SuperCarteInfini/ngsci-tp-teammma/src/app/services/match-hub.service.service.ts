import { Injectable } from '@angular/core';
import * as signalR from '@microsoft/signalr';
import { MatchService } from './match.service';
import { RouterModule } from '@angular/router';

@Injectable({
  providedIn: 'root'  
})
export class MatchHubService {

  private hubConnection?: signalR.HubConnection;
  playedId = parseInt(sessionStorage.getItem('PlayerId')!);
    constructor(private matchService: MatchService) { }

  get connection(): signalR.HubConnection {
    if (!this.hubConnection) {
      throw new Error('Hub connection not initialized.');
    }
    return this.hubConnection;
  }

  async startConnection() {
    console.log("ok on rentre")
    console.log("Token envoyé:", sessionStorage.getItem("token"));
    if (this.hubConnection) {
      if (this.hubConnection.state === signalR.HubConnectionState.Disconnected) {
        await this.hubConnection.start();
      }
      return;
    }

    this.hubConnection = new signalR.HubConnectionBuilder()
  .withUrl('https://localhost:7179/matchHub', {
    accessTokenFactory: () => sessionStorage.getItem("token")!,
    withCredentials: true,  
    skipNegotiation: false
  })
  .withAutomaticReconnect()
  .build();

    await this.hubConnection.start();
    console.log('SignalR Connecté');

    this.connection!.on('MatchJoined', (data) => {
    console.log('MatchJoined event received:', data);
        this.matchService.playMatch(data, this.playedId);

  });

      this.connection!.on('ReceiveMatchEvent', (data) => {
    this.matchService.applyEvent(data);
  });

  }

  async stopConnection(): Promise<void> {
    if (!this.hubConnection) return;

    await this.hubConnection.stop();
    this.hubConnection = undefined;
    console.log('SignalR nonononon');}

 async joinMatch(specificMatchId?: number) {
    await this.startConnection();
    return await this.connection.invoke('JoinMatch', specificMatchId);
}

  async endTurn(matchId: number) {
    await this.startConnection();
    await this.connection.invoke('EndTurn', matchId);
  }

  async surrender(matchId: number) {
    await this.startConnection();
    await this.connection.invoke('Surrender', matchId);
  }

}