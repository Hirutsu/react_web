using Dapper;
using Npgsql;
using ReactSneakers.Entities;
using ReactSneakers.Repositories.Interfaces;
using System.Data;
using System.Data.SqlClient;
using WebOnkoDis.Helper;

namespace ReactSneakers.Repositories
{
    public class AccountRepository : IAccountRepository
    {
        private DbOptions _dbOptions;

        public AccountRepository(DbOptions dbOptions)
        {
            _dbOptions = dbOptions;
        }

        public User GetUser(string login)
        {
            using (IDbConnection db = new NpgsqlConnection(_dbOptions.ConnectionString))
            {
                var param = new DynamicParameters();
                param.Add("Login", login);
                var querry = "SELECT * FROM [dbo].[User] WHERE Login = @Login; SELECT SCOPE_IDENTITY();";
                User user = db.Query<User>(querry, param).FirstOrDefault();
                return user;
            }
        }

        userdto -> name years
        gameDto
        user -> name years List<Game>

        public void UpdateAdmin(User user)
        {
            using (IDbConnection db = new NpgsqlConnection(_dbOptions.ConnectionString))
            {
                var param = new DynamicParameters();
                param.Add("Id", user.Id);
                param.Add("Login", user.Login);
                param.Add("Password", user.Password);

                var querry = "UPDATE [dbo].[User] SET " +
                    "Login = @Login, " +
                    "Password = @Password " +
                    "WHERE Id = @Id";

                db.Query(querry, param);
            }
        }
    }
}
