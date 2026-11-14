using System.Security.Claims;
using System.Security.Principal;
using _4D5_tp2_Mayssa_Belkamel.Data;
using _4D5_tp2_Mayssa_Belkamel.Models;
using _4D5_tp2_Mayssa_Belkamel.ViewModel;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;


namespace _4D5_tp2_Mayssa_Belkamel.Controllers
{
    public class ClientsController : Controller
    {
        readonly BD4D5_Pays_MondeContext _context;
        public ClientsController(BD4D5_Pays_MondeContext context)
        {
            _context = context;
        }

        public IActionResult Inscription()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Inscription(IncriptionViewModel ivm)
        {
            // A COMPLETER LORS DE L'ETAPE 1
            bool existeDeja = await _context.Clients.AnyAsync(x => x.Courriel == ivm.Courriel);
            if (existeDeja)
            {
                ModelState.AddModelError("Courriel", "Ce courriel est déjà pris.");
                return View(ivm);
            }
            string query = "EXEC Clients.USP_CreerClient @Nom, @Prenom, @Courriel, @MotDePasse";
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter{ParameterName="@Nom", Value=ivm.Nom},
                new SqlParameter{ParameterName="@Prenom", Value=ivm.Prenom},
                new SqlParameter{ParameterName="@Courriel", Value=ivm.Courriel},
                new SqlParameter{ParameterName="@MotDePasse", Value=ivm.MotDePasse}
            };
            try
            {
                await _context.Database.ExecuteSqlRawAsync(query, parameters.ToArray());
            }
            catch (Exception)
            {
                ModelState.AddModelError("", "Une erreur est survenue. Veuillez réessayer");
                return View(ivm);
            }
            return RedirectToAction("Connexion", "Clients");
        }
        public IActionResult Connexion()
        {

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Connexion(ConnexionViewModel cvm)
        {
            // A COMPLETER LORS DE L'ÉTAPE 1
            //exécution de la procédure pour la connection d'un utilisateur
            string query = "EXEC Clients.USP_AuthClient @Courriel, @MotDePasse";
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter{ParameterName="@Courriel", Value=cvm.Courriel},
                new SqlParameter{ParameterName="@MotDePasse", Value=cvm.MotDePasse},

            };
            Client? client = (await _context.Clients.FromSqlRaw(query, parameters.ToArray()).ToListAsync()).FirstOrDefault();
            if (client == null)
            {
                ModelState.AddModelError("", "Nom d'utilisateur ou mot de passe invalide");
                return View(cvm);
            }

            // Construction du cookie d'authentification 
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, client.ClientId.ToString()),
                new Claim(ClaimTypes.Name, client.Courriel)
            };

            ClaimsIdentity identite = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            ClaimsPrincipal principal = new ClaimsPrincipal(identite);

            // Cette ligne fournit le cookie à l'utilisateur
            await HttpContext.SignInAsync(principal);
            return RedirectToAction("Index", "Clients");
        }
        public async Task<IActionResult> Index()
        {
            ViewData["PrenomNom"] = "visiteur";
            IIdentity? identite = HttpContext.User.Identity;
            if (identite != null && identite.IsAuthenticated)
            {
                string courriel = HttpContext.User.FindFirstValue(ClaimTypes.Name);
                Client? client = await _context.Clients.FirstOrDefaultAsync(x => x.Courriel == courriel);
                if (client != null)
                {
                    // Pour dire "Bonjour X" sur l'index
                    ViewData["PrenomNom"] = client.Prenom + " " + client.Nom;
                }
            }
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> Deconnexion()
        {
            // Cette ligne mange le cookie 🍪 Slurp
            await HttpContext.SignOutAsync();
            return RedirectToAction("Index", "Clients");
        }
    }
}
