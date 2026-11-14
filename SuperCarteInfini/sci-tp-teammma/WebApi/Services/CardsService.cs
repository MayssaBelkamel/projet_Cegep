using Microsoft.AspNetCore.Authorization;
using Models.Data;
using Models.Models;

namespace WebApi.Services
{
	public class CardsService
    {
        private ApplicationDbContext _dbContext;
        private PlayersService _playersService;

        public CardsService(ApplicationDbContext dbContext, PlayersService playersService)
        {
            _dbContext = dbContext;
            _playersService = playersService;
        }
        [Authorize]
        public IEnumerable<OwnedCard> GetPlayersCards(string userId)
        {
            Player player = _playersService.GetPlayerFromUserId(userId);
            if (player.OwnedCards == null)
            {
                return new List<OwnedCard>();
            }
            
            // Stub: Pour l'intant, le stub retourne simplement les 8 premières cartes
            // L'implémentation réelle devra utiliser un service et retourner les cartes qu'un joueur possède
            // L'implémentation est la responsabilité de la personne en charge de la partie [Enregistrement et connexion]
            return player.OwnedCards;
        }

        public IEnumerable<Card> GetAllCards()
        {
            return _dbContext.Cards;
        }
    }
}

