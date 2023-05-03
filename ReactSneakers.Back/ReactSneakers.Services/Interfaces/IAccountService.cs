using ReactSneakers.Entities;

namespace ReactSneakers.Services.Interfaces
{
    public interface IAccountService
    {
        bool Login(User user);
        User GetUser(string login);
        void UpdateAdmin(User user);
    }
}
