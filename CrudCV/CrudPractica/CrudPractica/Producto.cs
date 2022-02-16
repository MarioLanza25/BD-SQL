using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CrudPractica
{
    public partial class Producto : Form
    {
        private Conexion con;
        public Producto()
        {
            InitializeComponent();
        }

        public Producto(Conexion con)
        {
            this.con = con;
            InitializeComponent();
            listarProductos();
        }

        private void listarProductos()
        {
            con.listarProductos(tablaProducto);
        }
    }
}
