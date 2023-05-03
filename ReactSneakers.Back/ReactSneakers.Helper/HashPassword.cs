using System.Security.Cryptography;
using System.Text;

namespace ReactSneakers.Helper
{
    public static class HashPassword
    {
        public static string GetHasPassword(string password)
        {
            using(var sha256 = SHA256.Create())
            {
                var hasBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                var hash = BitConverter.ToString(hasBytes).Replace("-","").ToLower();

                return hash;
            }
        }

        public static string GetRandomPassword()
        {
            int[] arr = new int[16]; // сделаем длину пароля в 16 символов
            Random rnd = new Random();
            string Password = "";

            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = rnd.Next(33, 125);
                Password += (char)arr[i];
            }
            return Password;
        }
    }
}
