using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IronPython;
using System.Diagnostics;
using IronPython.Hosting;

using System.IO;
using System.Text;

namespace Blazor1.Data
{
    public class PyScript
    {

        public PyScript() 
        {

        }


        public void Start() 
        {
            var psi = new ProcessStartInfo();

            var engine = Python.CreateEngine();
            var script = @"C:\\Users\\user-pc\\source\\repos\\Blazor1\\Blazor1\\Shared\\simple_plot.py";
            var source = engine.CreateScriptSourceFromFile(script);

            var argv = new List<string>();
            argv.Add("");

            engine.GetSysModule().SetVariable("argv", argv);

            var eIO = engine.Runtime.IO;

            var errors = new MemoryStream();
            eIO.SetErrorOutput(errors, Encoding.Default);


            var Results = new MemoryStream();
            eIO.SetOutput(Results, Encoding.Default);

            var scope = engine.CreateScope();
            source.Execute(scope);

            
            

            string str(byte[] x) => Encoding.Default.GetString(x);
            Console.WriteLine("Errors");
            Console.WriteLine(str(errors.ToArray()));
            Console.WriteLine(  );
            Console.WriteLine("Results");
            Console.WriteLine(str(Results.ToArray()));

            // psi.FileName = @"C:\\Users\\user-pc\\source\\repos\\Blazor1\\Blazor1\\Shared\\python.exe";




            //psi.Arguments=$"\"{script}\"";

            //psi.UseShellExecute = false;
            //psi.CreateNoWindow = true;
            //psi.RedirectStandardOutput = true;
            //psi.RedirectStandardError = true;




            //using (var process = Process.Start(psi)) 
            //{
            //    errors = process.StandardError.ReadToEnd();
            //    Results = process.StandardOutput.ReadToEnd();
            //}



        }




    }
}
