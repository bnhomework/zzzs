<template>
  <div>
    <tab>
      <tab-item :selected="!historyOrder?'selected':null" @on-item-click="onItemClick(0)">我的预约</tab-item>
      <tab-item :selected="historyOrder?'selected':null" @on-item-click="onItemClick(1)">历史预约</tab-item>
    </tab>
    <div v-for="item in showOrders">
    <br>
      <form-preview header-label="金额" :header-value="item.Amount" :body-items="item.list" :footer-buttons="item.actions" ></form-preview>
    <br>
    </div>
  </div>
</template>

<script>
import { Tab, TabItem,Toast,FormPreview  } from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins:[utils],
  components: {
    Tab, TabItem,Toast,FormPreview 
  },
  data () {
    return {
      orders:[],
      historyOrder:false,
      allStatus : [{ StatusName: 'All' }, { StatusName: '未付款', Id: '0' }, { StatusName: '已付款', Id: '1' }, { StatusName: '申请退款', Id: '-1' }, { StatusName: '已退款', Id: '-2' }]
            
    }
  },
  created(){
    this.init();
  },
  methods:{
    init(){
      this.loadOrders();
    },
    onItemClick(v){
      if(v==0){
        this.historyOrder=false;
      }
      else{
        this.historyOrder=true;
      }
    }
    ,
    loadOrders(){
      var url = this.apiServer + 'zy/GetOrders';
      var data ={
        openId: this.$store.state.bn.openId};
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          vm.orders = res.data;
        });
    },
    requestRefund(orderId){
      var url = this.apiServer + 'zy/RequestRefund';
      var data ={
        orderId: orderId};
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          if(res.data&&res.data.status==true){
            vm.$vux.toast.show({
              text: '申请成功'
            })
        }
        else if(res.data&&(res.data.message!=''||res.data.message!='')){
          vm.$vux.toast.show({
              text: res.data.message
            })
        }
        vm.loadOrders();
      });
    },
    displayStatus(s)
            {
                var l = this.allStatus.filter(function (x) { return x.Id == s; });
                if (l.length>0) {
                    return l[0].StatusName;
                }
                return 'NA';
            }
  },
  computed:{
    showOrders(){
      var currentDate=this.getCurrentDate();
      var vm=this;
      var olist=this.orders.filter(function(x){
        if(vm.historyOrder){
          return x.OrderDate<currentDate;
        }else{
          return x.OrderDate>=currentDate;
        }
      });
      var viewOrders=[];
      for (var i=0; i <olist.length; i++) {
        var o=olist[0];
        var vo={};
        vo.Amount=o.Amount;
        vo.list=[];
        vo.list.push({label:'日期',value:o.OrderDate})
        vo.list.push({label:'店名',value:o.ShopName})
        vo.list.push({label:'桌号',value:o.DeskName})
        vo.list.push({label:'座位个数',value:o.Positions==null?0:o.Positions.length})         
        vo.list.push({label:'订单状态',value:vm.displayStatus(o.Status)})
        vo.actions=[];
        if(!vm.historyOrder&&o.Status==1){
          vo.actions.push({style: 'default',
        text: '申请退款',
        onButtonClick: () => {
          vm.requestRefund(o.OrderId);
        }})
        }
        viewOrders.push(vo);
      }
      return viewOrders;
    }
  }
}
</script>

<style>
.vux-demo {
  text-align: center;
}
.logo {
  width: 100px;
  height: 100px
}
</style>
