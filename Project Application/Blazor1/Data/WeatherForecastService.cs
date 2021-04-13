using System;
using System.Linq;
using System.Threading.Tasks;

namespace Blazor1.Data
{
    public class WeatherForecastService : TempretureInfo
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };


        

        public Task<WeatherForecast[]> GetForecastAsync(DateTime startDate)
        {
            var rng = new Random();

            var tsk = Task.FromResult(Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = startDate.AddDays(index),
                TemperatureC = rng.Next(-20, 55),
                Summary = Summaries[rng.Next(Summaries.Length)]
            }).ToArray());

            TempretureInfo temp = new TempretureInfo();
            temp.Settsk(tsk);
            return tsk;
        }
    }
}
