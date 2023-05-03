using System.Net;
using System.Net.Mail;

namespace ReactSneakers.WebApi.HangFire
{
    public static class HangFireSendEmail
    {
        public static void SendEmailForLogin(string email)
        {
            MailAddress from = new MailAddress("official_hirutsu@mail.ru", "React-Sneakers");
            // кому отправляем
            MailAddress to = new MailAddress(email);
            // создаем объект сообщения
            MailMessage m = new MailMessage(from, to);
            // тема письма
            m.Subject = $"Уведомление об входе в Admin";
            // текст письма
            m.Body = $"Был произведен вход в Admin. Время захода: {DateTime.Now}";
            // письмо представляет код html
            m.IsBodyHtml = true;
            // адрес smtp-сервера и порт, с которого будем отправлять письмо
            SmtpClient smtp = new SmtpClient("smtp.mail.ru", 25);
            // логин и пароль
            smtp.Credentials = new NetworkCredential("official_hirutsu@mail.ru", "");
            smtp.EnableSsl = true;
            smtp.Send(m);
        }
    }
}
