using ReactSneakers.Entities;

namespace ReactSneakers.Repositories.Interfaces
{
    public interface ISneakerRepository
    {
        public int Post(Sneaker sneaker);
        public List<Sneaker> Get();
        public Sneaker GetById(int id);
        public void DeleteById(int id);
        public void Put(Sneaker sneaker);
    }
}
