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
    public partial class Insertar : Form
    {
        private Conectar con;
        Encrypt md5 = new Encrypt();
        public Insertar()
        {
            InitializeComponent();
        }

        public Insertar(Conectar con)
        {
            this.con = con;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            if (textBox1.Text.Equals("") || textBox2.Text.Equals("") || textBox4.Text.Equals("") || textBox3.Text.Equals(""))
            {
                MessageBox.Show("Campos vacios");
                return;
            }

            con.insertarCliente(textBox1.Text, textBox2.Text,md5.md5(textBox3.Text) ,maskedTextBox1.Text, textBox4.Text);
            this.Hide();

        }

        private void button2_Click(object sender, EventArgs e)
        {



        }
    }
}
