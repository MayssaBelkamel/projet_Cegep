using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Models.Data;
using Models.Models;

namespace Super_Cartes_Infinies.Controllers
{
    [Authorize(Roles = "admin")]
    public class StartingCardsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public StartingCardsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: StartingCards
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.StartingCards.Include(s => s.Card);
            return View(await applicationDbContext.OrderBy(n=> n.Card.Name).ToListAsync());
        }

        // GET: StartingCards/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var startingCard = await _context.StartingCards
                .Include(s => s.Card)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (startingCard == null)
            {
                return NotFound();
            }

            return View(startingCard);
        }

        // GET: StartingCards/Create
        public IActionResult Create()
        {
            ViewBag.CardId = new SelectList(_context.Cards, "Id", "Name");
            return View();
        }

        // POST: StartingCards/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(StartingCard startingCard)
        {
            if (ModelState.IsValid)
            {
                _context.Add(startingCard);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewBag.CardId = new SelectList(_context.Cards, "Id", "Name", startingCard.CardId);
            return View(startingCard);
        }

        // GET: StartingCards/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var startingCard = await _context.StartingCards.FindAsync(id);
            if (startingCard == null)
            {
                return NotFound();
            }
            ViewBag.CardId = new SelectList(_context.Cards, "Id", "Name", startingCard.CardId);
            return View(startingCard);
        }

        // POST: StartingCards/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, StartingCard startingCard)
        {
            if (id != startingCard.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(startingCard);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!StartingCardExists(startingCard.Id))
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
            ViewBag.CardId = new SelectList(_context.Cards, "Id", "Name", startingCard.CardId);
            return View(startingCard);
        }

        // GET: StartingCards/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var startingCard = await _context.StartingCards
                .Include(s => s.Card)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (startingCard == null)
            {
                return NotFound();
            }

            return View(startingCard);
        }

        // POST: StartingCards/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var startingCard = await _context.StartingCards.FindAsync(id);
            if (startingCard != null)
            {
                _context.StartingCards.Remove(startingCard);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool StartingCardExists(int id)
        {
            return _context.StartingCards.Any(e => e.Id == id);
        }
    }
}
