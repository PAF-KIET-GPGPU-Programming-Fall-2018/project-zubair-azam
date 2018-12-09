using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication3
{
    class Program
    {
        static void Main(string[] args)
        {

            List<string[]> trans = new List<string[]>();
            List<string[]> pattern = new List<string[]>();
            Dictionary<string, int> itemcount = new Dictionary<string, int>();

            trans.Add(new[] { "1", "2", "3" });
            trans.Add(new[] { "1", "2", "3" });
            trans.Add(new[] { "1", "2", "3" });

            pattern.Add(new[] { "1", "2" });
            pattern.Add(new[] { "2", "3" });
            pattern.Add(new[] { "1,", "3" });

            itemcount.Add("1", 1);
            itemcount.Add("2", 1);
            itemcount.Add("3", 1);



            foreach (var item in pattern)
            {
                string[] seq = item;
                int seqsupport = 0;
                foreach (var row in trans)
                {
                    string[] rowdata = row;
                    int count = 0;
                    for (int i = 0; i < seq.Length; i++)
                    {
                        foreach (var cells in rowdata)
                        {
                            if (cells == seq[i])
                            {
                                count++;
                                break;
                            }
                        }
                    }


                    if (count == seq.Length)
                    {
                        seqsupport++;
                    }
                }
                if(seqsupport>2)
                {
                    //confidence
                    for (int i = 0; i < seq.Length; i++)
                    {
                       
                        Console.WriteLine(seq[i]+"=>"+(seqsupport/itemcount[seq[i]]));
                    }
                }
            }





        }
    }
}
