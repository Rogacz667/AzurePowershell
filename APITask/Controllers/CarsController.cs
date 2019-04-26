using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

namespace APITask.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CarsController : ControllerBase
    {
        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] {
                "Honda",
                "KIA",
                "Tesla",
                "Ford",
                "Mercedes-Benz"
            };
        }
    }
}
