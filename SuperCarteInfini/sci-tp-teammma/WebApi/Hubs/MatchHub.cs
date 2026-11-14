using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json.Linq;
using WebApi.Services;

namespace WebApi.Hubs;

[Authorize] 
public class MatchHub : Hub
{
    private readonly MatchesService _matchesService;

    public MatchHub(MatchesService matchesService)
    {
        _matchesService = matchesService;
    }



    public override async Task OnConnectedAsync()
    {
        await base.OnConnectedAsync();
    }

    public override async Task OnDisconnectedAsync(Exception? exception)
    {
        await _matchesService.StopJoiningMatch(Context.ConnectionId);
        await base.OnDisconnectedAsync(exception);
    }

    public async Task StopJoiningMatch()
    {
        await _matchesService.StopJoiningMatch(Context.ConnectionId);
    }

    public async Task JoinMatch(int? specificMatchId)
    {
        string userId = Context.UserIdentifier!;
        string connectionId = Context.ConnectionId;

        var joiningData = await _matchesService.JoinMatch(userId, connectionId, specificMatchId);

        if (joiningData == null)
        {
            return;
        }

        await Groups.AddToGroupAsync(connectionId, joiningData.Match.Id.ToString());

        if (joiningData.OtherPlayerConnectionId != null)
        {
            await Groups.AddToGroupAsync(joiningData.OtherPlayerConnectionId, joiningData.Match.Id.ToString());
            await Clients.Client(joiningData.OtherPlayerConnectionId).SendAsync("MatchJoined", joiningData);
        }

        await Clients.Client(connectionId).SendAsync("MatchJoined", joiningData);
        //await Clients.Group(joiningData.Match.Id.ToString()).SendAsync("MatchJoined", joiningData);

        if (!joiningData.IsStarted)
        {
            var startEvent = await _matchesService.StartMatch(userId, joiningData.Match);
            await Clients.Group(joiningData.Match.Id.ToString()).SendAsync("ReceiveMatchEvent", startEvent);
        }
    }
    public async Task Surrender(int matchId)
    {
        string userId = Context.UserIdentifier!;

        var surrenderEvent = await _matchesService.Surrender(userId, matchId);

        await Clients.Group(matchId.ToString()).SendAsync("ReceiveMatchEvent", surrenderEvent);
    }
    public async Task EndTurn(int matchId)
    {
        string userId = Context.UserIdentifier!;
        var endTurnEvent = await _matchesService.EndTurn(userId, matchId);
        await Clients.Group(matchId.ToString()).SendAsync("ReceiveMatchEvent", endTurnEvent);
    }
}

