using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("Pays", Schema = "Geographie")]
[Index("ContinentId", Name = "IX_Pays_ContinentId")]
[Index("Nom", Name = "UC_Pays", IsUnique = true)]
public partial class Pay
{
    [Key]
    [Column("PaysID")]
    public int PaysId { get; set; }

    [Column("ContinentID")]
    public int ContinentId { get; set; }

    [StringLength(50)]
    public string Nom { get; set; } = null!;

    public int Superficie { get; set; }

    public DateOnly? DateIndependance { get; set; }

    [InverseProperty("Pays")]
    public virtual ICollection<ClimatPay> ClimatPays { get; set; } = new List<ClimatPay>();

    [ForeignKey("ContinentId")]
    [InverseProperty("Pays")]
    public virtual Continent Continent { get; set; } = null!;

    [InverseProperty("Pays")]
    public virtual ICollection<Drapeau> Drapeaus { get; set; } = new List<Drapeau>();

    [InverseProperty("Pays")]
    public virtual ICollection<LanguePay> LanguePays { get; set; } = new List<LanguePay>();

    [InverseProperty("Pays")]
    public virtual ICollection<Ville> Villes { get; set; } = new List<Ville>();
}
