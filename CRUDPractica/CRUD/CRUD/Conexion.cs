using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace CRUD
{
    public class Conexion
    {
        public SqlConnection connect = new SqlConnection();
        private SqlCommand cmd = new SqlCommand();
        private SqlDataReader leerFilas;

        public Conexion()
        {

        }

        public Conexion(String user, String pass)
        {
            try
            {
                connect = new SqlConnection("Server=DESKTOP-VB4UJK1; Database=CV;UID=" + user + ";PWD=" + pass);
                connect.Open();
            }
            catch(Exception)
            {

            }
        }

        public DataTable listarProveedor()
        {
            connect.Open();
            DataTable tabla = new DataTable();
            cmd.Connection = connect;
            cmd.CommandText = "listarProveedor";
            cmd.CommandType = CommandType.StoredProcedure;
            leerFilas = cmd.ExecuteReader();
            tabla.Load(leerFilas);
            leerFilas.Close();
            connect.Close();
            return tabla;
        }

        public void listarProductos(DataGridView gridView)
        {
            cmd.CommandText = "listarP";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connect;

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);

            gridView.DataSource = dt;
        }

        public void insertarProducto(String nombre, float precio, int exist, String descri)
        {

            //Console.WriteLine(contra);

            try
            {
                SqlCommand cmd = new SqlCommand();

                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@NProd", SqlDbType.VarChar);
                param[0].Value = nombre;
                param[1] = new SqlParameter("@precio", SqlDbType.VarChar);
                param[1].Value = precio;
                param[2] = new SqlParameter("@exist", SqlDbType.VarChar);
                param[2].Value = exist;
                param[3] = new SqlParameter("@DescProd", SqlDbType.VarChar);
                param[3].Value = descri;

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "NProduct";
                cmd.Connection = connect;
                cmd.Parameters.AddRange(param);

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);
            }
            catch (Exception)
            {

                MessageBox.Show("Error en la insercion");
                return;
            }


        }
    }
}
