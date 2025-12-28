using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.IO;
using PagedList;
using System.Web.UI.WebControls;

using QLBanSach_64139020.Models;

namespace QLBanSach_64139020.Controllers
{
    public class Admin_64139020Controller : Controller
    {
        private QLBANSACH_64139020Entities db = new QLBANSACH_64139020Entities();

        // GET: Admin_64139020
        public ActionResult Index_64139020()
        {
            return View(db.Admins.ToList());
        }
        public ActionResult Sach_64139020(int? page)
        {
            if (Session["Taikhoanadmin"] == null)
            {
                return RedirectToAction("Login_64139020", "Admin_64139020");
            }
            int pageNumber = (page ?? 1);
            int pageSize = 12;
            //return View(db.SACHes.ToList());
            return View(db.SACHes.ToList().OrderBy(n => n.Masach).ToPagedList(pageNumber, pageSize));
        }
        //Get: Admin/Login
        [HttpGet]
        public ActionResult Login_64139020()
        {
            return View();
        }

        // POST: Admin/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login_64139020(FormCollection collection)
        {
            var tendn = collection["username"];
            var matkhau = collection["password"];
            if (String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Phải nhập tên đăng nhập!";
            }
            else if (String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phải nhập mật khẩu!";
            }
            else
            {
                //Gan gia tri cho doi tuong duoc tao moi
                Admin ad = db.Admins.SingleOrDefault(n => n.UserAdmin == tendn && n.PassAdmin == matkhau);
                if (ad != null)
                {
                    Session["Ten"] = ad.Hoten;
                    Session["Taikhoanadmin"] = ad;
                    return RedirectToAction("Index_64139020", "Admin_64139020");
                }
                else
                    ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng!";
            }
            return View();
        }
        // GET: Admin/ThemmoiSach
        public ActionResult ThemmoiSach_64139020()
        {
            if (Session["Taikhoanadmin"] == null)
            {
                return RedirectToAction("Login_64139020", "Admin_64139020"); // Cần đúng tên action Login nếu bạn dùng tên đó
            }

            ViewBag.MaLoai = new SelectList(db.LOAISACHes.OrderBy(n => n.TenLoai), "MaLoai", "TenLoai");
            ViewBag.MaNXB = new SelectList(db.NHAXUATBANs.OrderBy(n => n.TenNXB), "MaNXB", "TenNXB");

            return View();
        }

        // POST: Admin/ThemmoiSach_64139020
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ThemmoiSach_64139020(SACH sach, HttpPostedFileBase AnhUpload)
        {
            if (Session["Taikhoanadmin"] == null)
            {
                return RedirectToAction("Login_64139020", "Admin_64139020");
            }

            ViewBag.MaLoai = new SelectList(db.LOAISACHes.OrderBy(n => n.TenLoai), "MaLoai", "TenLoai", sach.MaLoai);
            ViewBag.MaNXB = new SelectList(db.NHAXUATBANs.OrderBy(n => n.TenNXB), "MaNXB", "TenNXB", sach.MaNXB);

            if (AnhUpload == null || AnhUpload.ContentLength == 0)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa!";
                return View(sach);
            }

            if (ModelState.IsValid)
            {
                // Lấy tên file ảnh gốc
                string fileName = Path.GetFileName(AnhUpload.FileName);

                // Đường dẫn lưu ảnh trên server
                string path = Path.Combine(Server.MapPath("~/images/anhsp/"), fileName);

                // Nếu ảnh đã tồn tại thì đổi tên bằng GUID để tránh trùng lặp
                if (System.IO.File.Exists(path))
                {
                    string fileExt = Path.GetExtension(fileName);
                    string fileBase = Path.GetFileNameWithoutExtension(fileName);
                    fileName = $"{fileBase}_{Guid.NewGuid().ToString().Substring(0, 8)}{fileExt}";
                    path = Path.Combine(Server.MapPath("~/images/anhsp/"), fileName);
                }

                // Lưu ảnh lên server
                AnhUpload.SaveAs(path);

                // Gán tên file ảnh cho thuộc tính của sách
                sach.Anhbia = fileName;

                db.SACHes.Add(sach);
                db.SaveChanges();

                return RedirectToAction("Sach_64139020", "Admin_64139020");
            }

            // Nếu model không hợp lệ trả lại view để sửa
            return View(sach);
        }

        [HttpGet]
        public ActionResult ThemmoiLoai_64139020()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ThemmoiLoai_64139020(LOAISACH loai)
        {
            if (ModelState.IsValid)
            {
                db.LOAISACHes.Add(loai);
                db.SaveChanges();
                return RedirectToAction("Loaisach_64139020");
            }
            return View(loai);
        }

