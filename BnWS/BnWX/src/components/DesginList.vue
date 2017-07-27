<template>
  <div style="width:100%;">
    <div v-for="item in designs">
      <br>
      <div class="desgin-warp">
        <div class="desgin-header">
          <x-button plain="true" v-show="!item.IsPublic" mini="true" @click.native="setIsPublic(item.DesginId,1)">公开</x-button>
          <x-button plain="true" v-show="item.IsPublic" mini="true" @click.native="setIsPublic(item.DesginId,0)">不公开</x-button>
          <span>{{item.Name}}</span>
        </div>
        <div class="preview-warp">
          <img :src="item.Preview1">
          <img :src="item.Preview2">
        </div>
        <div>
          <div>开始订购</div>
        </div>
      </div>
    </div>
    <div id="shareit" v-show="showShare" @click="showShare=false">
      <img class="arrow" :src="shareIcon">
      <a href="#" id="follow"></a>
    </div>
  </div>
</template>
<script>
import {
  Toast,XButton
}from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins: [utils],
  components: {
    Toast,XButton
  },
  data() {
    return {
      showShare:false,
      shareIcon: require('@/assets/img/share.png'),
      designs: []
    }
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.loadDesigns();
    },
    onItemClick(v) {
      if (v == 0) {
        this.historyOrder = false;
      } else {
        this.historyOrder = true;
      }
    },
    loadDesigns() {
      var url = this.apiServer + 'zz/GetDesginList';
      var data = {
        openId: this.$store.state.bn.openId
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          vm.designs = res.data;
        });
    },
    setIsPublic(desgin,ispublic){
      var url = this.apiServer + 'zz/SetIsPublic';
      var data = {
        desginId: desgin.DesginId,
        ispublic:ispublic
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          desgin.IsPublic=ispublic;
        });
    },
    share(orderId,stype){
      stype=stype||1;
       var url = this.apiServer + 'zy/GetShareOrderInfo';
      var data = {
        orderId: orderId
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res=>{       
            vm.showShare=true;
            vm.shareAppMessage(res.data)
            vm.shareTimeline(res.data)
        });
    },
    shareAppMessage(oinfo){
      var vm = this;
      var p={title: `一群高颜值的狼队友正在组局，[12缺${12-oinfo.Booked}]点击立即加入`,
            desc: `【${oinfo.OrderDate2}】 【${oinfo.ShopName}】 【${oinfo.DeskName}】,快来吧！`, // 分享描述

            link:`${vm.apiServer}wx/login`,
            // link:`${vm.apiServer}public/index.html#/share/${oinfo.ShopName}/${oinfo.DeskName}/${oinfo.OrderDate2}/${oinfo.Booked}` ,
            imgUrl: `${vm.apiServer}/Upload/sharelogo.png`
          };
      vm.$wechat.onMenuShareAppMessage(p);
    },
    shareTimeline(oinfo) {
      var vm = this;
      vm.$wechat.onMenuShareTimeline({
        title: `一群高颜值的狼队友正在组局，[12缺${12-oinfo.Booked}]点击立即加入!【${oinfo.OrderDate2}】 【${oinfo.ShopName}】 【${oinfo.DeskName}】,快来吧！`, // 分享标题
        link:`${vm.apiServer}wx/login`,
        // link:`${vm.apiServer}public/index.html#/share/${oinfo.ShopName}/${oinfo.DeskName}/${oinfo.OrderDate2}/${oinfo.Booked}` ,
        imgUrl: `${vm.apiServer}/Upload/sharelogo.png`, // 分享图标
        
      });
    }
  },
  computed: {
    
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
.desgin-warp{
  background-color: #ffffff;
}
.desgin-header span{
  float: right;
  margin-right: 5px;
}
.preview-warp{
  padding:5px;
}
.preview-warp img{
  width: 50%
}

#shareit {-webkit-user-select: none;position: absolute;width: 100%;height: 100%;
  background: rgba(0,0,0,0.85);text-align: center;top: 0;left: 0;z-index: 105;
}
#shareit img { max-width: 70%;}
.arrow {position: absolute; right: 10%;top: 5%;}
#follow{width: 100%;height: 50px;line-height: 50px;text-align: center; text-decoration: none;font-size: 18px;color: white;float: left;margin-top: 400px;}
</style>
