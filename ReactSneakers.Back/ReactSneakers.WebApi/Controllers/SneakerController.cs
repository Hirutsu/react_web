using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ReactSneakers.Entities;
using ReactSneakers.Services.Interfaces;

namespace ReactSneakers.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SneakerController : ControllerBase
    {
        private readonly ISneakerService _sneakerService;

        public SneakerController(ISneakerService sneakerService)
        {
            _sneakerService = sneakerService;
        }

        // GET: api/<AboutController>
        [HttpGet]
        public ActionResult<IEnumerable<Sneaker>> Get()
        {
            return _sneakerService.Get();
        }

        // GET api/<AboutController>/5
        [HttpGet("{id}")]
        public ActionResult<Sneaker> Get(int id)
        {
            return _sneakerService.GetById(id);
        }

        // POST api/<AboutController>
        [HttpPost]
        [Authorize(Roles = nameof(Role.Admin))]
        public ActionResult<int> Post(Sneaker sneaker)
        {
            int id = _sneakerService.Post(sneaker);
            if (id > 0)
            {
                return Ok(id);
            }
            else
            {
                return BadRequest();
            }
        }

        // PUT api/<AboutController>/5
        [HttpPut]
        [Authorize(Roles = nameof(Role.Admin))]
        public void Put(Sneaker sneaker)
        {
            _sneakerService.Put(sneaker);
        }

        // DELETE api/<AboutController>/5
        [HttpDelete("{id}")]
        [Authorize(Roles = nameof(Role.Admin))]
        public void Delete(int id)
        {
            _sneakerService.DeleteById(id);
        }
    }
}
