using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Microsoft.EntityFrameworkCore.Metadata;
using Models.Interfaces;

namespace Models.Models
{
    [Display(Name = "Carte de Départ")]
    public class StartingCard : Interfaces.IModel
    {
        public StartingCard() { }

        public StartingCard(Card c)
        {
            Card = c;
        }
        public int Id { get; set; }
        [Required]
        public int? CardId { get; set; }
        [ValidateNever]
        public virtual Card Card { get; set; }
    }
}
