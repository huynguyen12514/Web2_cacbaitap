using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QLBanSach_64139020.Models
{
    public class Giohang_64139020
    {
        [Key] // Đánh dấu thuộc tính này là khóa chính
        public int Id { get; set; } // Khóa chính cho entity giỏ hàng
        public int iMasach { get; set; }
        public string sTensach { get; set; }
        public string sAnhbia { get; set; }
        public double dDonggia { get; set; }
        public int iSoluong { get; set; }

        public double dThanhtien
        {
            get { return iSoluong * dDonggia; }
        }
        public Giohang_64139020() { }
        public Giohang_64139020(int masach, string tensach, string anhbia, double donggia)
        {
            iMasach = masach;
            sTensach = tensach;
            sAnhbia = anhbia;
            dDonggia = donggia;
            iSoluong = 1;
        }


    }

}
