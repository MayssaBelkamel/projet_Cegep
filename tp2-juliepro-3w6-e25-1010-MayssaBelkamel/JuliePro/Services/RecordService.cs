using JuliePro.Data;
using JuliePro.Models;
using JuliePro.ViewModels;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace JuliePro.Services
{
    public class RecordService : ServiceBaseEF<Record> 
    {
        public RecordService(JulieProDbContext dbContext) : base(dbContext) { }

        public IEnumerable<SelectListItem> GetListDisciplines() {

            var listDiscipline  = _dbContext.Disciplines.Select(t => new SelectListItem
            {
                Text = t.Name,
                Value = t.Id.ToString()
            }).OrderBy(t => t.Text);
            
            return listDiscipline;
        }

        public IEnumerable<SelectListItem> GetListTrainers()
        {

            var listTrainer = _dbContext.Trainers.Select(t => new SelectListItem
            {
                Text = t.FullName,
                Value = t.Id.ToString()
            });//.OrderBy(t => t.Text);

            return listTrainer;
        }

        public async Task<TrainerRecordViewModel> GetAllByTrainerAsync(int trainerId)
        {
            var trainer = await _dbContext.Trainers.FindAsync(trainerId);
            var model = await _dbContext.Records.Where(x => x.Trainer.Records.Any(y => y.Trainer_Id == trainerId)).ToListAsync();

            return new TrainerRecordViewModel(trainer, model);
        }

    }
}
