using Models.Models;

namespace WebApi.Combat
{
    public class StartMatchEvent : MatchEvent
    {
        public override string EventType => "StartMatch";

        public StartMatchEvent(Match match, MatchPlayerData currentPlayerData, MatchPlayerData opposingPlayerData, int nbCardsToDraw, int nbManaPerTurn)
        {
            Events = new List<MatchEvent> { };

            // On pige les cartes du début
            for (int i = 0; i < nbCardsToDraw; i++)
            {
                Events.Add(new DrawCardEvent(currentPlayerData));
                Events.Add(new DrawCardEvent(opposingPlayerData));
            }

            Events.Add(new PlayerStartTurnEvent(currentPlayerData, nbManaPerTurn));
        }
    }
}
