using ReactSneakers.Entities;
using ReactSneakers.Repositories.Interfaces;
using ReactSneakers.Services.Interfaces;

namespace ReactSneakers.Services
{
    public class SneakerService : ISneakerService
    {
        public readonly ISneakerRepository _sneakerService;

        public SneakerService(ISneakerRepository sneakerService)
        {
            _sneakerService = sneakerService;
        }

        public void DeleteById(int id)
        {
            _sneakerService.DeleteById(id);
        }

        public List<Sneaker> Get()
        {
            return _sneakerService.Get();
        }

        public Sneaker GetById(int id)
        {
            return _sneakerService.GetById(id);
        }

        public int Post(Sneaker sneaker)
        {
            return _sneakerService.Post(sneaker);
        }

        public void Put(Sneaker sneaker)
        {
            _sneakerService.Put(sneaker);
        }
    }
}