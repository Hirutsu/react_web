using Hangfire;
using Hangfire.PostgreSql;
using Hangfire.SqlServer;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using ReactSneakers.Helper;
using ReactSneakers.Repositories;
using ReactSneakers.Repositories.Interfaces;
using ReactSneakers.Services;
using ReactSneakers.Services.Interfaces;
using WebOnkoDis.Helper;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new OpenApiInfo { Title = "Demo API", Version = "v1" });
    option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    option.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            new string[]{}
        }
    });
});

builder.Services.AddCors();

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidIssuer = AuthOptions.ISSUER,
        ValidateAudience = true,
        ValidAudience = AuthOptions.AUEDIENCE,
        ValidateLifetime = true,
        IssuerSigningKey = AuthOptions.GetSymmetricSecurityKey(),
        ValidateIssuerSigningKey = true,
    };
});


var NpgsqlConnectionString = builder.Configuration.GetConnectionString("NpgsqlConnectionString");
builder.Services.AddSingleton(new DbOptions() { ConnectionString = NpgsqlConnectionString });

builder.Services.AddTransient<ISneakerService, SneakerService>();
builder.Services.AddTransient<ISneakerRepository, SneakerRepository>();

var t = builder.Services.AddTransient<IAccountService, AccountService>();
builder.Services.AddTransient<IAccountRepository, AccountRepository>();

/*builder.Services.AddSingleton<TelegramBot>();

ServiceProvider serviceProvider = t.BuildServiceProvider();

TelegramBot tg = new TelegramBot(serviceProvider.GetService<IAccountService>());*/

/*builder.Services.AddHangfire(config =>
    config.UsePostgreSqlStorage(NpgsqlConnectionString));

builder.Services.AddHangfireServer();*/

var app = builder.Build();

app.UseCors(cors => cors.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin());

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
/*
app.UseHangfireDashboard("/hangfire");*/

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
