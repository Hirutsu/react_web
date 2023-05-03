using ReactSneakers.Entities;

namespace ReactSneakers.Repositories.Interfaces
{
    public interface IAccountRepository
    {
        User GetUser(string login);
        void UpdateAdmin(User user);
    }
}
