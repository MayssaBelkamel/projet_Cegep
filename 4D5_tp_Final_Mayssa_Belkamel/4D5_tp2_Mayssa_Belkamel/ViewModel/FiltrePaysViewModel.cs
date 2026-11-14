using _4D5_tp2_Mayssa_Belkamel.Models;

namespace _4D5_tp2_Mayssa_Belkamel.ViewModel
{
    public class FiltrePaysViewModel
    {
        public int contientId { get; set; }
        public string Langue { get; set; }
        public bool DoitAvoirCapital { get; set; }
        public List<PaysFiltreResult>? paysFiltreResults{ get; set; }

        
    }
}
