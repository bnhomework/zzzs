<template>
  <div>
    <tab>
      <tab-item :selected="!historyOrder?'selected':null" @on-item-click="onItemClick(0)">我的预约</tab-item>
      <tab-item :selected="historyOrder?'selected':null" @on-item-click="onItemClick(1)">历史预约</tab-item>
    </tab>
    <group>
      <cell  is-link v-for="item in orders">
        <span slot="title">{{item.ShopName}}</span>
        <span slot="inline-desc">{{item.DeskName}}</span>
      </cell>
      <!-- <cell title="Vux" :value="item.dist" is-link v-for="item in orders">
        <img slot="icon" width="100" style="display:block;margin-right:5px;" :src="getImgSrc(item.imgUrl)">
        <span slot="title">{{item.name}}</span>
        <span slot="inline-desc">{{item.description}}</span>
      </cell> -->
    </group>
  </div>
</template>

<script>
import { Tab, TabItem,Group, Cell } from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins:[utils],
  components: {
    Tab, TabItem,Group,
    Cell
  },
  data () {
    return {
      orders:[],
      historyOrder:false
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
    }
  },
  computed:{
    showOrders(){
      var currentDate=this.getCurrentDate();
      var vm=this;
      this.orders.filter(function(x){
        if(vm.historyOrder){
          return x.OrderDate<currentDate;
        }else{
          return x.OrderDate>=currentDate;
        }
      })
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
