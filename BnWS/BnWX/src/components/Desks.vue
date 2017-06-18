<template>
  <div>
    <h2>{{shopName}}(<span>{{pickDate}}</span>)</h2>
    <divider></divider>
    <group-title></group-title>
    <div style="margin-bottom: 30px">
      <grid :rows="2">
        <grid-item v-for="(d,i) in shopDesks" :key="i">
        <div @click="pickDesk(d)">
          <desk :v="d" ></desk>
        </div>
        </grid-item>
      </grid>      
    </div>
    <!-- <div v-transfer-dom>
      <x-dialog v-model="showPickPositions" class="dialog-demo" hide-on-blur :dialog-style="{'max-width': '100%', width: '100%', height: '100%', 'background-color': '#fbf9fe'}">
        
              <group>
          <div style="padding:15px">
            <desk :v="selectedDesk" @positionsSelected="book" @SelectedPostionChanged="function(val){selectedPositions=val}"></desk>
          </div>
            </group>
            <div style="position:fixed;bottom:1px;width:100%">
              <group >
                <div style="text-align:right;padding:15px">已位选 {{numberOfPositions}} 个位置 </div>
              </group>
              <group>
                <div style="text-align:right;padding:15px">合计:￥{{totalAmount}}</div>
              </group>
              <div style="margin:15px">
              <x-button @click.native="book" type="primary">选好了</x-button>
              <x-button @click.native="showPickPositions=false" type="warn">取消</x-button></div>
            </div>
        
      </x-dialog>
    </div> -->
    <toast v-model="showToastMessage" type="text" :time="800" is-show-mask :text="toastMessage" position="bottom"></toast>
    
  </div>
</template>

<script>
import { Group, Cell,Swiper,Datetime ,XButton,Grid, GridItem,Divider,Toast,XDialog, TransferDomDirective as TransferDom  } from 'vux'
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
    XDialog
  },
  directives: {
    TransferDom
  },
  data() {
    return {
      shopId: '',
      shopName: '',
      pickDate: this.getCurrentDate(),
      shopDesks: [],
      showPickPositions: false,
      selectedDesk: undefined,
      selectedPositions: [],
      toastMessage: '',
      showToastMessage: false
    }
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.pickDate = this.$route.params.pickDate;
      this.shopId = this.$route.params.shopId;
      this.shopName = this.$route.params.shopName;
      this.loadDesks();
    },
    loadDesks() {
      var url = this.apiServer + 'zy/ShopDesks';
      var data = {
        shopId: this.shopId,
        selectedDate: this.pickDate
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          this.shopDesks = res.data;
        });
    },
    pickDesk(desk) {
      this.selectedDesk = desk;
      this.showPickPositions = true;
      this.$router.push({
                name:'deskPositions',
                params: {
                    deskId: desk.deskId, 
                    pickDate: this.pickDate,
                    deskName:desk.deskName,
                    unitPrice:desk.unitPrice
                }});
    },
    book() {
      var url = this.apiServer + 'zy/PlaceOrder';
      var data ={orderInfo: {
        DeskId: this.selectedDesk.deskId,
        pickDate: this.pickDate,
        CustomerOpenId: this.$store.state.bn.openId,
        Positions: this.selectedPositions
      }};
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          var r = res.data;
          if (r.Success) {
            vm.doPayment(r)
          } else {
            vm.toastMessage = r.Message || "出错啦~~";
            vm.showToastMessage = true;

          }
          vm.loadDesks();
        }).catch(err => {
          console.log('--order failed-')
          vm.toastMessage = "出错啦~~";
          vm.showToastMessage = true;
          vm.loadDesks();
        });
    },
    doPayment(order) {
      var vm = this;
      this.$wechat.chooseWXPay({
        appId: order.appId,
        timeStamp: order.timeStamp,
        nonceStr: order.nonceStr,
        package: order.package,
        signType: order.signType,
        paySign: order.paySign,
        success: function(res) {
          if (res.errMsg == "chooseWXPay:ok") {
            vm.toastMessage = "支付成功！";
            vm.showToastMessage = true;
            //todo goto my orders
          } else {
            vm.toastMessage = "支付失败！";
            vm.showToastMessage = true;
          }
        }

      });
    }
  },
  computed: {
    totalAmount() {
      if (this.selectedDesk)
        return this.selectedDesk.UnitPrice * this.numberOfPositions;
      else
        return 0
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
