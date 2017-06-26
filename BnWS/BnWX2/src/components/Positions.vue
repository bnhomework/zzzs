<template>
  <div>
    <div style="text-align:center;font-size:20px;color:#5d5d5d">
      <div>{{deskName}}</div>
    </div>
    <div>
      <desk :v="deskPositionDetail" @SelectedPostionChanged="function(val){selectedPositions=val}" ref="currentDesk"></desk>
    </div>
    <group>
      <div style="text-align:right;padding:15px">已位选 {{numberOfPositions}} 个位置 </div>
    </group>
    <group>
      <div style="text-align:right;padding:15px">合计:￥{{totalAmount}}</div>
    </group>
    <flexbox style="margin-top: 1.17647059em">
      <flexbox-item>
        <x-button @click.native="$router.go(-1)" type="warn">取消</x-button>
      </flexbox-item>
      <flexbox-item>
        <x-button @click.native="book" type="primary" :disabled="numberOfPositions==0">选好了</x-button>
      </flexbox-item>
    </flexbox>
    <!--  <div style="width:100%">
      <div style="margin:15px">
        <x-button @click.native="book" type="primary" :disabled="numberOfPositions==0">选好了</x-button>
        <x-button @click.native="$router.go(-1)" type="warn">取消</x-button>
      </div>
    </div> -->
  </div>
</template>
<script>
import {
  Group,
  Cell,
  Swiper,
  Datetime,
  XButton,
  Grid,
  GridItem,
  Divider,
  Toast,
  XDialog,
  Flexbox,
  FlexboxItem,
  TransferDomDirective as TransferDom
}
from 'vux'
import utils from '@/mixins/utils'
import desk from '@/components/sub/desk.vue'

export default {
  mixins: [utils],
  components: {
    Group,
    Cell,
    Swiper,
    desk,
    Datetime,
    XButton,
    Grid,
    GridItem,
    Divider,
    Toast,
    XDialog,
    Flexbox,
    FlexboxItem
  },
  directives: {
    TransferDom
  },
  data() {
    return {
      deskId: '',
      deskName: '',
      pickDate: this.getCurrentDate(),
      unitPrice: 0,
      deskPositionDetail: {},
      selectedPositions: []
    }
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.pickDate = this.$route.params.pickDate;
      this.pickTime = this.$route.params.pickTime;
      this.deskId = this.$route.params.deskId;
      this.deskName = this.$route.params.deskName;
      this.unitPrice = this.$route.params.unitPrice;
      this.loadDesk();
    },
    loadDesk() {
      this.selectedPositions = [];
      if (this.$refs.currentDesk)
        this.$refs.currentDesk.reset();
      var url = this.apiServer + 'zy/DeskPostions';
      var data = {
        deskId: this.deskId,
        selectedDate: this.pickDate
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          vm.deskPositionDetail = res.data;
        });
    },
    book() {
      var url = this.apiServer + 'zy/PlaceOrder';
      var data = {
        orderInfo: {
          DeskId: this.deskId,
          pickDate: this.pickDate,
          pickTime: this.pickTime,
          CustomerOpenId: this.$store.state.bn.openId,
          Positions: this.selectedPositions
        }
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          var r = res.data;
          if (r.Success) {
            vm.doPayment(r)
          }
          else {
            vm.$vux.toast.show({
              text: '出错啦~~',
              type: 'cancel'
            })
          }
          vm.loadDesks();
        }).catch(err => {
          vm.$vux.toast.show({
            text: '出错啦~~',
            type: 'cancel'
          })
          vm.loadDesk();
        });
    },
    // doPayment(order) {
    //   var vm = this;
    //   this.$wechat.chooseWXPay({
    //     appId: order.appId,
    //     timestamp: order.timeStamp,
    //     nonceStr: order.nonceStr,
    //     package: order.package,
    //     signType: order.signType,
    //     paySign: order.paySign,
    //     success: function(res) {
    //       if (res.errMsg == "chooseWXPay:ok") {
    //         vm.$vux.toast.show({
    //           text: '支付成功！'
    //         })

    //       }
    //       else {
    //         vm.$vux.toast.show({
    //           text: '支付失败！',
    //           type: 'cancel'
    //         })
    //       }
    //     }

    //   });
    // },
    gotoOrderCompleted(orerId) {
      this.$router.push({
        name: 'orders'
      });
    }
  },
  computed: {
    totalAmount() {
      return this.unitPrice * this.numberOfPositions;
    },
    numberOfPositions() {
      if (this.selectedPositions)
        return this.selectedPositions.length;
      else
        return 0
    }
  }
}
</script>
<style>
</style>
