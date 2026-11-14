namespace _4D5_tp2_Mayssa_Belkamel.ViewModel
{
    public class DetailsPaysViewModel
    {
        public string pays { get; set; } = null!;
        public string Continent { get; set; } = null!;
        public string Capitale { get; set; } = null!;
        public List<string> Langues { get; set; } = new();
        public List<string> Climats { get; set; } = new();
    }
}
