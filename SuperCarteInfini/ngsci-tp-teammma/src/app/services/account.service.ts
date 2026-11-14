import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { lastValueFrom } from 'rxjs';
import { LoginDTO, RegisterDTO } from '../models/models';
import { Router } from '@angular/router';
import { MatchHubService } from './match-hub.service.service';

const TOKEN_LOCALSTORAGE_KEY = "token";

@Injectable({
  providedIn: 'root'
})
export class AccountService {

  apiBaseUrl = "https://localhost:7179/api/"
  accountBaseUrl = this.apiBaseUrl + "Account/";
  nomUser = "";
  constructor(public http: HttpClient, public router : Router, private matchHub: MatchHubService) { }

  async privateData(){    
    console.log(this.accountBaseUrl + "PrivateData")
    let x = await lastValueFrom(this.http.get<any>(this.accountBaseUrl + "PrivateData"));
    return x;

  }

  async register(user : string, mail : string, pass : string, passCon : string): Promise<void> {
       let registerDTO : RegisterDTO = {
        username : user,
        email : mail,
        password : pass,
        passwordConfirm : passCon
      }
  
      let result = await lastValueFrom(this.http.post<any>(this.accountBaseUrl + "Register", registerDTO));
      sessionStorage.setItem(TOKEN_LOCALSTORAGE_KEY, result.token)
      return result;
    }

  async login(user: string, pass: string): Promise<void>{
    let loginDTO : LoginDTO = {
      username : user,
      password : pass
    }
    this.nomUser = user;

      
    sessionStorage.setItem("playerName", this.nomUser)
    let result = await lastValueFrom(this.http.post<any>(this.accountBaseUrl + "Login",loginDTO));
      if(result?.token){
        sessionStorage.setItem(TOKEN_LOCALSTORAGE_KEY, result.token)
        sessionStorage.setItem("UserId", String(result.userId))
        sessionStorage.setItem("PlayerId", String(result.playerId))
        console.log("token enregistré correctement : UserId =", result.userId)
        await this.matchHub.startConnection();
        this.router.navigate(['/home'])
        console.log("connexion réussie");
    }
    return result;
  }

  async publicCall() : Promise<string[]>{
    return await lastValueFrom(this.http.get<any>(this.accountBaseUrl + 'PublicTest'));
  }

  async privateCall() : Promise<string[]>{
    return await lastValueFrom(this.http.get<any>(this.accountBaseUrl + 'PrivateTest'));
  }

  async logout(){
    // Rien d'autre à faire que d'oublier le Token
    sessionStorage.removeItem(TOKEN_LOCALSTORAGE_KEY);
    sessionStorage.removeItem("UserId");
    sessionStorage.removeItem("PlayerId");
    sessionStorage.removeItem("playerName")
    await this.matchHub.stopConnection();

    console.log("Déconnection réussie")
  }

  isLoggedIn() : Boolean{
    return sessionStorage.getItem(TOKEN_LOCALSTORAGE_KEY) != null;
  }

}

