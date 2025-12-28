using System.Web;
using System.Web.Mvc;

namespace ThiGK2025_64130859
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
