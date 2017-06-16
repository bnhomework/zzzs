using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bn.WeiXin
{
    public static class Utility
    {
        public static Guid Generate()
        {
            var buffer = Guid.NewGuid().ToByteArray();

            var time = new DateTime(0x76c, 1, 1);
            var now = DateTime.Now;
            var span = new TimeSpan(now.Ticks - time.Ticks);
            var timeOfDay = now.TimeOfDay;

            var bytes = BitConverter.GetBytes(span.Days);
            var array = BitConverter.GetBytes(
                (long)(timeOfDay.TotalMilliseconds / 3.333333));

            Array.Reverse(bytes);
            Array.Reverse(array);
            Array.Copy(bytes, bytes.Length - 2, buffer, buffer.Length - 6, 2);
            Array.Copy(array, array.Length - 4, buffer, buffer.Length - 4, 4);

            return new Guid(buffer);
        }

        public static string Signature(string raw)
        {
            var arrString = string.Join("", raw);
            var sha1 = System.Security.Cryptography.SHA1.Create();
            var sha1Arr = sha1.ComputeHash(Encoding.UTF8.GetBytes(arrString));
            var sb = new StringBuilder();
            foreach (var b in sha1Arr)
            {
                sb.AppendFormat("{0:x2}", b);
            }
            return sb.ToString();
        }
    }
}
