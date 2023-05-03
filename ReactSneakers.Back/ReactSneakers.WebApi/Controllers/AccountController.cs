using Hangfire;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using ReactSneakers.Entities;
using ReactSneakers.Helper;
using ReactSneakers.Services.Interfaces;
using ReactSneakers.WebApi.HangFire;
using ReactSneakers.WebApi.RabbitMq;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace ReactSneakers.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAccountService _accountService;

        public AccountController(IAccountService accountService)
        {
            _accountService = accountService;
        }

        // GET api/<AccountController>/5
        [HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login(LoginModel loginModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            if (_accountService.Login(new User() { Login = loginModel.Login.ToLower(), Password = HashPassword.GetHasPassword(loginModel.Password)}))
            {
                var user = _accountService.GetUser(loginModel.Login);
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.NameIdentifier, user.Login.ToLower()),
                    new Claim(ClaimTypes.Name, user.Login.ToLower()),
                    new Claim(ClaimTypes.Role, user.Role),
                };

                ClaimsIdentity claimsIdentity = new(claims, "Token", ClaimsIdentity.DefaultNameClaimType, ClaimsIdentity.DefaultRoleClaimType);

                var now = DateTime.Now;
                var jwt = new JwtSecurityToken(
                    issuer: AuthOptions.ISSUER,
                    audience: AuthOptions.AUEDIENCE,
                    notBefore: now,
                    claims: claimsIdentity.Claims,
                    expires: now.Add(TimeSpan.FromMinutes(AuthOptions.LIFETIME)),
                    signingCredentials: new SigningCredentials(AuthOptions.GetSymmetricSecurityKey(), SecurityAlgorithms.HmacSha256)
                    );
                var encodedJwt = new JwtSecurityTokenHandler().WriteToken(jwt);

                var response = new
                {
                    access_token = encodedJwt,
                    user_name = claimsIdentity.Name,
                    user_role = user.Role,
                };

                if(user.Role == Role.Admin)
                {
                    BackgroundJob.Enqueue(() => HangFireSendEmail.SendEmailForLogin("react-sneaker@mail.ru"));
                }
                RabbitMqSendMessage.PublisherLogInAsAdmin();

                return Ok(response);
            }
            return Unauthorized();
        }
    }
}
