<template>
  <div style="width:100%;overflow:hidden;">
    <div class="vux-sticky-box vux-fixed" style="top: 0px;">
      <tab>
        <tab-item :selected="action==10" @on-item-click="action=10">未完成</tab-item>
        <tab-item :selected="action==20" @on-item-click="action=20">已完成</tab-item>
        <tab-item :selected="action==30" @on-item-click="action=30">全部订单</tab-item>
      </tab>
    </div>
    <div style="margin-top:46px">
    </div>
    <div class="vux-form-preview weui-form-preview" v-for="item in ordersToShow" style="margin-bottom:20px">
      <!-- <div class="weui-form-preview__hd">
        <span style="border:1px solid #f85;padding:4px;border-radius:4px;color:#f85">{{getOrderStatus(item.OrderStatus)}}</span>
      </div> -->
      <div class="weui-form-preview__bd" style="text-align:left;margin-top:20px;margin-bottom:20px">
        <img :src="getImgSrc(item.Preview)" style="width:30%;min-height:90px">
        <div style="display:inline-block;width:65%;vertical-align: top; height:100%">
          <p>订单编号：{{item.TrackingNumber}}</p>
          <p class="content-1">设计：{{item.DesginName}}</p>
          <p>颜色：{{item.Color}} </p>
          <span class="amount" style="position:absolute;bottom:50px;">￥ {{item.TotalAmount}}</span>
          <span class="pull-right" style="font-size:10px;position:absolute;top:10px;right:15px;border:1px solid #f85;padding:2px;border-radius:4px;color:#f85">{{getOrderStatus(item.OrderStatus)}}</span>
          <span class="pull-right" style="position:absolute;bottom:55px;right:15px;font-size:16px">x {{item.Quiantity}}</span>
        </div>
      </div>
      <div class="weui-form-preview__ft">
        <a href="javascript:" v-if="getOrderAction(item)==1" class="weui-form-preview__btn weui-form-preview__btn_default" @click="requestRefund(item.OrderId)">申请退款</a>
        <a href="javascript:" v-if="getOrderAction(item)==2" class="weui-form-preview__btn weui-form-preview__btn_primary" @click="viewLogistics(item.OrderId)">查看物流</a>
        <a href="javascript:" v-if="getOrderAction(item)==0" class="weui-form-preview__btn weui-form-preview__btn_primary">&nbsp</a>
      </div>
    </div>
  </div>
</template>
<script>
import { Group, Cell, Tab, TabItem, Sticky } from 'vux'
import utils from '@/mixins/utils'
import _ from 'underscore'
export default {
  mixins: [utils],
  components: {
    Group,
    Cell,
    Tab,
    TabItem,
    Sticky
  },
  data() {
    return {
      orders: [],
      action: 10
    }
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.loadOrders();
    },
    loadOrders() {
      var url = this.apiServer + 'zz/GetRealOrders';
      var data = {
        openId: this.$store.state.bn.openId
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          vm.orders = res.data;
        });
    },
    getOrderAction(x) {
      if (x.OrderStatus == 20 || x.OrderStatus == 30) {
        return 1;
      } else if (x.OrderStatus == 50) {
        return 2;
      } else {
        return 0;
      }
    },
    requestRefund(orderId) {
      var vm = this;
      this.$vux.confirm.show({
        title: '',
        content: '确定申请退款？',
        onConfirm() {
          vm.doRequestRefund(orderId);
        }
      })
    },
    doRequestRefund(orderId) {
      var vm = this;
      var url = this.apiServer + 'zz/RequestRefund';
      var data = {
        orderId: orderId
      };
      this.$http.post(url, data)
        .then(res => {
          var index = _.findIndex(vm.orders, function(x) { return x.OrderId == orderId });
          vm.$set(vm.orders[index], 'OrderStatus', 40);
        });
    },
    viewLogistics(orderId) {
      this.goTo({name:'LogisticsInfo',params:{orderId:orderId}});
    }
  },
  computed: {
    ordersToShow() {
      if (this.action == 10) {
        return _.filter(this.orders, (x) => {
          return x.OrderStatus >= 20 && x.OrderStatus < 50;
        });
      } else if (this.action == 20) {
        return _.filter(this.orders, (x) => {
          return x.OrderStatus >= 50;
        });
      } else if (this.action == 30) {
        return this.orders;
      }
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
