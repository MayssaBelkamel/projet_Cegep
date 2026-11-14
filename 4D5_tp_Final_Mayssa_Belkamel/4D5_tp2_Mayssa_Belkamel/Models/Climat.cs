using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("Climat", Schema = "Caracteristique")]
public partial class Climat
{
    [Key]
    [Column("ClimatID")]
    public int ClimatId { get; set; }

    [StringLength(50)]
    public string Type { get; set; } = null!;

    public int TempMoyenne { get; set; }

    [InverseProperty("Climat")]
    public virtual ICollection<ClimatPay> ClimatPays { get; set; } = new List<ClimatPay>();
}
