namespace JuliePro.Models
{
    public class TrainerRecordViewModel
    {
        public TrainerRecordViewModel()
        {
        }
        public TrainerRecordViewModel(Trainer trainer, IEnumerable<Record> records)
        {
            Trainer = trainer;
            Records = records;
        }
        public Trainer Trainer { get; set; }
        public IEnumerable<Record> Records { get; set; }
    }
    

    }



