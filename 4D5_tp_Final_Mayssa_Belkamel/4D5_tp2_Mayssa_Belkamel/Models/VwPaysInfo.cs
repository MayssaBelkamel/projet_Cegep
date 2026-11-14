using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace _4D5_tp2_Mayssa_Belkamel.Models;

[Keyless]
public partial class VwPaysInfo
{
    public int PaysId { get; set; }

    [StringLength(50)]
    public string Pays { get; set; } = null!;

    [StringLength(50)]
    public string Continent { get; set; } = null!;

    [StringLength(50)]
    public string Capitale { get; set; } = null!;

    [Column("nbrLangue")]
    public int? NbrLangue { get; set; }

    [Column("nbrClimat")]
    public int? NbrClimat { get; set; }
}
