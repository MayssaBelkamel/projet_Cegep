using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Models.Data;
using Models.Models;
using Models.Models.Dtos;
using WebApi.Services;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {

        private ApplicationDbContext _dbContext;
        private PlayersService _playersService;
        private readonly UserManager<IdentityUser> _playerManager;
        private readonly SignInManager<IdentityUser> _signInManager;
        public AccountController(ApplicationDbContext dbContext, PlayersService playersService, UserManager<IdentityUser> playerManager, SignInManager<IdentityUser> signInManager)
        {
            _dbContext = dbContext;
            _playersService = playersService;
            _playerManager = playerManager;
            _signInManager = signInManager;
        }

        [HttpPost("Register")]
        public async Task<ActionResult> Register(RegisterDTO register)
        {
            // Si Password et PasswordConfirm sont diférérent, on retourne une erreur.
            if (register.Password != register.PasswordConfirm)
            {
                return StatusCode(StatusCodes.Status400BadRequest,
                    new { Message = "Les deux mots de passe spécifiés sont différents." });
            }

            IdentityUser user = new IdentityUser() { 
                Email = register.Email,
                UserName  = register.Username
            };

            // On tente d'ajouter l'utilisateur dans la base de données. Ça pourrait échouer si le mot de
            // passe ne respecte pas les conditions ou que le pseudonyme est déjà utilisé.
            IdentityResult identityResult = await _playerManager.CreateAsync(user, register.Password);
            // Si la création a échoué, on retourne une erreur. N'hésitez pas à mettre un breakpoint ici
            // pour inspecter l'objet identityResult si vous avez du mal à créer des utilisateurs.
            if (!identityResult.Succeeded)
            {
                return StatusCode(StatusCodes.Status400BadRequest,
                    new { Message = "La création de l'utilisateur a échoué." });
            }

            Player p = await _playersService.CreatePlayer(user);

            return Ok(new { p } ) ;
        }
        [HttpPost("Login")]
        public async Task<ActionResult> Login(LoginDTO loginDTO)
        {
            var result = await _signInManager.PasswordSignInAsync(loginDTO.Username, loginDTO.Password, true, lockoutOnFailure: false);

            if (result.Succeeded)
            {
                Claim? nameIdentifierClaim = User.Claims?.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier);

                // Note: On ajoute simplement le NameIdentifier dans les claims. Il n'y aura pas de rôle pour les utilisateurs du WebAPI.
                List<Claim> authClaims = new List<Claim>();
                authClaims.Add(nameIdentifierClaim);

                SymmetricSecurityKey signingKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("C'est tellement la meilleure cle qui a jamais ete cree dans l'histoire de l'humanite (doit etre longue)"));

                string issuer = this.Request.Scheme + "://" + this.Request.Host;
                var user = await _playerManager.FindByNameAsync(loginDTO.Username);
                if (user == null)
                {
                    return NotFound(new { Error = "Utilisateur introuvable" });
                }



                DateTime expirationTime = DateTime.Now.AddMinutes(30);

                JwtSecurityToken token = new JwtSecurityToken(
                    issuer: issuer,
                    audience: null,
                    claims: authClaims,
                    expires: expirationTime,
                    signingCredentials: new SigningCredentials(signingKey, SecurityAlgorithms.HmacSha256Signature)
                );

                string tokenString = new JwtSecurityTokenHandler().WriteToken(token);
                string userId = user.Id;

                var playerId = _playersService.GetPlayerFromUserId(userId).Id;

                // On ne veut JAMAIS retouner une string directement lorsque l'on utilise Angular.
                // Angular assume que l'on retourne un objet et donne une erreur lorsque le résultat obtenu est une simple string!
                return Ok(new LoginSuccessDTO() { Token = tokenString, UserId =  userId, PlayerId = playerId});
            }

            return NotFound(new { Error = "L'utilisateur est introuvable ou le mot de passe ne concorde pas" });
        }

        [Authorize]
        [HttpGet("PrivateData")]
        public ActionResult<string[]> PrivateData()
        {
            return new string[] { "figue", "banane", "noix" };
        }

    }
}
