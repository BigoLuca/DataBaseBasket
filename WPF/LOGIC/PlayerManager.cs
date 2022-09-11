using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Animation;
using WPF.MODEL;

namespace WPF.LOGIC
{
    internal class PlayerManager : Base
    {
        DatabaseEntities db = new DatabaseEntities();


        //public GIOCATORE[] player => db.GIOCATORE.ToArray();
        public List<GIOCATORE> playerList => db.GIOCATORE.ToList();

        public bool isIscritto { get; set; } = true;
        public bool isNotIscritto => !isIscritto;

        public string plyFirst { get; set; }
        public string plyLast { get; set; }
        public string plyCF { get; set; }
        public string plyAge { get; set; }
        public string plyPhone { get; set; }
        public string plyMail { get; set; }
        public string plyNum { get; set; }

        public GIOCATORE ply { get; set; }

        public void addPlayer()
        {

        }
    }

}
