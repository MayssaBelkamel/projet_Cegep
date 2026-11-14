using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("Drapeau", Schema = "Geographie")]
[Index("Identifiant", Name = "UC_Drapeau_Identfiant", IsUnique = true)]
public partial class Drapeau
{
    [Key]
    public int DrapeauId { get; set; }

    public Guid Identifiant { get; set; }

    public int PaysId { get; set; }

    public byte[]? Photo { get; set; }

    [ForeignKey("PaysId")]
    [InverseProperty("Drapeaus")]
    public virtual Pay Pays { get; set; } = null!;
}
