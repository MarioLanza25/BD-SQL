using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CRUD
{
    public partial class FrmNuevoProd : Form
    {

        private Conexion con;
        public FrmNuevoProd()
        {
            InitializeComponent();
        }

        public FrmNuevoProd(Conexion con)
        {
            this.con = con;
            InitializeComponent();
        }

        private void FrmNuevoProd_Load(object sender, EventArgs e)
        {
            ListarProveedorNames();
        }
        private void ListarProveedorNames()
        {
            //con = new Conexion();
            cmbProveedor.DataSource = con.listarProveedor();
            cmbProveedor.DisplayMember = "NombreProv";
            cmbProveedor.ValueMember = "Id_Prov";
        }

        private void btnCrear_Click(object sender, EventArgs e)
        {
            if (txtNombre.Text=="" || txtPrecio.Text=="" || txtExistencia.Text=="" ||txtDescri.Text=="")
            {
                MessageBox.Show("Error ! Campos de texto vacios");
                return;
            }
            try
            {
                con.insertarProducto(txtNombre.Text, float.Parse(txtPrecio.Text), int.Parse(txtExistencia.Text), txtDescri.Text);
                MessageBox.Show("Insercion exitosa!");
            }
            catch (Exception)
            {
                MessageBox.Show("Ha ocurrido un error con la insercion");
            }
        }
    }  
}
