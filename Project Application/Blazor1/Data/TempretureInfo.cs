using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Blazor1.Data
{
    public class TempretureInfo : WeatherForecast
    {
        public int Id { get; set; } = 0;

        public string Name { get; set; } = "";

        public int TotalCases { get; set; } = 0;

        public int TotalDeaths { get; set; } = 0;

        private object tsk1 = null;

        public object Gettsk()
        {
            return tsk1;
        }

        public void Settsk(object value)
        {
            tsk1 = value;
        }

        public TempretureInfo() 
        {

        }





        public string Deathpercentage => (this.TotalDeaths * 100) / this.TotalCases + "%";


        public List<TempretureInfo> GetTempretureInfos() 
        {
            var TempInfo = new List<TempretureInfo>();
           

            TempInfo = (List<TempretureInfo>)Gettsk() ;

            return TempInfo;


        }

    }
}
