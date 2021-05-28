
namespace VS
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.serialPort1 = new System.IO.Ports.SerialPort(this.components);
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.S1L40 = new System.Windows.Forms.Button();
            this.S1L30 = new System.Windows.Forms.Button();
            this.S1L20 = new System.Windows.Forms.Button();
            this.S1L10 = new System.Windows.Forms.Button();
            this.S1L41 = new System.Windows.Forms.Button();
            this.S1L31 = new System.Windows.Forms.Button();
            this.S1L21 = new System.Windows.Forms.Button();
            this.S1L11 = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.S2L40 = new System.Windows.Forms.Button();
            this.S2L30 = new System.Windows.Forms.Button();
            this.S2L20 = new System.Windows.Forms.Button();
            this.S2L10 = new System.Windows.Forms.Button();
            this.S2L41 = new System.Windows.Forms.Button();
            this.S2L31 = new System.Windows.Forms.Button();
            this.S2L21 = new System.Windows.Forms.Button();
            this.S2L11 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.portCBB = new System.Windows.Forms.ComboBox();
            this.Connectbtn = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.tempLabel = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // serialPort1
            // 
            this.serialPort1.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serialPort1_DataReceived);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.S1L40);
            this.groupBox1.Controls.Add(this.S1L30);
            this.groupBox1.Controls.Add(this.S1L20);
            this.groupBox1.Controls.Add(this.S1L10);
            this.groupBox1.Controls.Add(this.S1L41);
            this.groupBox1.Controls.Add(this.S1L31);
            this.groupBox1.Controls.Add(this.S1L21);
            this.groupBox1.Controls.Add(this.S1L11);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(425, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(363, 179);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Slave1";
            // 
            // S1L40
            // 
            this.S1L40.Location = new System.Drawing.Point(270, 95);
            this.S1L40.Name = "S1L40";
            this.S1L40.Size = new System.Drawing.Size(76, 48);
            this.S1L40.TabIndex = 7;
            this.S1L40.Text = "OFF";
            this.S1L40.UseVisualStyleBackColor = true;
            this.S1L40.Click += new System.EventHandler(this.S1L40_Click);
            // 
            // S1L30
            // 
            this.S1L30.Location = new System.Drawing.Point(188, 95);
            this.S1L30.Name = "S1L30";
            this.S1L30.Size = new System.Drawing.Size(76, 48);
            this.S1L30.TabIndex = 6;
            this.S1L30.Text = "OFF";
            this.S1L30.UseVisualStyleBackColor = true;
            this.S1L30.Click += new System.EventHandler(this.S1L30_Click);
            // 
            // S1L20
            // 
            this.S1L20.Location = new System.Drawing.Point(106, 95);
            this.S1L20.Name = "S1L20";
            this.S1L20.Size = new System.Drawing.Size(76, 48);
            this.S1L20.TabIndex = 5;
            this.S1L20.Text = "OFF";
            this.S1L20.UseVisualStyleBackColor = true;
            this.S1L20.Click += new System.EventHandler(this.S1L20_Click);
            // 
            // S1L10
            // 
            this.S1L10.Location = new System.Drawing.Point(24, 95);
            this.S1L10.Name = "S1L10";
            this.S1L10.Size = new System.Drawing.Size(76, 48);
            this.S1L10.TabIndex = 4;
            this.S1L10.Text = "OFF";
            this.S1L10.UseVisualStyleBackColor = true;
            this.S1L10.Click += new System.EventHandler(this.S1L10_Click);
            // 
            // S1L41
            // 
            this.S1L41.Location = new System.Drawing.Point(270, 41);
            this.S1L41.Name = "S1L41";
            this.S1L41.Size = new System.Drawing.Size(76, 48);
            this.S1L41.TabIndex = 3;
            this.S1L41.Text = "ON";
            this.S1L41.UseVisualStyleBackColor = true;
            this.S1L41.Click += new System.EventHandler(this.S1L41_Click);
            // 
            // S1L31
            // 
            this.S1L31.Location = new System.Drawing.Point(188, 41);
            this.S1L31.Name = "S1L31";
            this.S1L31.Size = new System.Drawing.Size(76, 48);
            this.S1L31.TabIndex = 2;
            this.S1L31.Text = "ON";
            this.S1L31.UseVisualStyleBackColor = true;
            this.S1L31.Click += new System.EventHandler(this.S1L31_Click);
            // 
            // S1L21
            // 
            this.S1L21.Location = new System.Drawing.Point(106, 41);
            this.S1L21.Name = "S1L21";
            this.S1L21.Size = new System.Drawing.Size(76, 48);
            this.S1L21.TabIndex = 1;
            this.S1L21.Text = "ON";
            this.S1L21.UseVisualStyleBackColor = true;
            this.S1L21.Click += new System.EventHandler(this.S1L21_Click);
            // 
            // S1L11
            // 
            this.S1L11.Location = new System.Drawing.Point(24, 41);
            this.S1L11.Name = "S1L11";
            this.S1L11.Size = new System.Drawing.Size(76, 48);
            this.S1L11.TabIndex = 0;
            this.S1L11.Text = "ON";
            this.S1L11.UseVisualStyleBackColor = true;
            this.S1L11.Click += new System.EventHandler(this.S1L11_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.S2L40);
            this.groupBox2.Controls.Add(this.S2L30);
            this.groupBox2.Controls.Add(this.S2L20);
            this.groupBox2.Controls.Add(this.S2L10);
            this.groupBox2.Controls.Add(this.S2L41);
            this.groupBox2.Controls.Add(this.S2L31);
            this.groupBox2.Controls.Add(this.S2L21);
            this.groupBox2.Controls.Add(this.S2L11);
            this.groupBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.Location = new System.Drawing.Point(425, 216);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(363, 179);
            this.groupBox2.TabIndex = 8;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Slave2";
            // 
            // S2L40
            // 
            this.S2L40.Location = new System.Drawing.Point(270, 95);
            this.S2L40.Name = "S2L40";
            this.S2L40.Size = new System.Drawing.Size(76, 48);
            this.S2L40.TabIndex = 7;
            this.S2L40.Text = "OFF";
            this.S2L40.UseVisualStyleBackColor = true;
            this.S2L40.Click += new System.EventHandler(this.S2L40_Click);
            // 
            // S2L30
            // 
            this.S2L30.Location = new System.Drawing.Point(188, 95);
            this.S2L30.Name = "S2L30";
            this.S2L30.Size = new System.Drawing.Size(76, 48);
            this.S2L30.TabIndex = 6;
            this.S2L30.Text = "OFF";
            this.S2L30.UseVisualStyleBackColor = true;
            this.S2L30.Click += new System.EventHandler(this.S2L30_Click);
            // 
            // S2L20
            // 
            this.S2L20.Location = new System.Drawing.Point(106, 95);
            this.S2L20.Name = "S2L20";
            this.S2L20.Size = new System.Drawing.Size(76, 48);
            this.S2L20.TabIndex = 5;
            this.S2L20.Text = "OFF";
            this.S2L20.UseVisualStyleBackColor = true;
            this.S2L20.Click += new System.EventHandler(this.S2L20_Click);
            // 
            // S2L10
            // 
            this.S2L10.Location = new System.Drawing.Point(24, 95);
            this.S2L10.Name = "S2L10";
            this.S2L10.Size = new System.Drawing.Size(76, 48);
            this.S2L10.TabIndex = 4;
            this.S2L10.Text = "OFF";
            this.S2L10.UseVisualStyleBackColor = true;
            this.S2L10.Click += new System.EventHandler(this.S2L10_Click);
            // 
            // S2L41
            // 
            this.S2L41.Location = new System.Drawing.Point(270, 41);
            this.S2L41.Name = "S2L41";
            this.S2L41.Size = new System.Drawing.Size(76, 48);
            this.S2L41.TabIndex = 3;
            this.S2L41.Text = "ON";
            this.S2L41.UseVisualStyleBackColor = true;
            this.S2L41.Click += new System.EventHandler(this.S2L41_Click);
            // 
            // S2L31
            // 
            this.S2L31.Location = new System.Drawing.Point(188, 41);
            this.S2L31.Name = "S2L31";
            this.S2L31.Size = new System.Drawing.Size(76, 48);
            this.S2L31.TabIndex = 2;
            this.S2L31.Text = "ON";
            this.S2L31.UseVisualStyleBackColor = true;
            this.S2L31.Click += new System.EventHandler(this.S2L31_Click);
            // 
            // S2L21
            // 
            this.S2L21.Location = new System.Drawing.Point(106, 41);
            this.S2L21.Name = "S2L21";
            this.S2L21.Size = new System.Drawing.Size(76, 48);
            this.S2L21.TabIndex = 1;
            this.S2L21.Text = "ON";
            this.S2L21.UseVisualStyleBackColor = true;
            this.S2L21.Click += new System.EventHandler(this.S2L21_Click);
            // 
            // S2L11
            // 
            this.S2L11.Location = new System.Drawing.Point(24, 41);
            this.S2L11.Name = "S2L11";
            this.S2L11.Size = new System.Drawing.Size(76, 48);
            this.S2L11.TabIndex = 0;
            this.S2L11.Text = "ON";
            this.S2L11.UseVisualStyleBackColor = true;
            this.S2L11.Click += new System.EventHandler(this.S2L11_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(25, 32);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(51, 25);
            this.label1.TabIndex = 38;
            this.label1.Text = "Port";
            // 
            // portCBB
            // 
            this.portCBB.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.portCBB.FormattingEnabled = true;
            this.portCBB.Location = new System.Drawing.Point(82, 32);
            this.portCBB.Name = "portCBB";
            this.portCBB.Size = new System.Drawing.Size(206, 28);
            this.portCBB.TabIndex = 37;
            // 
            // Connectbtn
            // 
            this.Connectbtn.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Connectbtn.Location = new System.Drawing.Point(306, 32);
            this.Connectbtn.Name = "Connectbtn";
            this.Connectbtn.Size = new System.Drawing.Size(113, 28);
            this.Connectbtn.TabIndex = 39;
            this.Connectbtn.Text = "Connect";
            this.Connectbtn.UseVisualStyleBackColor = true;
            this.Connectbtn.Click += new System.EventHandler(this.Connectbtn_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(24, 112);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(123, 31);
            this.label2.TabIndex = 40;
            this.label2.Text = "Nhiệt độ:";
            // 
            // tempLabel
            // 
            this.tempLabel.AutoSize = true;
            this.tempLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tempLabel.Location = new System.Drawing.Point(153, 115);
            this.tempLabel.Name = "tempLabel";
            this.tempLabel.Size = new System.Drawing.Size(26, 29);
            this.tempLabel.TabIndex = 41;
            this.tempLabel.Text = "0";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.tempLabel);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.Connectbtn);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.portCBB);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.IO.Ports.SerialPort serialPort1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button S1L40;
        private System.Windows.Forms.Button S1L30;
        private System.Windows.Forms.Button S1L20;
        private System.Windows.Forms.Button S1L10;
        private System.Windows.Forms.Button S1L41;
        private System.Windows.Forms.Button S1L31;
        private System.Windows.Forms.Button S1L21;
        private System.Windows.Forms.Button S1L11;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button S2L40;
        private System.Windows.Forms.Button S2L30;
        private System.Windows.Forms.Button S2L20;
        private System.Windows.Forms.Button S2L10;
        private System.Windows.Forms.Button S2L41;
        private System.Windows.Forms.Button S2L31;
        private System.Windows.Forms.Button S2L21;
        private System.Windows.Forms.Button S2L11;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox portCBB;
        private System.Windows.Forms.Button Connectbtn;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label tempLabel;
    }
}

