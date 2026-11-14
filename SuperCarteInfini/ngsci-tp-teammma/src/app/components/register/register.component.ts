import { Component, OnInit } from '@angular/core';
import { ApiService } from 'src/app/services/api.service';
import { AbstractControl, FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, ValidationErrors, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';
import { Router } from '@angular/router';
import { MatChipInput } from '@angular/material/chips';
import { MatButtonModule } from '@angular/material/button';
import {MatInputModule} from '@angular/material/input';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [FormsModule, CommonModule, RouterLink, ReactiveFormsModule,MatButtonModule, MatInputModule ],
  templateUrl: './register.component.html',
  styleUrl: './register.component.css'
})
export class RegisterComponent implements OnInit {


  registerForm! : FormGroup;

  constructor(public accService: AccountService, public router : Router, private formBuilder:FormBuilder) {}
  ngOnInit(): void {
    this.registerForm = this.formBuilder.group({
      username: ['', [Validators.required]],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      confirmPassword: ['', [Validators.required]]
    }, { 
      validators: this.passwordMatchValidator
    });
  }

  passwordMatchValidator(control: AbstractControl): ValidationErrors | null {
    const password = control.get('password');
    const confirmPassword = control.get('confirmPassword');
    
    if (password && confirmPassword && password.value !== confirmPassword.value) {
      confirmPassword.setErrors({ passwordMismatch: true });
      return { passwordMismatch: true };
    }
    return null;
  }

  async onEnregistrer(){
    if (this.registerForm.invalid) {
      alert("Veuillez remplir correctement tous les champs.");
      return;
    }
    const { username, email, password, confirmPassword } = this.registerForm.value;
    try{
      await this.accService.register(username, email, password, confirmPassword);
      console.log('Inscription Réussi');
      alert('Compte créé avec succès !!!')
      try{
              await this.accService.login(username, password)
              this.router.navigate(['/home']);
              console.log('Connexion Réussi');

      }
      catch{
        console.log("Pas réussis")
      }

    }
    catch(error: any){
      if (error.status === 400 || error.error === 'User already exists') {
        console.log("utilisateur existe déjà")
        alert("L'utilisateur possède déjà un compte")
      }
    }
  }

}
