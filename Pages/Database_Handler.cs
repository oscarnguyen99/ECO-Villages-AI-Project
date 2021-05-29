using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using static Microsoft.JSInterop.IJSRuntime;
using Microsoft.JSInterop;
using System.Threading;

namespace Blazor1.Pages
{
    public class Database_Handler:IJSRuntime
    {
        public static string ConnectionDB = "Data Source=JUAN-PC\\SQLEXPRESS01;Initial Catalog=EcoDorp;Integrated Security=True";
        public static SqlConnection Con = new SqlConnection();

        public Database_Handler()
        {
        }

        public static void OpenConn() 
        {
            Con = new SqlConnection(ConnectionDB);

            try
            {
                Con.Open();
                Con.Close();
            }
            catch (Exception)
            {
                async Task ErrorMessage_DB_Connection() 
                {
                    Database_Handler handler = new Database_Handler();
                    await handler.InvokeVoidAsync(identifier: "ErrorMessageDB_Connection");
                }


            }

        }

        ValueTask<TValue> IJSRuntime.InvokeAsync<TValue>(string identifier, object[] args)
        {
            throw new NotImplementedException();
        }

        ValueTask<TValue> IJSRuntime.InvokeAsync<TValue>(string identifier, CancellationToken cancellationToken, object[] args)
        {
            throw new NotImplementedException();
        }
    }
}
