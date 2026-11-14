using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("PaysFiltreResult", Schema = "Geographie")]
public partial class PaysFiltreResult
{
    [Key]
    [Column("PaysID")]
    public int PaysId { get; set; }

    [StringLength(50)]
    public string NomPays { get; set; } = null!;

    [StringLength(50)]
    public string NomContinent { get; set; } = null!;

    public int Superficie { get; set; }

    [StringLength(50)]
    public string? Capitale { get; set; }

    [StringLength(50)]
    public string? LangueFiltre { get; set; }
}
