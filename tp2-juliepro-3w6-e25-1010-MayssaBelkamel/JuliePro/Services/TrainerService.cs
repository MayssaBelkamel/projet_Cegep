using JuliePro.Data;
using JuliePro.Models;
using JuliePro.Utility;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using NuGet.DependencyResolver;

namespace JuliePro.Services
{
    public class TrainerService : ServiceBaseEF<Trainer>
    {
        private IImageFileManager fileManager;

        public TrainerService(JulieProDbContext dbContext, IImageFileManager fileManager) : base(dbContext)
        {
            this.fileManager = fileManager;
        }

        public async Task<Trainer> CreateAsync(Trainer model, IFormCollection form)
        {
            model.Photo = await fileManager.UploadImage(form, false, null);

            return await base.CreateAsync(model);
        }

        public async Task EditAsync(Trainer model, IFormCollection form)
        {
            var old = await _dbContext.Trainers.Where(x => x.Id == model.Id).Select(x => x.Photo).FirstOrDefaultAsync();
            model.Photo = await fileManager.UploadImage(form, true, old);
            await EditAsync(model);
        }

        public async Task<TrainerSearchViewModel> GetAllAsync(TrainerSearchViewModelFilter filter)
        {

            filter.VerifyProperties();//mets à null les éléments qui sont vides. 

            var result = new TrainerSearchViewModel(filter);

            // Pour l'instant, on affiche tout sur la même page, car la pagination n'est pas encore fonctionnel
           // int pageIndex = 0;
           // int pageSize = 10000;
            // TODO: Remplacer par ce code une fois que vous commencez à implémenter la pagination
            int pageIndex = filter.SelectedPageIndex;
            int pageSize = filter.SelectedPageSize;

            //TODO: Ajouter les filtres
     

            
            result.Items = await _dbContext.Trainers.Include(t =>t.TrainerCertifications)
                .Where(t=> filter.SelectedGender==null || t.Genre==filter.SelectedGender)
                .Where(t=> filter.SearchNameText==null || t.FirstName.Contains(filter.SearchNameText) || t.LastName.Contains(filter.SearchNameText))
                .Where(t=> filter.SelectedDisciplineId==null || t.Discipline_Id==filter.SelectedDisciplineId)
               // .Where(t =>filter.SelectedCertificationCenter==null || t.TrainerCertifications)
                .Where(t => filter.SelectedCertificationId == null || t.TrainerCertifications.Any(tc => tc.Certification_Id == filter.SelectedCertificationId))


                .ToPaginatedAsync(pageIndex, pageSize);

            //TODO: Ajouter les éléments dans les SelectLists 
            result.Disciplines = _dbContext.Disciplines.Select(d => new SelectListItem
                {
                    Value = d.Id.ToString(),
                    Text = d.Name
                })
                .ToList()
                .AsEnumerable();


            result.Certifications = _dbContext.Certifications.Select(d => new SelectListItem
            {
                Value = d.Id.ToString(),
                Text = d.Title
            })
             .ToList()
             .AsEnumerable();


            result.CertificationCenters = _dbContext.Certifications.Select(d => new SelectListItem
            {
                Value = d.Id.ToString(),
                Text = d.CertificationCenter
            })
           .ToList()
           .AsEnumerable();
            result.AvailablePageSizes = new SelectList(new List<int>() { 9, 12, 18, 21 });
   

            return result;
        }
    }
}
