using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BaiTap2_64130859.Controllers
{
    public class SinhVien_64130859Controller : Controller
    {
        // GET: SinhVien_64130859
        public ActionResult Index()
        {
            return View();

        }
        public ActionResult Index1()
        {
            return View();
        }
        [HttpPost]
        //dùng form collection
        public ActionResult Register2(FormCollection field)
        {
            ViewBag.Id = field["Id"];
            ViewBag.Name = field["Name"];
            ViewBag.Marks = field["Marks"];
            return View();
        }
        // Dùng Request
        public ActionResult Index2()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register3(FormCollection field)
        {
            ViewBag.Id = Request["Id"];
            ViewBag.Name = Request["Name"];
            ViewBag.Marks = Request["Marks"];
            return View(ViewBag);
        }
        // DÙng đối số của Action
        public ActionResult Index3()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register4(String Id, string Name, double Marks)
        {
            ViewBag.Id = Id;
            ViewBag.Name = Name;
            ViewBag.Marks = Marks;
            return View(ViewBag);
        }
        // DÙng Model
        public class studentinfo
        {
            public string Id { get; set; }
            public string Name { get; set; }
            public double Marks { get; set; }
        }
    }

}