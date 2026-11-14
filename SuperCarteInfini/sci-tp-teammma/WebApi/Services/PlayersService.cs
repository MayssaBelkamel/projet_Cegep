using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Models.Data;
using Models.Models;

namespace WebApi.Services
{
	public class PlayersService
    {
        private ApplicationDbContext _dbContext;
        private StartingCardsService _startingCardsService;

        public PlayersService(ApplicationDbContext context, StartingCardsService startingCardsService)
        {
            _dbContext = context;
            _startingCardsService = startingCardsService;
        }

        public async Task<Player> CreatePlayer(IdentityUser user)
        {
            Player p = new Player()
            {
                Id = 0,
                UserId = user.Id,
                Name = user.Email!
            };


            // TODO: Utilisez le service StartingCardsService pour obtenir les cartes de départ
            // TODO: Ajoutez ces cartes au joueur en utilisant le modèle OwnedCard que vous allez devoir ajouter
            p.OwnedCards = _startingCardsService.GetStartingCards().Select(c => new OwnedCard { CardId = c.Id, PlayerId = p.Id }).ToList();

            _dbContext.Players.Add(p);
            await _dbContext.SaveChangesAsync();


            return p;
        }

        public virtual Player GetPlayerFromUserId(string userId)
        {
            return _dbContext.Players.Single(p => p.UserId == userId);
        }

        public Player GetPlayerFromUserName(string userName)
        {
            return _dbContext.Players.Single(p => p.User!.UserName == userName);
        }
    }
}

