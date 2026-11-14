using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using _4D5_tp2_Mayssa_Belkamel.Data;
using _4D5_tp2_Mayssa_Belkamel.Models;
using Microsoft.AspNetCore.Authorization;
using _4D5_tp2_Mayssa_Belkamel.ViewModel;
using Microsoft.Data.SqlClient;

namespace _4D5_tp2_Mayssa_Belkamel.Controllers
{
    public class PaysController : Controller
    {
        private readonly BD4D5_Pays_MondeContext _context;

        public PaysController(BD4D5_Pays_MondeContext context)
        {
            _context = context;
        }


        // GET: Pays
        public async Task<IActionResult> Index()
        {
            var bD4D5_Pays_MondeContext = _context.Pays.Include(p => p.Continent);
            return View(await bD4D5_Pays_MondeContext.ToListAsync());
        }

        public async Task<IActionResult> IndexVue()
        {
        
            return View(await _context.VwPaysInfos.ToListAsync());
        }

        // GET: Pays/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var pay = await _context.Pays
                .Include(p => p.Continent)
                .FirstOrDefaultAsync(m => m.PaysId == id);
            if (pay == null)
            {
                return NotFound();
            }

            var drapeau =  _context.Drapeaus.FirstOrDefault(m => m.PaysId == id);

            string photoBase64 = null;
            if(drapeau != null && drapeau.Photo != null && drapeau.Photo.Length > 0)
            {
                photoBase64 =drapeau.Photo==null?null: $"data:image/png;base64,{Convert.ToBase64String(drapeau.Photo)}";
            }

            PaysImageViewModel paysImageViewModel = new PaysImageViewModel
            {
                PaysId = pay.PaysId,
                NomsPays=pay.Nom,
                Superficie=pay.Superficie,
                DateIndependance=pay.DateIndependance?.ToString("yyyy-MM-dd"),
                Continent=pay.Continent.Nom,
                PhotosPays= photoBase64
            };

            return View(paysImageViewModel);
        }



        
        public async Task<IActionResult> DetailsPays(int? id)
        {
            VwPaysInfo vwPaysInfo = _context.VwPaysInfos.FirstOrDefault(v => v.PaysId == id);

            if(vwPaysInfo == null)
            {
                return NotFound();
            }

            var langues = await _context.LanguePays.Where(lp => lp.PaysId == id).Include(lp => lp.Langue) .Select(lp => lp.Langue.Nom).ToListAsync();

            var climats = await _context.ClimatPays.Where(cp => cp.PaysId == id).Include(cp => cp.Climat).Select(lp => lp.Climat.Type).ToListAsync();

            DetailsPaysViewModel detailsPaysViewModel = new DetailsPaysViewModel
            {

                pays = vwPaysInfo.Pays,
                Continent = vwPaysInfo.Continent,
                Capitale = vwPaysInfo.Capitale,
                Langues = langues,
                Climats = climats
            };

            return View(detailsPaysViewModel);
        }

        // GET: Pays/Create
        public IActionResult Create()
        {
            ViewData["ContinentId"] = new SelectList(_context.Continents, "ContinentId", "ContinentId");
            return View();
        }
        
        // POST: Pays/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PaysId,ContinentId,Nom,Superficie,DateIndependance")] Pay pay)
        {
            if (ModelState.IsValid)
            {
                _context.Add(pay);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["ContinentId"] = new SelectList(_context.Continents, "ContinentId", "ContinentId", pay.ContinentId);
            return View(pay);
        }

        // GET: Pays/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var pay = await _context.Pays.FindAsync(id);
            if (pay == null)
            {
                return NotFound();
            }
            ViewData["ContinentId"] = new SelectList(_context.Continents, "ContinentId", "ContinentId", pay.ContinentId);
            return View(pay);
        }

        // POST: Pays/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("PaysId,ContinentId,Nom,Superficie,DateIndependance")] Pay pay)
        {
            if (id != pay.PaysId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(pay);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!PayExists(pay.PaysId))
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
            ViewData["ContinentId"] = new SelectList(_context.Continents, "ContinentId", "ContinentId", pay.ContinentId);
            return View(pay);
        }

        // GET: Pays/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var pay = await _context.Pays
                .Include(p => p.Continent)
                .FirstOrDefaultAsync(m => m.PaysId == id);
            if (pay == null)
            {
                return NotFound();
            }

            return View(pay);
        }

        // POST: Pays/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var pay = await _context.Pays.FindAsync(id);
            if (pay != null)
            {
                _context.Pays.Remove(pay);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool PayExists(int id)
        {
            return _context.Pays.Any(e => e.PaysId == id);
        }

    //    [Authorize]
        [HttpGet]
        public async Task<IActionResult> FiltreResultat()
        {
            ViewBag.Contients=_context.Continents.ToList();
            ViewBag.Langues=_context.Langues.ToList();

            return View(new FiltrePaysViewModel
            {
                paysFiltreResults = new List<PaysFiltreResult>()
            });
        }

        
        
   //     [Authorize]
        [HttpPost]
        public async Task<IActionResult> FiltreResultat(FiltrePaysViewModel filtrePaysViewModel)
        {
            string query = "EXEC Geographie.USP_PaysFiltreSimple @ContinentID, @LangueNom, @DoitAvoirCapital";
            ViewBag.Contients = _context.Continents.ToList();
            ViewBag.Langues = _context.Langues.ToList();
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter{ParameterName="@ContinentID", Value=filtrePaysViewModel.contientId},
                new SqlParameter{ParameterName="@LangueNom", Value=filtrePaysViewModel.Langue},
                new SqlParameter{ParameterName="@DoitAvoirCapital", Value=filtrePaysViewModel.DoitAvoirCapital}
            };

            filtrePaysViewModel.paysFiltreResults = _context.PaysFiltreResults.FromSqlRaw(query, parameters.ToArray()).AsEnumerable().ToList();

            return View(filtrePaysViewModel);

        }
        
    }
}
