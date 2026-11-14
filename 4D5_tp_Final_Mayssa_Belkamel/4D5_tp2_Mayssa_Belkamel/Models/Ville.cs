using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("Ville", Schema = "Geographie")]
public partial class Ville
{
    [Key]
    [Column("VilleID")]
    public int VilleId { get; set; }

    [Column("PaysID")]
    public int PaysId { get; set; }

    [StringLength(50)]
    public string Nom { get; set; } = null!;

    public bool EstCapital { get; set; }

    [ForeignKey("PaysId")]
    [InverseProperty("Villes")]
    public virtual Pay Pays { get; set; } = null!;
}
