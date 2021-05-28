using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
namespace VS
{
    public partial class Form1 : Form
    {
        string[] allPort;
        string nhietdo = "";
        string data = "";
        string send;
        public Form1()
        {
            InitializeComponent();
        }

        private void S1L11_Click(object sender, EventArgs e)
        {
            if(serialPort1.IsOpen)
            {
                serialPort1.Write("S1L11");
            }
        }

        private void S1L10_Click(object sender, EventArgs e)
        {
            send = "S1L10";
            if (serialPort1.IsOpen)
            {
                serialPort1.Write(send);
            }
        }

        private void S1L21_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S1L21");
            }
        }

        private void S1L20_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S1L20");
            }
        }

        private void S1L31_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S1L31");
            }
        }

        private void S1L30_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S1L30");
            }
        }

        private void S1L41_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S1L41");
            }
        }

        private void S1L40_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S1L40");
            }
        }

        private void S2L11_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L11");
            }
        }

        private void S2L10_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L10");
            }
        }

        private void S2L21_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L21");
            }
        }

        private void S2L20_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L20");
            }
        }

        private void S2L31_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L31");
            }
        }

        private void S2L30_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L30");
            }
        }

        private void S2L41_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L41");
            }
        }

        private void S2L40_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Write("S2L40");
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            allPort = SerialPort.GetPortNames();
            for (int i = 0; i < allPort.Length; i++)
            {
                portCBB.Items.Add(allPort[i]);
            }
        }

        private void Connectbtn_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen == false)
            {
                if (this.portCBB.SelectedItem != null)
                {
                    serialPort1.PortName = this.portCBB.SelectedItem.ToString();
                    serialPort1.Open();
                    Connectbtn.Text = "Disconnect";
                }
            }
            else
            {
                serialPort1.Close();
                Connectbtn.Text = "Connect";
            }
        }

        private void serialPort1_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            data = serialPort1.ReadTo("\n");
            this.Invoke(new EventHandler(serialFunction));
        }
        private void serialFunction(object sender, EventArgs e)
        {
            nhietdo = data.Substring(2, 2);
            tempLabel.Text = nhietdo + "°C";
        }
    }
}
