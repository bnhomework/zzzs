<template>
  <div style="width:100%;overflow-x:hidden;margin-bottom:46px;height:100%">
    <popup-address ref="pickAddress"></popup-address>
    <!--    <group>
      <cell :value="item.dist" :link="{path:'/shop/'+item.shopId}" v-for="item in orders" :key="item.shopId">
        <img slot="icon" width="100" style="display:block;margin-right:5px;" :src="getImgSrc(item.imgUrl)">
        <span slot="title">{{item.shopName}}</span>
        <span slot="inline-desc">{{item.description}}</span>
      </cell>
    </group> -->
    <div class="action-bar">
      <a v-show="!showEdit" @click="showEdit=true">编辑</a>
      <a v-show="showEdit" @click="showEdit=false">完成</a>
    </div>
    <div v-show="loadingData==false&&orders.length==0" style="text-align:center;margin-top:40%">
      您的购物车还是空的,快去添加商品吧....
      <br/>
      <div></div>
      <br/>
      <x-button mini plain type="primary" link="/DesginList">去添加商品</x-button>
    </div>
    <div class="weui-cells weui-cells_checkbox">
      <label v-for="o in orderListOptions" :for="'checkbox_bn'+o.key" class="weui-cell weui-check_label">
        <div class="weui-cell__hd">
          <input type="checkbox" name="vux-checkbox-bn" :id="'checkbox_bn'+o.key" class="weui-check" :value="o.key" v-model="selectedOrders"> <i class="weui-icon-checked vux-checklist-icon-checked"></i></div>
        <div class="weui-cell__bd">
          <!-- <div> -->
          <img :src="getImgSrc(o.preview)" style="width:30%;min-height:90px">
          <div style="display:inline-block;width:65%;vertical-align: top; height:100%">
            <p class="content-1">{{o.value}}</p>
            <p>{{o.inlineDesc}}</p>
            <span class="amount" style="position:absolute;bottom:15px;">￥ {{o.amount}}</span>
            <span class="pull-right" style="position:absolute;bottom:15px;right:15px">x{{o.quiantity}}</span>
            <!--  -->
          </div>
          <a class="big-btn red-btn right-action" v-show="showEdit" @click.prevent="deleteOrder(o.key)">删除</a>
          <!-- </div> -->
        </div>
      </label>
    </div>
    <!-- <checklist :options="orderListOptions" v-model="selectedOrders"></checklist> -->
    <div style="position:fixed;width:100%;z-index:400;bottom:46px">
      <div style="position:absolute;width:100%;text-align:center;background-color:#fff;bottom:0px">
        <span class="amount" style="line-height:50px;font-size:16px;">合计：  ￥{{totalAmount}}</span>
        <a class="big-btn red-btn pull-right" style="width:30%" @click="checkOut" v-bind:class="{'disable-btn':selectedOrders.length==0}">结算<span v-show="selectedOrders.length>0">({{selectedOrders.length}})</span></a>
      </div>
    </div>
  </div>
</template>
<script>
import {
  Group,
  TransferDom,
  Checklist,
  Cell,
  XButton
} from 'vux'
import utils from '@/mixins/utils'
import _ from 'underscore'
import popupAddress from '@/components/sub/popupAddress.vue'
export default {
  mixins: [utils],
  directives: {
    TransferDom
  },
  components: {
    Group,
    Checklist,
    Cell,
    popupAddress,
    XButton
  },
  data() {
    return {
      showEdit: false,
      orders: [],
      loadingData: false,
      selectedOrders: [],
      eb: require('@/assets/img/e.jpg')
    }
  },
  created() {
    this.loadOrders();
  },
  methods: {
    loadOrders() {
      this.loadOrders = true;
      var orderIds = this.$route.params.orderIds;
      var vm = this;
      var url = this.apiServer + 'zz/GetShoppingCart';
      var data = { openId: this.$store.state.bn.openId }
      if (orderIds) {
        url = this.apiServer + 'zz/GetShoppingCartByOrderIds';
        data = { orderIds: orderIds }
      }
      this.$http.post(url, data)
        .then(res => {
          vm.loadOrders = false;
          vm.orders = res.data;
          vm.selectedOrders = _.pluck(vm.orders, 'OrderId');
        });
    },
    checkOut() {
      var vm = this;
      var selectedAddress = this.$refs.pickAddress.selectedAddress;
      if (this.selectedOrders.length == 0) {

        return
      }
      if (selectedAddress == undefined || selectedAddress.AddressId == undefined) {
        this.$vux.toast.show({
          text: '请填写收货地址~~',
          type: 'cancel'
        });
        return
      };
      var url = this.apiServer + 'zz/PlaceOrder';
      var data = {
        orderIds: this.selectedOrders,
        addressId: selectedAddress.AddressId,
        openId: this.$store.state.bn.openId
      };
      this.$http.post(url, data)
        .then(res => {
          var r = res.data;
          vm.doPayment(r,
            vm.checkout_ok,
            vm.checkout_failed)
        }).catch(err => {
          vm.checkout_failed();
        });
    },
    checkout_ok() {
      // this.$vux.toast.show({
      //   text: '支付成功',
      //   type: 'success'
      // });
      this.loadOrders();
      // this.loadOrders();
      //todo goTo
    },
    checkout_failed() {
      this.$vux.toast.show({
        text: '支付未成功~~~',
        type: 'cancel'
      });
      this.loadOrders();
    },
    deleteOrder(orderId) {
      var vm = this;
      var url = this.apiServer + 'zz/DeleteOrder';
      var data = {
        orderId: orderId
      };
      this.$http.post(url, data)
        .then(res => {
          var index = _.findIndex(vm.orders, function(x) { return x.OrderId == orderId });
          vm.orders.splice(index, 1)
          var index2 = _.findIndex(vm.selectedOrders, function(x) { return x == orderId });
          vm.selectedOrders.splice(index2, 1)
        });
    }
  },
  computed: {
    totalAmount() {
      var vm = this;
      var selectedOrderList = _.filter(this.orders, function(x) { return _.indexOf(vm.selectedOrders, x.OrderId) >= 0 });
      return _.reduce(selectedOrderList, function(meno, x) { return meno + x.TotalAmount }, 0)
    },
    orderListOptions() {
      return _.map(this.orders, function(a) {
        return {
          key: a.OrderId,
          value: a.DesginName,
          preview: a.Preview,
          inlineDesc: '颜色：' + a.Color,
          amount: a.TotalAmount,
          quiantity: a.Quiantity
        }
      });
    }
  }
}

</script>
<style scoped>
.action-bar {
  margin-top: 10px;
  margin-left: 15px;
  height: 20px
}

.action-bar a {
  float: right;
  margin-right: 15px;
  color: blue
}

.right-action {
  position: absolute;
  right: 0px;
  width: 80px;
  text-align: center;
  pointer-events: fill;
  transition: all .5s ease-in;
}

</style>
