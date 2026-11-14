using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class OwnedCard

    {
        public OwnedCard() { }

        public int Id { get; set; }

        public int CardId { get; set; }

        public int PlayerId { get; set; }

    }
}
