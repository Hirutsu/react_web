using ReactSneakers.Entities;
using ReactSneakers.Helper;
using ReactSneakers.Services.Interfaces;
using Telegram.Bot;
using Telegram.Bot.Polling;
using Telegram.Bot.Types;

public class TelegramBot
{
    private readonly ITelegramBotClient bot = new TelegramBotClient("6162207614:AAH-wx8jM8oRc-oQnVih1z_RorRrTuL0iJM");
    private readonly IAccountService _accountService;

    public TelegramBot(IAccountService accountService)
    {
        _accountService = accountService;

        var cts = new CancellationTokenSource();
        var cancellationToken = cts.Token;
        var receiverOptions = new ReceiverOptions
        {
            AllowedUpdates = { }, // receive all update types
        };
        bot.StartReceiving(
            HandleUpdateAsync,
            HandleErrorAsync,
            receiverOptions,
            cancellationToken
        );
    }

    public async Task HandleUpdateAsync(ITelegramBotClient botClient, Update update, CancellationToken cancellationToken)
    {
        // Некоторые действия
        if (update.Type == Telegram.Bot.Types.Enums.UpdateType.Message)
        {
            var message = update.Message;
            if (message.Text.ToLower() == "/start")
            {
                await botClient.SendTextMessageAsync(message.Chat, "Добро пожаловать на борт, добрый путник!");
                return;
            }
            if(message.Text.ToLower() == "/getpassword")
            {
                var rndPas = HashPassword.GetRandomPassword();

                _accountService.UpdateAdmin(
                    new ReactSneakers.Entities.User() 
                    { 
                        Id = 1, 
                        Login = "admin", 
                        Password = HashPassword.GetHasPassword(rndPas),
                    }
                );
                await botClient.SendTextMessageAsync(message.Chat, $"Новый пароль для входа в админку: {rndPas}");
                return;
            }
            await botClient.SendTextMessageAsync(message.Chat, "Привет-привет!! Пишу команду");
        }
    }

    public async Task HandleErrorAsync(ITelegramBotClient botClient, Exception exception, CancellationToken cancellationToken)
    {
        // Некоторые действия
        Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(exception));
    }

}