using Models.Models;

namespace WebApi.Combat
{
    public class PlayerStartTurnEvent : MatchEvent
    {
        public override string EventType => "PlayerStartTurn";

        public int PlayerId { get; set; }
        // L'évènement lorsqu'un joueur débutte son tour
        public PlayerStartTurnEvent(MatchPlayerData playerData, int nbManaPerTurn)
        {
            PlayerId = playerData.PlayerId;
            Events = new List<MatchEvent>();

            // TODO: Faire piger UNE carte (celle qui est pigé à chaque début de tour)
            Events.Add(new DrawCardEvent(playerData));
            // TODO: Faire gagner le Mana selon la configuration
            Events.Add(new GainManaEvent(playerData, nbManaPerTurn));
        }

    }
}
