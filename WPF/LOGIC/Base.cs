using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WPF.LOGIC
{
    abstract class Base : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(PropertyChangedEventArgs eventArgs) => PropertyChanged?.Invoke(this, eventArgs);

        protected void OnPropertyChanged(params string[] properties)
        {
            foreach (var p in properties)
                OnPropertyChanged(new PropertyChangedEventArgs(p));
        }
    }
}
