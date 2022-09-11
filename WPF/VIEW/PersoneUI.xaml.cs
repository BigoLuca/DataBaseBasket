using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WPF.LOGIC;

namespace WPF.VIEW
{
    /// <summary>
    /// Logica di interazione per PersoneUI.xaml
    /// </summary>
    public partial class PersoneUI : UserControl
    {
        public PersoneUI()
        {
            InitializeComponent();
        }

        private void Reset(object sender, RoutedEventArgs e)
        {
            DataContext = new PlayerManager();
        }
    }
}
