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
    public partial class FrmPrincipal : Form
    {
        public FrmPrincipal()
        {
            InitializeComponent();
        }

        private void mostrarClientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmMostrarCL fmc = new FrmMostrarCL();
            fmc.MdiParent = this;
            fmc.Show();
        }

        private void mostrarProductosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmMostrarProd fmp = new FrmMostrarProd();
            fmp.MdiParent = this;
            fmp.Show();
        }

        private void agregarProductoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmNuevoProd fnp = new FrmNuevoProd();
            fnp.MdiParent = this;
            fnp.Show();
        }
    }
}
