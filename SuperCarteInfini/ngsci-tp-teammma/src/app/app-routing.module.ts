import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { MatchComponent } from './match/match.component';
import { WelcomeComponent } from './components/welcome/welcome.component';
import { EventDebuggerComponent } from './components/event-debugger/event-debugger.component';
import { card } from 'mermaid/dist/rendering-util/rendering-elements/shapes/card';
import { MyCardsComponent } from './components/cards-list/my-cards.component';
import { CardComponent } from './components/card/card.component';
import { MagasinComponent } from './components/magasin/magasin.component';
import { MesCartesComponent } from './components/mes-cartes/mes-cartes.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { loginGuard } from './services/login.guard';

const routes: Routes = [

  {
    
    path: 'event-debugger',
    component: EventDebuggerComponent,
  },
  { path: 'login', component: LoginComponent},
  { path: 'register', component: RegisterComponent},
  { path: 'match/:id', component: MatchComponent, canActivate: [loginGuard] },
  
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  {
    path: 'home', component: HomeComponent, canActivate: [loginGuard], children: [
      { path: '', component: WelcomeComponent },
      {path:"mesCartes",component:MesCartesComponent, canActivate: [loginGuard]},
      {path:"allCards",component:MagasinComponent},
    ]
  },
  { path: '**', redirectTo: '/login' },

];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
