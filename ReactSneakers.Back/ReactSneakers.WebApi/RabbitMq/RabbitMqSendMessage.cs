using RabbitMQ.Client;
using System.Text;

namespace ReactSneakers.WebApi.RabbitMq
{
    public static class RabbitMqSendMessage
    {
        public static void PublisherLogInAsAdmin()
        {
            var factory = new ConnectionFactory() { HostName = "localhost" };
            using (var connection = factory.CreateConnection())
            {
                using (var chanel = connection.CreateModel())
                {
                    chanel.QueueDeclare(
                        queue: "first",
                        exclusive: false,
                        autoDelete: false,
                        arguments: null
                        );

                    var message = $"Был вход под админом. Время: {DateTime.Now}";
                    var body = Encoding.UTF8.GetBytes(message);

                    chanel.BasicPublish(
                        exchange: "",
                        routingKey: "first",
                        basicProperties: null,
                        body: body
                        );
                }
            }
        }
    }
}