        [HttpGet]
        public ActionResult ThemmoiNXB_64139020()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ThemmoiNXB_64139020(NHAXUATBAN nxb)
        {
            if (ModelState.IsValid)
            {
                db.NHAXUATBANs.Add(nxb);
                db.SaveChanges();
                return RedirectToAction("NXB_64139020");
            }
            return View(nxb);
        }
        // GET: Admin/Chitietsach/5
        public ActionResult Chitietsach_64139020(int id)
        {
            var sach = db.SACHes.Include("LOAISACH").Include("NHAXUATBAN").SingleOrDefault(s => s.Masach == id);
            if (sach == null) return HttpNotFound();

            return View(sach);
        }

        // GET: Admin/Suasach/5
        [HttpGet]
        public ActionResult Suasach_64139020(int id)
        {
            var sach = db.SACHes.SingleOrDefault(s => s.Masach == id);
            if (sach == null) return HttpNotFound();

            ViewBag.MaLoai = new SelectList(db.LOAISACHes.OrderBy(n => n.TenLoai), "MaLoai", "TenLoai", sach.MaLoai);
            ViewBag.MaNXB = new SelectList(db.NHAXUATBANs.OrderBy(n => n.TenNXB), "MaNXB", "TenNXB", sach.MaNXB);

            return View(sach);
        }

        // POST: Admin/Suasach
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Suasach_64139020(SACH sach, HttpPostedFileBase fileupload)
        {
            ViewBag.MaLoai = new SelectList(db.LOAISACHes.OrderBy(n => n.TenLoai), "MaLoai", "TenLoai", sach.MaLoai);
            ViewBag.MaNXB = new SelectList(db.NHAXUATBANs.OrderBy(n => n.TenNXB), "MaNXB", "TenNXB", sach.MaNXB);

            if (ModelState.IsValid)
            {
                try
                {
                    var sachInDb = db.SACHes.SingleOrDefault(s => s.Masach == sach.Masach);
                    if (sachInDb == null) return HttpNotFound();

                    // Update fields
                    sachInDb.Tensach = sach.Tensach;
                    sachInDb.Giaban = sach.Giaban;
                    sachInDb.Mota = sach.Mota;
                    sachInDb.Ngaycapnhat = DateTime.Now;
                    sachInDb.Soluongton = sach.Soluongton;
                    sachInDb.MaLoai = sach.MaLoai;
                    sachInDb.MaNXB = sach.MaNXB;

                    if (fileupload != null && fileupload.ContentLength > 0)
                    {
                        var fileName = Guid.NewGuid().ToString() + Path.GetExtension(fileupload.FileName);
                        var path = Path.Combine(Server.MapPath("~/images/anhsp/"), fileName);

                        if (!Directory.Exists(Server.MapPath("~/images/anhsp/")))
                        {
                            Directory.CreateDirectory(Server.MapPath("~/images/anhsp/"));
                        }

                        fileupload.SaveAs(path);
                        sachInDb.Anhbia = fileName;
                    }

                    db.SaveChanges();
                    return RedirectToAction("Sach_64139020");
                }
                catch (Exception ex)
                {
                    ViewBag.Thongbao = "Lỗi khi sửa sách: " + ex.Message;
                }
            }

            return View(sach);
        }
        // GET: Admin_64139020/XoaSach_64139020/5
        public ActionResult XoaSach_64139020(int id)
        {
            SACH sach = db.SACHes.SingleOrDefault(n => n.Masach == id);
            if (sach == null)
            {
                return HttpNotFound();
            }

            return View(sach);         }

        // POST: Admin_64139020/XoaSach_64139020/5
        [HttpPost, ActionName("XoaSach_64139020")]
        [ValidateAntiForgeryToken]
        public ActionResult XacNhanXoa(int id)
        {
            SACH sach = db.SACHes.SingleOrDefault(n => n.Masach == id);

            if (sach == null)
            {
                return HttpNotFound();
            }

            // Xóa các bản ghi liên quan trong VIETSACH trước
            var vietSaches = db.VIETSACHes.Where(v => v.Masach == id).ToList();
            foreach (var vietSach in vietSaches)
            {
                db.VIETSACHes.Remove(vietSach);
            }

            // Xóa bản ghi SACH
            db.SACHes.Remove(sach);

            db.SaveChanges();

            return RedirectToAction("Sach_64139020");
        }

        // --- Sửa Loại sách ---

