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

namespace WPF
{
    /// <summary>
    /// Logica di interazione per MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

            WPF.DatabaseDataSet databaseDataSet = ((WPF.DatabaseDataSet)(this.FindResource("databaseDataSet")));
            // Carica i dati nella tabella GIOCATORE. Se necessario, è possibile modificare questo codice.
            WPF.DatabaseDataSetTableAdapters.GIOCATORETableAdapter databaseDataSetGIOCATORETableAdapter = new WPF.DatabaseDataSetTableAdapters.GIOCATORETableAdapter();
            databaseDataSetGIOCATORETableAdapter.Fill(databaseDataSet.GIOCATORE);
            System.Windows.Data.CollectionViewSource gIOCATOREViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("gIOCATOREViewSource")));
            gIOCATOREViewSource.View.MoveCurrentToFirst();
        }
    }
}
