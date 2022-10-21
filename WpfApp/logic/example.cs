using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using WpfApp.model;

namespace WpfApp.logic
{
    internal class example
    {
        DatabaseEntities db = new DatabaseEntities();

        public GIOCATORE[] Giocatore => db.GIOCATORE.ToArray();
    }
}
