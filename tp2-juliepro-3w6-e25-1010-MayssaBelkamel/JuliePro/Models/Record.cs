using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JuliePro.Models
{
    public class Record
    {
        [Display(Name = "Id")] 
        public int Id { get; set; }

        [Required]
        [Display(Name = "Date")] 
        public DateTime Date { get; set; }

        [Required]
        [ForeignKey("Discipline")]
        [Display(Name = "Discipline_Id")] 
        public int? Discipline_Id { get; set; }

        [ValidateNever]
        [Display(Name = "Discipline")]
        public virtual Discipline Discipline { get; set; }

        [ValidateNever]
        [Display(Name = "Amount")]
        [Range(0, 10000, ErrorMessage = "Range")]
        public Decimal Amount { get; set; }

        [ValidateNever]
        [Display(Name = "Unit")]
        [StringLength(50, MinimumLength = 1, ErrorMessage = "Range")]
        public string Unit { get; set; }

        [Required]
        [ForeignKey("Trainer")]
        [Display(Name = "Trainer_Id")] 
        public int? Trainer_Id { get; set; }

        [ValidateNever]
        [Display(Name = "Trainer")] 
        public virtual Trainer Trainer { get; set; }
    }
}