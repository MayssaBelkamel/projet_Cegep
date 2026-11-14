import { Component, OnInit } from '@angular/core';
import { ApiService } from 'src/app/services/api.service';
import { FormBuilder, FormGroup, FormsModule, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';
import { MatButtonModule } from '@angular/material/button';
import {MatInputModule} from '@angular/material/input';
import { MatchHubService } from 'src/app/services/match-hub.service.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule, CommonModule, RouterLink, ReactiveFormsModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent implements OnInit{

  loginForm!: FormGroup;
  serverError: string | null = null;


  constructor(public accService: AccountService, private formBuilder: FormBuilder, private router: Router, private matchHub: MatchHubService) {}
  ngOnInit(): void {
    this.loginForm = this.formBuilder.group({
      username: ['', [Validators.required]],
      password: ['', [Validators.required]]
    });

  }

  async onLogin(): Promise<void> {
    this.serverError = null;
    if (this.loginForm.invalid) return;

    const { username, password } = this.loginForm.value;
    try{
          await this.accService.login(username,password);
    }catch(error:any){
      if (error.status === 0) {
        this.serverError = "Le serveur ne répond pas. Veuillez réessayer plus tard.";
      } else if (error.status === 404) {
        console.log( "Nom d'utilisateur ou mot de passe incorrect.");
      } else {
        this.serverError = error.error || "Une erreur inconnue est survenue.";
      }
    }

  }

}
