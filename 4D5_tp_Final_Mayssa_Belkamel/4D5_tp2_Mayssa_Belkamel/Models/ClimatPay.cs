using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("ClimatPays", Schema = "Caracteristique")]
public partial class ClimatPay
{
    [Key]
    [Column("ClimatPaysID")]
    public int ClimatPaysId { get; set; }

    [Column("ClimatID")]
    public int ClimatId { get; set; }

    [Column("PaysID")]
    public int PaysId { get; set; }

    [ForeignKey("ClimatId")]
    [InverseProperty("ClimatPays")]
    public virtual Climat Climat { get; set; } = null!;

    [ForeignKey("PaysId")]
    [InverseProperty("ClimatPays")]
    public virtual Pay Pays { get; set; } = null!;
}
