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
    public partial class FrmMDI : Form
    {
        public Conexion con;
        public FrmMDI()
        {
            InitializeComponent();
        }

        public FrmMDI(Conexion con)
        {
            this.con = con;
            InitializeComponent();
        }

        private void proToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Producto p = new Producto(con);
            p.MdiParent = this;
            p.Show();
        }

        private void clienteToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }
    }
}
