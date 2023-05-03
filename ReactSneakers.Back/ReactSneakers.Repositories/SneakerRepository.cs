using Dapper;
using Npgsql;
using ReactSneakers.Entities;
using ReactSneakers.Repositories.Interfaces;
using System.Data;
using System.Data.SqlClient;
using WebOnkoDis.Helper;

namespace ReactSneakers.Repositories
{
    public class SneakerRepository : ISneakerRepository
    {
        private DbOptions _dbOptions;

        public SneakerRepository(DbOptions dbOptions)
        {
            _dbOptions = dbOptions;
        }

        public void DeleteById(int id)
        {
            using (IDbConnection db = new NpgsqlConnection(_dbOptions.ConnectionString))
            {
                var param = new DynamicParameters();
                param.Add("id", id);
                var querry = "DELETE FROM Sneaker WHERE Id = @id";
                db.Query(querry, param);
            }
        }

        public List<Sneaker> Get()
        {
            using (IDbConnection db = new NpgsqlConnection(_dbOptions.ConnectionString))
            {
                var querry = "SELECT * FROM Sneaker";
                return db.Query<Sneaker>(querry).ToList();
            }
        }

        public Sneaker GetById(int id)
        {
            using (IDbConnection db = new NpgsqlConnection(_dbOptions.ConnectionString))
            {
                var param = new DynamicParameters();
                param.Add("id", id);
                var querry = "SELECT * FROM Sneaker WHERE Id = @id";
                return db.Query<Sneaker>(querry, param)
                    .FirstOrDefault();
            }
        }

        public int Post(Sneaker sneaker)
        {
            using (IDbConnection db = new NpgsqlConnection(_dbOptions.ConnectionString))
            {
                var querry = "INSERT INTO Sneaker (Title, Price, Img) " +
                    "VALUES (@Title, @Price, @Img); SELECT SCOPE_IDENTITY();";
                return (int)(db.Query<decimal>(querry, sneaker).FirstOrDefault());
            }
        }

        public void Put(Sneaker sneaker)
        {
            using (IDbConnection db = new NpgsqlConnection(_dbOptions.ConnectionString))
            {
                var param = new DynamicParameters();
                param.Add("Id", sneaker.Id);
                param.Add("Title", sneaker.Title);
                param.Add("Price", sneaker.Price);

                var querry = "UPDATE Sneaker SET " +
                    "Title = @Title, " +
                    "Price = @Price " +
                    "WHERE Id = @Id";

                db.Query(querry, param);
            }
        }
    }
}