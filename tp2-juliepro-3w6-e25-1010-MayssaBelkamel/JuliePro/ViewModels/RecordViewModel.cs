using JuliePro.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace JuliePro.ViewModels
{
    public class RecordViewModel
    {
        [ValidateNever]
        public IEnumerable<SelectListItem> ListDisciplines { get; set; }
        [ValidateNever]
        public IEnumerable<SelectListItem> ListTrainers { get; set; }
       
        public Record Record { get; set; }

    }
}
