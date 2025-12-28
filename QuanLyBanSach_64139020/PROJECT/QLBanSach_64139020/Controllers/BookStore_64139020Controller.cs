using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PagedList;
using PagedList.Mvc;
using System.Web.UI;
using QLBanSach_64139020.Models;
using System.Configuration;
using System.Data.SqlClient;

namespace QLBanSach_64139020.Controllers
{
    public class BookStore_64139020Controller : Controller
    {
        private QLBANSACH_64139020Entities db = new QLBANSACH_64139020Entities();

        private List<SACH> Laysachmoi(int count)
        {
            // Sắp xếp giảm dần theo Ngaycapnhat, lấy count dòng đầu tiên
            return db.SACHes.OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
        }

        // GET: BookStore_64139020
        public ActionResult Index_64139020()
        {
            // Lấy 16 sách mới nhất, không phân trang
            var sachmoi = Laysachmoi(10);
            return View(sachmoi); // Trả về List<SACH> luôn
        }

        public ActionResult Loaisach_64139020()
        {
            var loai = from cd in db.LOAISACHes select cd;
            return PartialView(loai);
        }
        //Them nha xuat ban voi tung muc nav
        public ActionResult Nhaxuatban_64139020()
        {
            var nhaxuatban = from nxb in db.NHAXUATBANs select nxb;
            return PartialView(nhaxuatban);
        }
        public ActionResult Tacgia_64139020()
        {
            var tacgia = from tg in db.TACGIAs select tg;
            return PartialView(tacgia);
        }
        //Chia san pham theo chu de
       public ActionResult SachTheoLoai_64139020(int id, int? page)
       {
            int pageSize = 8;
            int pageNum = (page ?? 1);

            var sach = from s in db.SACHes
                       where s.MaLoai == id
                       orderby s.Masach
                       select s;

            return View(sach.ToPagedList(pageNum, pageSize));
        }

        //Chia san pham theo Nha Xuat Ban
        public ActionResult SachTheoNXB_64139020(int id, int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);

            // Đảm bảo sắp xếp kết quả trước khi phân trang
            var sach = db.SACHes
                         .Where(s => s.MaNXB == id)
                         .OrderBy(s => s.Masach) // Sắp xếp theo Masach
                         .AsQueryable(); // Giữ lại kiểu IQueryable

            return View(sach.ToPagedList(pageNum, pageSize));
        }


        public ActionResult SachTheoTacGia_64139020(int id, int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);

            // Lấy danh sách sách theo tác giả id qua bảng VIETSACH
            var sachTheoTG = db.VIETSACHes
                .Where(vs => vs.MaTG == id)
                .Select(vs => vs.SACH)
                .OrderBy(s => s.Masach) // Sắp xếp theo Masach
                .AsQueryable(); // Giữ lại kiểu IQueryable

            return View(sachTheoTG.ToPagedList(pageNum, pageSize));
        }


        //Lay thong tin chi tiet sach
        public ActionResult Xemsach_64139020(int id)
        {
            var sach = db.SACHes
       .Include(s => s.VIETSACHes.Select(v => v.TACGIA))  // load luôn tác giả qua VIETSACH
       .FirstOrDefault(s => s.Masach == id);

            if (sach == null)
            {
                return HttpNotFound();
            }

            return View(sach);
        }
        [HttpGet]
        public ActionResult ThongTinTaiKhoan_64139020()
        {
            if (Session["Taikhoan"] == null)
            {
                return RedirectToAction("Dangnhap_64139020", "Nguoidung_64139020");
            }

            var khachhang = (KHACHHANG)Session["Taikhoan"];
            return View(khachhang);
        }
        public ActionResult Thoat_64139020()
        {
            Session["Taikhoan"] = null;
            return View();
        }
        [HttpGet]
        public ActionResult TimKiemSach_64139020(string keyword = "")
        {
            ViewBag.Keyword = keyword;

            // Truyền chuỗi rỗng "" thay vì DBNull
            var param = new SqlParameter("@Keyword", keyword ?? "");

            var result = db.Database.SqlQuery<SACH>(
                "EXEC Sach_TimKiem @Keyword",
                param
            ).ToList();

            if (result.Count == 0)
                ViewBag.TB = "Không có sách phù hợp.";

            return View(result);
        }
    }
}

       
