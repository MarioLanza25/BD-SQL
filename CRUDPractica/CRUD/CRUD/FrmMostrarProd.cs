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
    public partial class FrmMostrarProd : Form
    {
        private Conexion con;

        public FrmMostrarProd()
        {
            InitializeComponent();
        }

        public FrmMostrarProd(Conexion con)
        {
            this.con = con;
            InitializeComponent();
            listarClientes();
        }

        private void listarClientes()
        {
            con.listarProductos(dgvProductos);
        }
    }
}
