using ReactSneakers.Entities;

namespace ReactSneakers.Services.Interfaces
{
    public interface ISneakerService
    {
        public int Post(Sneaker sneaker);
        public List<Sneaker> Get();
        public Sneaker GetById(int id);
        public void DeleteById(int id);
        public void Put(Sneaker sneaker);
    }
}
