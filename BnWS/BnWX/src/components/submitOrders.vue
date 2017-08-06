<template>
  <div style="width:100%">
  <popup-address ref="pickAddress"></popup-address>
    <group>
      <cell :value="item.dist" :link="{path:'/shop/'+item.shopId}" v-for="item in orders" :key="item.shopId">
        <img slot="icon" width="100" style="display:block;margin-right:5px;" :src="getImgSrc(item.imgUrl)">
        <span slot="title">{{item.shopName}}</span>
        <span slot="inline-desc">{{item.description}}</span>
      </cell>
    </group>
    <div class="bottom-fix">
    	<span class="amount" style="line-height:50px;font-size:16px">合计：  ￥{{totalAmount}}</span>
    	<a class="big-btn red-btn pull-right" style="width:30%" @click="checkOut">提交</a>
    </div>
  </div>
</template>
<script>
import { Group, Cell } from 'vux'
import utils from '@/mixins/utils'
import popupAddress from '@/components/sub/popupAddress.vue'
export default {
  mixins: [utils],
  components: {
    Group,
    Cell,popupAddress
  },
  data(){
  	return {
  		orders:[],
  		addressList:[]
  	}
  },
  created(){
    var orderIds=this.$route.params.ordersIds;
  	this.loadOrders(orderIds);
  },
  methods:{
  	loadOrders(orderIds){

  	},
  	checkOut(){
      var selectedAddress=this.$ref.pickAddress.selectedAddress;
      if(selectedAddress==undefined||selectedAddress.AddressId==undefined){
        this.$vux.toast.show({
            text: '请填写收货地址~~',
            type: 'cancel'
          });
        return
      }
  	}
  },
  computed:{
  	totalAmount(){
  		return 100;
  	}
  }
}

</script>
