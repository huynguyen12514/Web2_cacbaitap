using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLBanSach_64139020.Models;

namespace QLBanSach_64139020.Controllers
{
    public class Giohang_64139020Controller : Controller
    {
        private QLBANSACH_64139020Entities db = new QLBANSACH_64139020Entities();
        private const string GioHangSessionKey = "Giohang";

        public List<Giohang_64139020> Laygiohang()
        {
            List<Giohang_64139020> lstGiohang = Session[GioHangSessionKey] as List<Giohang_64139020>;
            if (lstGiohang == null)
            {
                lstGiohang = new List<Giohang_64139020>();
                Session[GioHangSessionKey] = lstGiohang;
            }
            return lstGiohang;
        }

        
        private int TongSoLuong_64139020()
        {
            List<Giohang_64139020> lstGiohang = Session[GioHangSessionKey] as List<Giohang_64139020>;
            return lstGiohang?.Sum(n => n.iSoluong) ?? 0;
        }

        private double TongTien_64139020()
        {
            List<Giohang_64139020> lstGiohang = Session[GioHangSessionKey] as List<Giohang_64139020>;
            return lstGiohang?.Sum(n => n.dThanhtien) ?? 0;
        }

        public ActionResult GioHang_64139020()
        {
            List<Giohang_64139020> lstGiohang = Laygiohang();

            // Giỏ hàng trống
            if (lstGiohang.Count == 0)
            {
                ViewBag.ThongBao = "Giỏ hàng của bạn hiện đang trống.";
            }

            ViewBag.Tongsoluong = TongSoLuong_64139020();
            ViewBag.Tongtien = TongTien_64139020();
            return View(lstGiohang);
        }
        public ActionResult ThemGiohang_64139020(int iMasach, string strURL, int soluong = 1)
        {
            List<Giohang_64139020> lstGiohang = Laygiohang();
            Giohang_64139020 sp = lstGiohang.FirstOrDefault(n => n.iMasach == iMasach);
            if (sp == null)
            {
                SACH sach = db.SACHes.SingleOrDefault(n => n.Masach == iMasach);
                if (sach == null) return HttpNotFound();

                sp = new Giohang_64139020(iMasach, sach.Tensach, sach.Anhbia, double.Parse(sach.Giaban.ToString()));
                sp.iSoluong = soluong;
                lstGiohang.Add(sp);
            }
            else
            {
                sp.iSoluong += soluong;
            }

            ViewBag.strURL = strURL;
            return View(); // Trả về view ThemGiohang_64139020.cshtml
        }


        public ActionResult XoaGiohang_64139020(int iMaSP)
        {
            List<Giohang_64139020> lstGiohang = Laygiohang();
            Giohang_64139020 sanpham = lstGiohang.SingleOrDefault(n => n.iMasach == iMaSP);
            if (sanpham != null)
            {
                lstGiohang.RemoveAll(n => n.iMasach == iMaSP);
            }

            if (lstGiohang.Count == 0)
            {
                return RedirectToAction("Index_64139020", "BookStore_64139020");
            }

            return RedirectToAction("GioHang_64139020");
        }
        public ActionResult CapnhatGiohang(int iMaSP, FormCollection f)
        {
            //Lay gio hang tu Session
            List<Giohang_64139020> lstGiohang = Laygiohang();
            //Kiem tra sach da co trong Session["Gohang"]
            Giohang_64139020 sanpham = lstGiohang.SingleOrDefault(n => n.iMasach == iMaSP);
            //Neu ton tai thi cho sua Soluong
            if (sanpham != null)
            {
                sanpham.iSoluong = int.Parse(f["txtSoluong"].ToString());
            }
            return RedirectToAction("Giohang_64139020");
        }
        public ActionResult XoaTatcaGiohang_64139020()
        {
            List<Giohang_64139020> lstGiohang = Laygiohang();
            lstGiohang.Clear();
            Session["SL"] = null;
            return RedirectToAction("Index_64139020", "BookStore_64139020");
        }

        [HttpGet]
        public ActionResult DatHang_64139020()
        {
            if (Session["Taikhoan"] == null || string.IsNullOrEmpty(Session["Taikhoan"].ToString()))
            {
                return RedirectToAction("Dangnhap_64139020", "Nguoidung_64139020");
            }

            if (Session[GioHangSessionKey] == null)
            {
                return RedirectToAction("Index_64139020", "BookStore_64139020");
            }

            List<Giohang_64139020> lstGiohang = Laygiohang();
            ViewBag.Tongsoluong = TongSoLuong_64139020();
            ViewBag.Tongtien = TongTien_64139020();
            return View(lstGiohang);
        }

        [HttpPost]
        public ActionResult DatHang_64139020(FormCollection collection)
        {
            DONDATHANG ddh = new DONDATHANG();
            KHACHHANG kh = (KHACHHANG)Session["Taikhoan"];
            List<Giohang_64139020> gh = Laygiohang();

            ddh.MaKH = kh.MaKH;
            ddh.Ngaydat = DateTime.Now;
            ddh.Ngaygiao = DateTime.Now.AddDays(7); // Ngày giao = ngày hiện tại + 7
            ddh.Tinhtranggiaohang = false;
            ddh.Dathanhtoan = false;

            db.DONDATHANGs.Add(ddh);
            db.SaveChanges();

            foreach (var item in gh)
            {
                CHITIETDONTHANG ctdh = new CHITIETDONTHANG
                {
                    MaDonHang = ddh.MaDonHang,
                    Masach = item.iMasach,
                    Soluong = item.iSoluong,
                    Dongia = (decimal)item.dDonggia
                };
                db.CHITIETDONTHANGs.Add(ctdh);
            }

            db.SaveChanges();
            Session[GioHangSessionKey] = null;
            return RedirectToAction("Xacnhandonhang_64139020");
        }


        public ActionResult Xacnhandonhang_64139020()
        {
            List<Giohang_64139020> lstGiohang = Laygiohang();
            lstGiohang.Clear();
            return View();
        }
    }
}
