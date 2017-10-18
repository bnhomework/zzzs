using System.Collections.Generic;
namespace BnWS.Entity
{
    public class PageSearch<T>
    {
        public int pageIndex { get; set; }
        public int pageSize { get; set; }
        public int SkipCount
        {
            get { return (pageIndex - 1) * pageSize; }
        }
        public T q { get; set; }
    }
    public class PageResult<T>
    {
        public int Total { get; set; }
        public List<T> Rows { get; set; }

        public PageResult(List<T> rows, int total)
        {
            Rows = rows;
            Total = total;
        }
    }
}