<template>
  <div v-transfer-dom>
    <popup v-model="showmodel" is-transparent>
      <div style="width: 100%;background-color:#fff;height:300px;margin:0 auto;">
        <div style="font-size:12px;padding-left:5px;">
          <div class="preview" style="padding-top:5px;border-bottom:1px solid #f5f5f5">
            <img :src="design.Preview1" width="15%" style="border:1px solid #e5e5e5">
            <div style="float:right;text-align:left;width:77%">{{design.Name}}
              <div>
                <span class="amount" style="font-size:14px">￥{{design.UnitPrice}}</span>
              </div>
            </div>
          </div>
          <div>
            <div style="padding-left:15px">颜色:</div>
            <div v-for="c in design.Colors" class="option" style="margin:5px" @click="onPickColor(c)" v-bind:class="{active:c==color}">{{c}}</div>
          </div>
          <div>
            <x-number :min="1" :value="quantity" title="数量:"></x-number>
          </div>
        </div>
        <div style="width: 100%;text-align:center;position:fixed;bottom:0px">
          <a class="big-btn orange-btn vice-btn" style="width: 100%;" @click="handleAction">{{actionName}}</a>
        </div>
      </div>
    </popup>
  </div>
</template>
<script>
import {
  Toast,
  TransferDom,
  Popup,
  XNumber
} from 'vux'
import utils from '@/mixins/utils'
export default {
  mixins: [utils],
  directives: {
    TransferDom
  },
  components: {
    Toast,
    Popup,
    XNumber
  },
  props: {
    design: { type: Object, default: {} },
    showmodel: {
      type: Boolean,
      default: false
    },
    action: { type: Number, default: 0 }
  },
  data() {
    return {
      color: '',
      quantity: 1,
      categroyInfo: {}
    }
  },
  created() {
    this.init();
  },

  methods: {
    init() {},
    onPickColor(c) {
      console.log(c)
      this.color = c;
    },
    handleAction() {

      if (this.color == '') {
        this.$vux.toast.show({
          text: '请选择颜色',
          type: 'cancel'
        });
        return;
      }
      if (this.quantity < 1) {
        this.$vux.toast.show({
          text: '请填写数量',
          type: 'cancel'
        });
        return;
      }
      var vm = this;
      var url = this.apiServer + 'zz/AddToCart';
      var data = {
        orderInfo: {
          Color:vm.color,
          Quiantity:vm.quantity,
          CustomerId:vm.$store.state.bn.openId,
          DesignId:vm.design.Id,
        }
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          if (vm.action == 0) {
            vm.addToCart(res.data);
          } else {
            vm.placeOrder(res.data)
          }
        });
    },
    placeOrder(orderId) {
      var vm = this;
      var orderIds = [];
      orderIds.push(orderId);
      vm.$router.push({
        name: 'submitOrders',
        params: { orderIds: orderIds }
      });
    },
    addToCart() {
      this.$vux.toast.show({
        text: '已加入购物车',
        type: 'success'
      });
      this.hide();
    },
    hide(){
      this.$emit("on-showmodel-change",false)
    }
  },
  computed: {
    actionName() {
      if (this.action == 0) {
        return '加入购物车';
      } else {
        return '立即下单'
      }
    }
  },
  mounted() {

  },
  destory() {}
}

</script>
<style scoped>


</style>
