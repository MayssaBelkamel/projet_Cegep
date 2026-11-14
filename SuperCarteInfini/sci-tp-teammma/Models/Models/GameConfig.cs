using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    [Display(Name = "Configuration")]
    public class GameConfig : Interfaces.IModel
    {
        public GameConfig() { }
        public int Id { get; set; }
        [Display(Name = "Nb. cartes à piger")]
        public int NbDrawedCard { get; set; }
        [Display(Name = "Mana par tour")]
        public int ReceivedMana { get; set; }
    }
}
