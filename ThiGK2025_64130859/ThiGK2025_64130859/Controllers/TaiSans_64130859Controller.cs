using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ThiGK2025_64130859.Models;
namespace ThiGK2025_64130859.Controllers
{
    public class TaiSans_64130859Controller : Controller
    {
        // GET: TaiSans_64130859
        private ThiGK2025_64130859Entities db = new ThiGK2025_64130859Entities();

        public ActionResult GioiThieu_64130859()
        {
            return View();

        }
        public ActionResult Index()
        {
            var taiSans = db.TaiSans.Include(s => s.LoaiTaiSan);
            return View(taiSans.ToList());
        }
        // GET: TaiSans_64130859/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }


        public ActionResult TimKiem()
        {
            var TaiSans = db.TaiSans.Include(n => n.LoaiTaiSan);
            return View(TaiSans.ToList());
        }
        [HttpPost]
        public ActionResult TimKiem(string TenTS)
        {

            //var SinhViens = db.SinhViens.SqlQuery("exec NhanVien_DS '"+maSV+"' ");
            //var SinhViens = db.SinhViens.SqlQuery("SELECT * FROM NhanVien WHERE MaSV='" + maSV + "'");
            //var SinhViens = db.SinhViens.Where(abc => abc.maSV == maSV);
            var TaiSans = db.TaiSans.Where(abc => abc.TenTS == TenTS);
            return View(TaiSans.ToList());
        }
        // GET: TaiSans_64130859/Create
        public ActionResult Create()
        {
            ViewBag.MaLTS = new SelectList(db.LoaiTaiSans, "MaLTS", "TenLTS");
            return View();
        }

        // POST: SinhVien0720_64130859/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaTS,TenTS,DVT,XuatXu,DonGia,AnhMH,MaLTS,GhiChu")] TaiSan taiSan)
        {
            var imgTS = Request.Files["Avatar"];


            //Lấy thông tin từ input type=file có tên Avatar
            string postedFileName = System.IO.Path.GetFileName(imgTS.FileName);
            //Lưu hình đại diện về Server
            var path = Server.MapPath("/Images/" + postedFileName);
            imgTS.SaveAs(path);



            if (ModelState.IsValid)
            {
                taiSan.AnhMH = imgTS.FileName;
                db.TaiSans.Add(taiSan);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaLop = new SelectList(db.LoaiTaiSans, "MaLTS", "TenLTS", taiSan.MaLTS);
            return View(taiSan);

        }
        // POST: SinhVien0720_64130859/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]


        // GET: TaiSans_64130859/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: TaiSans_64130859/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: TaiSans_64130859/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TaiSan taiSan = db.TaiSans.Find(id);
            if (taiSan == null)
            {
                return HttpNotFound();
            }
            return View(taiSan);
        }
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            TaiSan taiSan = db.TaiSans.Find(id);
            db.TaiSans.Remove(taiSan);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);

        }
    }
}
