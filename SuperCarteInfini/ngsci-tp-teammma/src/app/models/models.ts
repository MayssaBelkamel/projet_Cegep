export interface Player {
    id: number;
    name: string;
    ownedCards?: OwnedCard[]
}

export interface Card {
    id: number;
    name: string;
    attack: number;
    health: number;
    cost: number;
    imageUrl: string;
    ownedCards?: OwnedCard[]
}

export interface OwnedCard {
    id: number;
    cardId: number;
    playerId: number;
}

export interface MatchData {
    match: Match;
    playerA: Player;
    playerB: Player;
    winningPlayerId: number;
}

export interface Match {
    id: number;
    isMatchCompleted: boolean;
    isPlayerATurn: boolean;
    playerDataA: PlayerData;
    playerDataB: PlayerData;
}

export interface PlayableCard {
    id: number;
    card: Card;
    health: number;
}

export interface PlayerData {
    id: number;
    health: number;
    maxhealth: number;
    mana: number;
    playerId: number;
    playerName: string;
    cardsPile: PlayableCard[];
    hand: PlayableCard[];
    battleField: PlayableCard[];
    graveyard: PlayableCard[];
}

export interface MatchEvent {
    eventType: string;
    events: MatchEvent[];
}

export interface RegisterDTO{
    username : string;
    email : string;
    password : string;
    passwordConfirm : string;
}

export interface LoginDTO{
    username : string;
    password : string;
}
