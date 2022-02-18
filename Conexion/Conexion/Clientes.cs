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
    public partial class Clientes : Form
    {
        private Conectar con;
        int renglon;
        public Clientes()
        {
            InitializeComponent();
        }

        public Clientes(Conectar con)
        {
            this.con = con;
            InitializeComponent();
            ListarClientes();
            textBox2.Enabled = false;
            textBox3.Enabled = false;
            button1.Enabled = false;
            button2.Enabled = false;
           
        }

        private void ListarClientes()
        {
            con.listarClientes(dataGridView1);
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            renglon = e.RowIndex;
        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            string nombre,apellido,id;

            textBox2.Enabled = true;
            textBox3.Enabled = true;
            button1.Enabled = true;
            button2.Enabled = true;

            id = dataGridView1.Rows[renglon].Cells["ID"].Value.ToString();
            textBox1.Text = id; //Aqui le asignas al TextBox lo que sacaste del dgv
            nombre = dataGridView1.Rows[renglon].Cells["Telefono"].Value.ToString();
            textBox2.Text = nombre; //Aqui le asignas al TextBox lo que sacaste del dgv
            apellido = dataGridView1.Rows[renglon].Cells["Direccion"].Value.ToString();
            textBox3.Text = apellido; //Aqui le asignas al TextBox lo que sacaste del dgv
        }

        private void button1_Click(object sender, EventArgs e)
        {
            con.editarCliente(dataGridView1,int.Parse(textBox1.Text) ,textBox2.Text,textBox3.Text);
            ListarClientes();
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";

            textBox2.Enabled = false;
            textBox3.Enabled = false;

            button1.Enabled = false;
            button2.Enabled = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            con.eliminarCliente(int.Parse(textBox1.Text));
            ListarClientes();
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";

            textBox2.Enabled = false;
            textBox3.Enabled = false;

            button1.Enabled = false;
            button2.Enabled = false;
        }

        private void button3_Click(object sender, EventArgs e)
        {


            if(textBox1.Text.Equals(""))
            {
                MessageBox.Show("No puede quedar vacio el campo busqueda");
                return;
            }

            string searchValue = textBox1.Text;
            
            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            try
            {
                foreach (DataGridViewRow row in dataGridView1.Rows)
                {
                    Console.WriteLine(row.Cells[0].Value.ToString());

                    if (row.Cells[0].Value.ToString().Equals(searchValue))
                    {
                        row.Selected = true;
                        break;
                    }
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
            }
        }

        private void Clientes_Load(object sender, EventArgs e)
        {

        }
    }
}
