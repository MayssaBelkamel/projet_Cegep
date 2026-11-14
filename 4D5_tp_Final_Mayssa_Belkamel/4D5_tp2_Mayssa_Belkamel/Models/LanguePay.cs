using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("LanguePays", Schema = "Caracteristique")]
[Index("PaysId", Name = "IX_LanguePays_PaysId")]
public partial class LanguePay
{
    [Key]
    [Column("LanguePaysID")]
    public int LanguePaysId { get; set; }

    [Column("LangueID")]
    public int LangueId { get; set; }

    [Column("PaysID")]
    public int PaysId { get; set; }

    public int PourcentageLocuteur { get; set; }

    [ForeignKey("LangueId")]
    [InverseProperty("LanguePays")]
    public virtual Langue Langue { get; set; } = null!;

    [ForeignKey("PaysId")]
    [InverseProperty("LanguePays")]
    public virtual Pay Pays { get; set; } = null!;
}
