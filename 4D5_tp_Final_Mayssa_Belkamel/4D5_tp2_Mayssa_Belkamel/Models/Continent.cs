using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Table("Continent", Schema = "Geographie")]
public partial class Continent
{
    [Key]
    [Column("ContinentID")]
    public int ContinentId { get; set; }

    [StringLength(50)]
    public string Nom { get; set; } = null!;

    public int Superficie { get; set; }

    [InverseProperty("Continent")]
    public virtual ICollection<Pay> Pays { get; set; } = new List<Pay>();
}
