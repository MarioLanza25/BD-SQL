using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Conexion
{
    public partial class MDI : Form
    {
        public Conectar con;

        public MDI()
        {
            InitializeComponent();
        }

        public MDI(Conectar con)
        {
            this.con = con;
            InitializeComponent();

        }

        private void clienteToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Insertar ins = new Insertar(con);
            ins.MdiParent = this;
            ins.Show();
        }

        private void listarClientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Clientes cli = new Clientes(con);
            cli.MdiParent = this;
            
            cli.Show();

        }
    }
}
