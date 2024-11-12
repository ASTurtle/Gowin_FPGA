using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;
using System.Xml.Linq;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        #region 全局变量
        /// <summary>
        /// 全局变量
        /// </summary>
        private string selectedFilePath;
        private SerialPort sp = null;       //声明一个串口类
        private bool isOpen = false;        //打开串口标志
        private bool isSetProperty = false; //属性设置标志
        private bool isHex = false;         //十六进制显示标志接收
        private bool isHexTx = false;       //十六进制显示标志发送标志
        
        /// <summary>
        /// 波形显示数据定义
        /// </summary>
        /// 
        //如果是全部显示使用list数组
        //private List<double> data_display1 = new List<double>();
        //private List<double> data_display2 = new List<double>();
        //private List<double> data_display3 = new List<double>();

        //如果显示的数据每次都只显示100个（固定个数的）数据，然后动起来的，使用队列
        private static int show_len = 100;//定义每次显示数据的长度
        private Queue<double> data_display1 = new Queue<double>(show_len);
        private Queue<double> data_display2 = new Queue<double>(show_len);
        private Queue<double> data_display3 = new Queue<double>(show_len);


        #endregion



        public Form1()
        {
            InitializeComponent();  //窗口初始化，net自动生成
        }

        #region 打开软件载入数据函数        
        /// <summary>
        /// 打开软件载入数据函数
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Form1_Load(object sender, EventArgs e)
        {
            this.MaximumSize = this.Size;
            this.MinimumSize = this.Size;
            this.MaximizeBox = false;
            checkCOM();

            //cbxCOMPort.SelectedIndex = 0;
            //列出常用的波特率
            cbxBaudBate.Items.Add("1200");
            cbxBaudBate.Items.Add("2400");
            cbxBaudBate.Items.Add("4800");
            cbxBaudBate.Items.Add("9600");
            cbxBaudBate.Items.Add("19200");
            cbxBaudBate.Items.Add("38400");
            cbxBaudBate.Items.Add("43000");
            cbxBaudBate.Items.Add("56000");
            cbxBaudBate.Items.Add("57600");
            cbxBaudBate.Items.Add("115200");
            cbxBaudBate.SelectedIndex = 3;//设置默认选中
            //列出停止位
            cbxStopBits.Items.Add("0");
            cbxStopBits.Items.Add("1");
            cbxStopBits.Items.Add("1.5");
            cbxStopBits.Items.Add("2");
            cbxStopBits.SelectedIndex = 1;//设置默认选中
            //列出数据位
            cbxDataBits.Items.Add("8");
            cbxDataBits.Items.Add("7");
            cbxDataBits.Items.Add("6");
            cbxDataBits.Items.Add("5");
            cbxDataBits.SelectedIndex = 0;//设置默认选中
            //列出奇偶校验
            cbxparity.Items.Add("无");
            cbxparity.Items.Add("奇校验");
            cbxparity.Items.Add("偶校验");
            cbxparity.SelectedIndex = 0;//设置默认选中

            //默认为char显示，标志位，单选框
            //默认为char发送
            tbnChar.Checked = true;

          
        }
        #endregion


        #region 串口检测
        /// <summary>
        /// 串口检测
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void checkCOM() {
            bool comExistence = false;      //有可用串口标志
            cbxCOMPort.Items.Clear();       //清除当前串口号中的所有串口名称


            string[] sPorts = SerialPort.GetPortNames();//获取所有的能用的串口的名字
            //cbxCOMPort.Items.Add("");//显示空字符的串口。
            foreach (string port in sPorts)
            {
                cbxCOMPort.Items.Add(port);
                comExistence = true;
            }
            

            if (comExistence)
            {
                cbxCOMPort.SelectedIndex = 0;   //使ListBox显示第1个添加的索引
            }
            else
            {
                MessageBox.Show("没有找到可用的串口！", "错误提示");
            }
        }

        private void btnCheckCOM_Click(object sender, EventArgs e)
        {
            checkCOM();
        }
        #endregion


        #region 私有函数，检测串口是否设置         
        /// <summary>
        /// 私有函数，检测串口是否设置 
        /// </summary>
        /// <returns></returns>
        private bool CheckPortSerring()
        {
            if (cbxCOMPort.Text.Trim() == "") return false;
            if (cbxBaudBate.Text.Trim() == "") return false;
            if (cbxDataBits.Text.Trim() == "") return false;
            if (cbxparity.Text.Trim() == "") return false;
            if (cbxStopBits.Text.Trim() == "") return false;
            return true;
        }
        #endregion


        #region 私有函数，检测发送数据
        /// <summary>
        /// 私有函数，检测发送数据
        /// </summary>
        /// <returns></returns>
        private bool CheckSendData()
        {
            if (tbxSendData.Text.Trim() == "") return false;
            return true;
        }
        #endregion


        #region 私有函数,软件启动设置串口的属性
        /// <summary>
        /// 私有函数,软件启动设置串口的属性
        /// </summary>
        private void SetPortProperty()  //
        {
            sp = new SerialPort();

            sp.PortName = cbxCOMPort.Text.Trim();  //设置串口名

            sp.BaudRate = Convert.ToInt32(cbxBaudBate.Text.Trim()); //设置串口的波特率

            float f = Convert.ToSingle(cbxStopBits.Text.Trim());    //设置停止位

            if (f == 0)
            {
                sp.StopBits = StopBits.None;
            }
            else if (f == 1.5)
            {
                sp.StopBits = StopBits.OnePointFive;
            }
            else if (f == 1)
            {
                sp.StopBits = StopBits.One;
            }
            else if (f == 2)
            {
                sp.StopBits = StopBits.Two;
            }
            else
            {
                sp.StopBits = StopBits.One;
            }

            sp.DataBits = Convert.ToInt16(cbxDataBits.Text.Trim()); //设置数据位

            string s = cbxparity.Text.Trim();   //设置奇偶检验为
            if (s.CompareTo("无") == 0)
            {
                sp.Parity = Parity.None;
            }
            else if (s.CompareTo("奇校验") == 0)
            {
                sp.Parity = Parity.Odd;
            }
            else if (s.CompareTo("偶校验") == 0)
            {
                sp.Parity = Parity.Even;
            }
            else
            {
                sp.Parity = Parity.None;
            }

            sp.ReadTimeout = -1;    //设置超时读取时间
            sp.RtsEnable = true;

           
        }
        #endregion


        #region 数据发送函数       
        /// <summary>
        /// 数据发送函数
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //
        private void btnSend_Click(object sender, EventArgs e)
        {
            if (isOpen)  //写串口数据
            {
                try
                {
                    if (isHexTx == false)//如果发送模式为字符模式
                    {
                        //sp.Write(tbxSendData.Text.ToString());                  //发送一串字符                     
                        //sp.WriteLine(tbxSendData.Text);                         //发送一串字符

                        Encoding gb = System.Text.Encoding.GetEncoding("UTF-8");   //发送字符
                        Byte[] writeBytes = gb.GetBytes(tbxSendData.Text);
                        sp.Write(writeBytes, 0, writeBytes.Length);
                    }
                    else//如果发送模式为HEX模式
                    {
                        string dataTxStr = tbxSendData.Text.ToString(); ;     //将textbox1 转化为 字符串
                        byte[] byte_hexTx = new byte[] { };
                        byte_hexTx = strToToHexByte(dataTxStr.ToString());    //字符串转化为16进制数组
                        sp.Write(byte_hexTx, 0, byte_hexTx.Length);           //发送数组
                    }

                }
                catch (Exception)
                {
                    MessageBox.Show("1、软件故障！\r\n" +
                        "2、发送十六进制高低位需填满！", "错误提示");

                    return;
                }
            }
            else
            {
                MessageBox.Show("串口未打开!", "提示错误");
                return;
            }

            if (!CheckSendData())    //检测要发送的数据
            {
                MessageBox.Show("请输入要发送的数据！", "错误提示");
                return;
            }
        }
        #endregion


        #region 打开串口按键
        /// <summary>
        /// 打开串口按键
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //打开串口
        private void btnOpenCom_Click(object sender, EventArgs e)
        {
            if (isOpen == false)
            {
                if (!CheckPortSerring()) //检测串口设置
                {
                    MessageBox.Show("串口未设置", "错误提示");
                    return;
                }

                if (!isSetProperty)  //串口未设置则设置串口
                {
                    SetPortProperty();
                    isSetProperty = true;
                }

                try //打开串口
                {
                    sp.Open();
                    isOpen = true;
                    btnOpenCom.Text = "关闭串口";
                    //串口打开后则相关的串口设置按钮便不可再用
                    cbxCOMPort.Enabled = false;
                    cbxBaudBate.Enabled = false;
                    cbxDataBits.Enabled = false;
                    cbxparity.Enabled = false;
                    cbxStopBits.Enabled = false;
                    tbnChar.Enabled = false;
                    tbnHex.Enabled = false;

                }
                catch (Exception)
                {
                    //串口打开失败后，相应标志位取消
                    isSetProperty = false;
                    isOpen = false;
                    MessageBox.Show("串口无效或已被占用!", "错误提示");
                }
            }
            else  //关闭串口
            {
                try
                {
                    sp.Close();
                    isOpen = false;
                    isSetProperty = false;
                    btnOpenCom.Text = "打开串口";
                    cbxCOMPort.Enabled = true;
                    cbxBaudBate.Enabled = true;
                    cbxDataBits.Enabled = true;
                    cbxparity.Enabled = true;
                    cbxStopBits.Enabled = true;
                    tbnChar.Enabled = true;
                    tbnHex.Enabled = true;

                }
                catch (Exception)
                {
                    MessageBox.Show("关闭时发生错误！", "错误提示");

                }
            }
        }
        #endregion


        


        #region 清除发送数据
        /// <summary>
        /// 清除发送数据
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>        
        private void btnCleanData_Click(object sender, EventArgs e)
        {
            tbxSendData.Text = "";
        }
        #endregion


        #region 字符串转16进制数组
        /// <summary>
        /// 字符串转16进制字节数组
        /// </summary>
        /// <param name="hexString"></param>
        /// <returns></returns>
        private static byte[] strToToHexByte(string hexString)
        {
            hexString = Regex.Replace(hexString, @"[^a-fA-F0-9 ]", "");
            hexString = hexString.Replace(" ", "");//去除空格，将接受到的hexStringde 
            if ((hexString.Length % 2) != 0)
                hexString += " ";
            byte[] returnBytes = new byte[hexString.Length / 2];
            for (int i = 0; i < returnBytes.Length; i++)
                returnBytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
            return returnBytes;
        }
        #endregion


        public int GetCheckBoxValue(CheckBox checkBox)
        {
            return checkBox.Checked ? 1 : 0;
        }



        //更新数据，怎么说呢，传输过来的数据保存到list当中，或者queue中，函数都一样


        private void timer1_Tick(object sender, EventArgs e)
        {
            //接收数据到queue中，假的数据
            Random r = new Random();
            int len = r.Next(0, 5);

            for (int i = 0; i < len; i++)
            {
                if (data_display1.Count > show_len)
                {
                    data_display1.Dequeue();
                    data_display2.Dequeue();
                    data_display3.Dequeue();
                }
                data_display1.Enqueue(r.NextDouble() * 10);          
                data_display2.Enqueue(r.NextDouble() * 20 + 10);
                data_display3.Enqueue(r.NextDouble() * 20 + 40);
            }

            

        }

        private void cbxCOMPort_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void chart1_Click(object sender, EventArgs e)
        {

        }

        private void rbnChar_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void trackBar1_Scroll(object sender, EventArgs e)
        {

        }

        private void trackBar2_Scroll(object sender, EventArgs e)
        {

        }

        private void menuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox6_Enter(object sender, EventArgs e)
        {

        }

        private void 压缩_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox7_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox9_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox10_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox11_Enter(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void tbxSendData_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void trackBar4_Scroll(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Text Files (*.txt)|*.txt"; // 设置文件过滤器，只显示TXT文件
            openFileDialog.Title = "请选择一个16进制数据文件";

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                selectedFilePath = openFileDialog.FileName; // 存储选中的文件路径
                textBoxFilePath.Text = selectedFilePath; // 显示文件路径
            }

        }

        private void comboBox9_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cbxDataBits_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cbxparity_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void trackBar1_Scroll_1(object sender, EventArgs e)
        {

        }

        private void bindingSource1_CurrentChanged(object sender, EventArgs e)
        {

        }

        private void button11_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox1);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                    checkBoxValue.ToString(),
                     trackBar1.Value.ToString(),
                     trackBar2.Value.ToString(),
                     trackBar3.Value.ToString(),
                     trackBar4.Value.ToString(),
                     trackBar5.Value.ToString(),
                     trackBar6.Value.ToString(),
                     trackBar7.Value.ToString(),
                     trackBar8.Value.ToString(),
                     trackBar9.Value.ToString(),
                     trackBar10.Value.ToString()
                                    });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }
        
        private void button13_Click(object sender, EventArgs e)
        {

        }

        private void comboBox5_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button9_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox6);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString(),
                comboBox9.SelectedIndex.ToString()
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            if (!isOpen)
            {
                MessageBox.Show("串口未打开!", "提示错误");
                return;
            }

            if (string.IsNullOrEmpty(selectedFilePath))
            {
                MessageBox.Show("请先加载一个文件！", "错误提示");
                return;
            }

            try
            {
                string dataTxStr = File.ReadAllText(selectedFilePath).Trim(); // 读取文件内容并去除空格
                byte[] byte_hexTx = strToToHexByte(dataTxStr); // 字符串转化为16进制数组
                sp.Write(byte_hexTx, 0, byte_hexTx.Length); // 发送数组
            }
            catch (Exception ex)
            {
                MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox2);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString()
                
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox7);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString(),
                comboBox8.SelectedIndex.ToString(),
                comboBox10.SelectedIndex.ToString()
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox4);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString(),
                comboBox7.SelectedIndex.ToString(),
                comboBox3.SelectedIndex.ToString()
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox3);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString(),
                comboBox6.SelectedIndex.ToString(),
                comboBox4.SelectedIndex.ToString()
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox5);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString(),
                comboBox5.SelectedIndex.ToString(),
                comboBox1.SelectedIndex.ToString()  
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }          
        }

        private void button12_Click(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox9);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString(),
                comboBox2.SelectedIndex.ToString()
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }


        private void comboBox7_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboBox8_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void checkBox6_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue = GetCheckBoxValue(checkBox8);
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue.ToString(),
                comboBox11.SelectedIndex.ToString()
            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0x0B
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0x0B;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面

                    sp.Write(finalData, 0, finalData.Length); // 发送数据
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            if (isOpen)  // 检查串口是否已经打开
            {
                try
                {
                    int checkBoxValue_0 = GetCheckBoxValue(checkBox5);
                    int checkBoxValue_1 = GetCheckBoxValue(checkBox3);
                    int checkBoxValue_2 = GetCheckBoxValue(checkBox4);
                    int checkBoxValue_3 = GetCheckBoxValue(checkBox6);
                    int checkBoxValue_4 = GetCheckBoxValue(checkBox7);
                    int checkBoxValue_5 = GetCheckBoxValue(checkBox2);
                    int checkBoxValue_6 = GetCheckBoxValue(checkBox1);
                    int checkBoxValue_7 = GetCheckBoxValue(checkBox8);
                    int checkBoxValue_8 = GetCheckBoxValue(checkBox9);
                    int checkBoxValue_9 = GetCheckBoxValue(checkBox10);
                    string text = File.ReadAllText(selectedFilePath).Trim();
                    // 发送特定数据
                    string dataTxStr = string.Join("", new string[] {
                checkBoxValue_0.ToString(),
                comboBox5.SelectedIndex.ToString(),
                comboBox1.SelectedIndex.ToString(),
                checkBoxValue_1.ToString(),
                comboBox6.SelectedIndex.ToString(),
                comboBox4.SelectedIndex.ToString(),
                checkBoxValue_2.ToString(),
                comboBox7.SelectedIndex.ToString(),
                comboBox3.SelectedIndex.ToString(),
                checkBoxValue_3.ToString(),
                comboBox9.SelectedIndex.ToString(),
                checkBoxValue_4.ToString(),
                comboBox8.SelectedIndex.ToString(),
                comboBox10.SelectedIndex.ToString(),
                checkBoxValue_5.ToString(),
                checkBoxValue_6.ToString(),
                trackBar1.Value.ToString(),
                trackBar2.Value.ToString(),
                trackBar3.Value.ToString(),
                trackBar4.Value.ToString(),
                trackBar5.Value.ToString(),
                trackBar6.Value.ToString(),
                trackBar7.Value.ToString(),
                trackBar8.Value.ToString(),
                trackBar9.Value.ToString(),
                trackBar10.Value.ToString(),
                checkBoxValue_7.ToString(),
                comboBox11.SelectedIndex.ToString(),
               checkBoxValue_8.ToString(),
               comboBox2.SelectedIndex.ToString(),
               checkBoxValue_9.ToString(),
               text

            });

                    // 将字符串转换为16进制字符串
                    string hexString = dataTxStr.Replace(" ", ""); // 去除空格
                    if ((hexString.Length % 2) != 0)
                        hexString += "0"; // 如果长度为奇数，补0

                    // 使用strToToHexByte方法将16进制字符串转换为字节数组
                    byte[] byte_hexTx = strToToHexByte(hexString);

                    // 设置第一个字节为0xFF
                    byte[] finalData = new byte[byte_hexTx.Length + 1];
                    finalData[0] = 0xDD;
                    byte_hexTx.CopyTo(finalData, 1); // 将转换后的字节数组复制到新数组的后面
                    //sp.Write(finalData, 0, finalData.Length); // 发送数据
                    byte END = 0xEE;
                    byte[] finalDataWithFrameEnd = new byte[finalData.Length + 1];
                    finalData.CopyTo(finalDataWithFrameEnd, 0);
                    finalDataWithFrameEnd[finalData.Length] = END;
                    sp.Write(finalDataWithFrameEnd, 0, finalDataWithFrameEnd.Length);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("发送数据时发生错误：" + ex.Message, "错误提示");
                }
            }
        }
    }




}