        [HttpGet]
        public ActionResult SuaLoai_64139020(int id)
        {
            var loai = db.LOAISACHes.Find(id);
            if (loai == null)
            {
                return HttpNotFound("Loại sách này đã bị xóa hoặc không tồn tại.");
            }
            return View(loai); // Trả về View với model để người dùng sửa
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SuaLoai_64139020(LOAISACH loai)
        {
            if (ModelState.IsValid)
            {
                // Lấy entity gốc từ DB
                var loaiInDb = db.LOAISACHes.Find(loai.MaLoai);
                if (loaiInDb == null)
                {
                    return HttpNotFound("Loại sách không tồn tại hoặc đã bị xóa.");
                }

                // Cập nhật các trường cần sửa
                loaiInDb.TenLoai = loai.TenLoai;

                // Lưu thay đổi
                db.SaveChanges();

                return RedirectToAction("Loaisach_64139020");
            }
            return View(loai);
        }

        // --- Xóa Loại sách ---
        [HttpGet]
        public ActionResult XoaLoai_64139020(int id)
        {
            var loai = db.LOAISACHes.Find(id);
            if (loai == null)
                return HttpNotFound("Loại sách không tồn tại hoặc đã bị xóa.");
            return View(loai);
        }

        [HttpPost, ActionName("XoaLoai_64139020")]
        [ValidateAntiForgeryToken]
        public ActionResult XoaLoai_Confirm(int id)
        {
            var loai = db.LOAISACHes.Find(id);
            if (loai == null)
                return HttpNotFound("Loại sách không tồn tại hoặc đã bị xóa.");

            db.LOAISACHes.Remove(loai);
            db.SaveChanges();
            return RedirectToAction("Loaisach_64139020");
        }


        // --- Sửa Nhà xuất bản ---
        [HttpGet]
        public ActionResult SuaNXB_64139020(int id)
        {
            var nxb = db.NHAXUATBANs.Find(id);
            if (nxb == null) return HttpNotFound();
            return View(nxb);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SuaNXB_64139020(NHAXUATBAN nxb)
        {
            if (ModelState.IsValid)
            {
                var nxbInDb = db.NHAXUATBANs.Find(nxb.MaNXB);
                if (nxbInDb == null)
                {
                    return HttpNotFound();
                }

                // Cập nhật các trường cần thiết
                nxbInDb.TenNXB = nxb.TenNXB;
                nxbInDb.Diachi = nxb.Diachi;
                nxbInDb.DienThoai = nxb.DienThoai;

                db.SaveChanges();
                return RedirectToAction("NXB_64139020");
            }
            return View(nxb);
        }

        // --- Xóa Nhà xuất bản ---
        [HttpGet]
        public ActionResult XoaNXB_64139020(int id)
        {
            var nxb = db.NHAXUATBANs.Find(id);
            if (nxb == null) return HttpNotFound();
            return View(nxb);
        }

        [HttpPost, ActionName("XoaNXB_64139020")]
        [ValidateAntiForgeryToken]
        public ActionResult XoaNXB_Confirm(int id)
        {
            var nxb = db.NHAXUATBANs.Find(id);
            if (nxb == null) return HttpNotFound();
            db.NHAXUATBANs.Remove(nxb);
            db.SaveChanges();
            return RedirectToAction("NXB_64139020");
        }



        public ActionResult DonHang_64139020(int? page)
        {
            if (Session["Taikhoanadmin"] == null)
            {
                return RedirectToAction("Login_64139020", "Admin_64139020");
            }
            int pageNumber = (page ?? 1);
            int pageSize = 10;
            return View(db.DONDATHANGs.ToList().OrderBy(n => n.MaDonHang).ToPagedList(pageNumber, pageSize));
        }
        //Đơn hàng
        public ActionResult Chitietdonhang_64139020(int id)
        {
            //Lay doi tuong sach theo ma
            CHITIETDONTHANG dh = (CHITIETDONTHANG)db.CHITIETDONTHANGs.ToList().OrderBy(n => n.MaDonHang == id);
            ViewBag.MaDonHang = dh.MaDonHang;
            if (dh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(dh);
        }
        //Người dùng
        public ActionResult Chitietnguoidung_64139020(int id)
        {
            //Lay doi tuong nguoi dung theo ma
            KHACHHANG nguoidung = db.KHACHHANGs.SingleOrDefault(n => n.MaKH == id);
            ViewBag.MaKH = nguoidung.MaKH;
            if (nguoidung == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(nguoidung);
        }

        //Phân loại sách
        public ActionResult LoaiSach_64139020(int? page)
        {
            if (Session["Taikhoanadmin"] == null)
            {
                return RedirectToAction("Login_64139020", "Admin_64139020");
            }
            int pageNumber = (page ?? 1);
            int pageSize = 5;
            //return View(db.SACHes.ToList());
            return View(db.LOAISACHes.ToList().OrderBy(n => n.MaLoai).ToPagedList(pageNumber, pageSize));
        }
        //Phân loại sách
        public ActionResult NXB_64139020(int? page)
        {
            if (Session["Taikhoanadmin"] == null)
            {
                return RedirectToAction("Login_64139020", "Admin_64139020");
            }
            int pageNumber = (page ?? 1);
            int pageSize = 5;
            //return View(db.SACHes.ToList());
            return View(db.NHAXUATBANs.ToList().OrderBy(n => n.MaNXB).ToPagedList(pageNumber, pageSize));
        }
    }
}
