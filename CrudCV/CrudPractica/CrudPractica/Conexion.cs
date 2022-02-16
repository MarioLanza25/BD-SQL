using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CrudPractica
{
    public class Conexion
    {
        public SqlConnection connect = new SqlConnection();

        public Conexion(String user, String pass)
        {
            try
            {
                connect = new SqlConnection("Server=10.9.12.138\\SQLSERVER2019;Database=CV;UID= " + user + ";PWD=" + pass);
                connect.Open();
            }
            catch(Exception)
            {

            }

        }

        public void listarProductos(DataGridView GridView1)
        {

            SqlCommand cmd = new SqlCommand();
            SqlDataReader leer;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "listarP";
            cmd.Connection = connect;


            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;

        }

        //public void editarProducto(DataGridView GridView1, int id)
        //{

        //    SqlCommand cmd = new SqlCommand();

        //    SqlParameter[] param = new SqlParameter[3];
        //    param[0] = new SqlParameter("@id", SqlDbType.Int);
        //    param[0].Value = id;

        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.CommandText = "editUsuario";
        //    cmd.Connection = connect;
        //    cmd.Parameters.AddRange(param);

        //    DataSet ds = new DataSet();
        //    SqlDataAdapter da = new SqlDataAdapter(cmd);

        //    da.Fill(ds);

        //}
    }
}
