using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using JuliePro.Data;
using JuliePro.Models;
using JuliePro.ViewModels;
using JuliePro.Services;

namespace JuliePro.Controllers
{
    public class RecordController : Controller
    {
        private RecordService _serviceRecord { get; set; }

        public RecordController(RecordService serviceRecord)
        {
            _serviceRecord = serviceRecord;
        }


        // GET: Record
        public async Task<IActionResult> Index()
        {
            var records  = await _serviceRecord.GetAllAsync()/*.Records.Include(x => x.Discipline).Include(x => x.Trainer)*/;
            return View(records);
        }
       

        // GET: Record/Details/5

public async Task<IActionResult> Details(int? id)
{
    if (id == null)
    {
        return NotFound();
    }
         var records = await _serviceRecord.GetByIdAsync(id.Value);
            /*
            var @record = await _context.Records
                .Include(x => x.Discipline)
                .Include(x => x.Trainer)
                .FirstOrDefaultAsync(m => m.Id == id);
            */
            if (records == null)
            {
                return NotFound();
            }

            return View(records);
        }

        // GET: Record/Create
        
        public IActionResult Create()

        {
            //  ViewData["Discipline_Id"] = new SelectList(_context.Disciplines, "Id", "Id");
            // ViewData["Trainer_Id"] = new SelectList(_context.Trainers, "Id", "Email");
/*
            record.ListDisciplines = _context.Disciplines.Select(t => new SelectListItem
            {
                Text = t.Name,
                Value = t.Id.ToString()
            }).OrderBy(t => t.Text);

            record.ListTrainers = _context.Trainers.Select(t => new SelectListItem
            {
                Text = t.FullName,
                Value = t.Id.ToString()
            }).OrderBy(t => t.Text);

*/
            RecordViewModel recordViewModel= new RecordViewModel
            {
                ListDisciplines = _serviceRecord.GetListDisciplines(),
                ListTrainers = _serviceRecord.GetListTrainers()
            };
            return View(recordViewModel);
        } 


            //record



        

        // POST: Record/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(RecordViewModel records)
        {
            if (ModelState.IsValid)
            {
               await _serviceRecord.CreateAsync(records.Record);
                return RedirectToAction(nameof(Index));
            }
           
            
                records.ListDisciplines = _serviceRecord.GetListDisciplines();
                records.ListTrainers = _serviceRecord.GetListTrainers();
            
            return View(records);
        }

        // GET: Record/Edit/5
        
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            RecordViewModel records = new RecordViewModel();
            records.Record=await _serviceRecord.GetByIdAsync(id.Value);
            if (records == null)
            {
                return NotFound();
            }

            records.ListDisciplines = _serviceRecord.GetListDisciplines();
            records.ListTrainers = _serviceRecord.GetListTrainers();
            
            return View(records);
        }

        // POST: Record/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, RecordViewModel records)
        {
            if (id != records.Record.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    await _serviceRecord.EditAsync(records.Record);
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!(await _serviceRecord.ExistsAsync(records.Record.Id)))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            records.ListDisciplines = _serviceRecord.GetListDisciplines();
            records.ListTrainers = _serviceRecord.GetListTrainers();
            return View(records);
        }
        
        // GET: Record/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var record = await _serviceRecord.GetByIdAsync(id.Value);
            if (record == null)
            {
                return NotFound();
            }

            return View(record);
        }

        // POST: Record/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {                                 
            await  _serviceRecord.DeleteAsync(id);
                  
            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> TrainerIndex(int trainerId)
        {
            TrainerRecordViewModel records = await _serviceRecord.GetAllByTrainerAsync(trainerId);

            if (records == null)
            {
                return NotFound();
            }
            return View(records);

        }
        /*
        private async Task<bool> RecordExists(int id)
        {
            return await _serviceRecord.ExistsAsync(id);
        }
        */

    }
}

