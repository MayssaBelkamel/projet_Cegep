using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("Langue", Schema = "Caracteristique")]
public partial class Langue
{
    [Key]
    [Column("LangueID")]
    public int LangueId { get; set; }

    [StringLength(50)]
    public string Nom { get; set; } = null!;

    [InverseProperty("Langue")]
    public virtual ICollection<LanguePay> LanguePays { get; set; } = new List<LanguePay>();
}
