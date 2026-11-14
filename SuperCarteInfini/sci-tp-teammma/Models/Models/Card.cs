using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Models.Interfaces;

namespace Models.Models
{
    [Display(Name = "Carte")]
    public class Card:IModel
	{
		public Card() { }

		public int Id { get; set; }
		[Display(Name="Nom")]
		public string Name { get; set; } = "";
        [Display(Name = "Attaque")]
        public int Attack { get; set; }
        [Display(Name = "Points de vie")]
        public int Health { get; set; }
        [Display(Name = "Coût en Mana")]
        public int Cost { get; set; }
        [Display(Name = "Image")]
        public string ImageUrl { get; set; } = "";
        [ValidateNever]
        public virtual List<CardPower> CardPowers { get; set; }

        public virtual List<OwnedCard> OwnedCards { get; set; } = new List<OwnedCard>();
    }
}

