import { Component, Input } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Card } from '../../models/models';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { CardComponent } from '../card/card.component';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';

@Component({
  selector: 'app-my-cards',
  standalone: true,
  imports: [RouterModule,CommonModule,CardComponent,MatSelectModule,
      MatFormFieldModule ],
  templateUrl: './my-cards.component.html',
  styleUrl: './my-cards.component.css'
})
export class MyCardsComponent {
@Input() listeCartes:Card[]=[];
champTri='';
  ordreTri='';

  constructor(public http : HttpClient) { }

  trierCartes() {

this.listeCartes.sort((a,b)=>{

if(this.champTri == "mana"){

if(this.ordreTri == "cro")
return a.cost - b.cost;

else
return b.cost - a.cost;

}

if(this.champTri == "attaque"){

if(this.ordreTri == "cro")
return a.attack - b.attack;

else
return b.attack - a.attack;

}

if(this.champTri == "vie"){

if(this.ordreTri == "cro")
return a.health - b.health;

else
return b.health - a.health;

}

return 0;

});

}
}
