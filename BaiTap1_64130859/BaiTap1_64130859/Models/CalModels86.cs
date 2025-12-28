using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BaiTap1_64130859.Models
{
    public class CalModelsController : Controller
    {
        // DÙNG MODELS
        public ActionResult Index3()
        {
            return View();
        }
        public class CalModels
        {
            public double a { get; set; }
            public double b { get; set; }
            public string pt { get; set; }
        }
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Index3(CalModels cal)
        {
            switch (cal.pt)
            {
                case "+": ViewBag.KQ = cal.a + cal.b; break;
                case "-": ViewBag.KQ = cal.a - cal.b; break;
                case "*": ViewBag.KQ = cal.a * cal.b; break;
                case "/":
                    if (cal.b == 0) ViewBag.KQ = "Không chia được cho 0";
                    else ViewBag.KQ = cal.a / cal.b; break;
            }

            return View();
        }

    }
}