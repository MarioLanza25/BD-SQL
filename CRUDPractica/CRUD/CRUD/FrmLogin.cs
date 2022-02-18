using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Threading;

namespace CRUD
{
    public partial class FrmLogin : Form
    {
        Conexion con;
        int contador = 3;

        public FrmLogin()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;

            if (txtUser.Text=="" || txtPass.Text=="")
            {
                MessageBox.Show("Campo usuario y pass no pueden ser vacios", "Sistema");

                Cursor.Current = Cursors.Default;
                return;
            }

            con = new Conexion(txtUser.Text, txtPass.Text);

            if (this.con.connect.State== ConnectionState.Open)
            {
                MessageBox.Show("Bienvenido!!", "Sistema");

                Thread.Sleep(3000);

                FrmPrincipal principal = new FrmPrincipal();
                principal.Show();
                this.Hide();

            }
            else
            {
                Cursor.Current = Cursors.Default;
                --contador;
                MessageBox.Show("Error! Usuario o contraseina incorrecta.\nIntentos restantes: " +contador, "Sistema");
                if (contador== 0)
                {
                    contador = 3;
                    btnIngresar.Enabled = false;
                    btnCancelar.Enabled = false;
                    Thread.Sleep(2500);
                    btnIngresar.Enabled = true;
                    btnCancelar.Enabled = true;

                }
            }

        }
    }
}
