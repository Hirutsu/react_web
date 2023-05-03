using ReactSneakers.Entities;
using ReactSneakers.Repositories.Interfaces;
using ReactSneakers.Services.Interfaces;

namespace ReactSneakers.Services
{
    public class AccountService : IAccountService
    {
        public readonly IAccountRepository _accountRepository;

        public AccountService(IAccountRepository accountRepository)
        {
            _accountRepository = accountRepository;
        }

        public User GetUser(string login)
        {
            User user = _accountRepository.GetUser(login);
            return user;
        }

        public bool Login(User user)
        {
            if (user == null || string.IsNullOrEmpty(user.Login))
            {
                return false;
            }

            var CurUser = GetUser(user.Login);
            if (CurUser == null)
            {
                return false;
            }

            return (CurUser.Password == user.Password);
        }

        public void UpdateAdmin(User user)
        {
            _accountRepository.UpdateAdmin(user);
        }
    }
}
