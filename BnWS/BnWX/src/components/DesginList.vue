<template>
  <div style="width:100%;">
    <div v-for="item in designs">
      <div class="desgin-warp">
        <div class="preview-warp" @click.stop="goTo({name:'Desgin',params:{designId:item.DesignId}})">
          <div class="desgin-header" @click.prevent.stop="setIsPublic(item,!item.IsPublic)">
            <span v-show="!item.IsPublic"  class="bn-icon">&#xe6c9;</span>
            <span v-show="item.IsPublic"  class="bn-icon">&#xe6ca;</span>
            {{item.IsPublic?'已公开':'未公开'}}
          </div>
          <img :src="getImgSrc(item.Preview1)">
          <div style="display:inline-block;vertical-align:top;">
            <div class="content-1">{{item.Name}}</div>
            <div style="font-size:10px;color:#5e5e5e">
              <span v-for="tag in desginTags(item.Tags)" class="tag content-2">{{tag}}</span>
            </div>
            <div v-if="item.IsPublic" ><span class="bn-icon" style="font-size:14px;margin-right:5px">&#xe60e;</span>{{item.Follows||0}}</div>
            <div><span class="amount">￥{{item.UnitPrice}}</span></div>
          </div>
          <div class="btn-order" @click="">开始订购</div>
        </div>
      </div>
    </div>
    <div v-show="loadingData==false&&designs.length==0" style="text-align:center;margin-top:40%">
      您还没有创业设计,快去创建吧....
      
      <br/>
      <div></div>
      <br/>
      <x-button mini plain  type="primary" link="/DesginStep1">去设计页面</x-button>
    </div>
    <div id="shareit" v-show="showShare" @click="showShare=false">
      <img class="arrow" :src="shareIcon">
      <a href="#" id="follow"></a>
    </div>
  </div>
</template>
<script>
import {
  Toast,
  XButton
} from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins: [utils],
  components: {
    Toast,
    XButton
  },
  data() {
    return {
      showShare: false,
      shareIcon: require('@/assets/img/share.png'),
      loadingData:false,
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
      vm.loadingData=true;
      this.$http.post(url, data)
        .then(res => {
          vm.designs = res.data;
          vm.loadingData=false;
        });
    },
    desginTags(t) {
      var tags = [];
      if (t) {
        tags = t.split(',');
      }
      return tags;
    },
    setIsPublic(desgin, ispublic) {
      var url = this.apiServer + 'zz/SetIsPublic';
      var data = {
        designId: desgin.DesignId,
        ispublic: ispublic
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          desgin.IsPublic = ispublic;
        });
    },
    share(orderId, stype) {
      stype = stype || 1;
      var url = this.apiServer + 'zy/GetShareOrderInfo';
      var data = {
        orderId: orderId
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          vm.showShare = true;
          vm.shareAppMessage(res.data)
          vm.shareTimeline(res.data)
        });
    },
    shareAppMessage(oinfo) {
      var vm = this;
      var p = {
        title: `一群高颜值的狼队友正在组局，[12缺${12-oinfo.Booked}]点击立即加入`,
        desc: `【${oinfo.OrderDate2}】 【${oinfo.ShopName}】 【${oinfo.DeskName}】,快来吧！`, // 分享描述

        link: `${vm.apiServer}wx/login`,
        // link:`${vm.apiServer}public/index.html#/share/${oinfo.ShopName}/${oinfo.DeskName}/${oinfo.OrderDate2}/${oinfo.Booked}` ,
        imgUrl: `${vm.apiServer}/Upload/sharelogo.png`
      };
      vm.$wechat.onMenuShareAppMessage(p);
    },
    shareTimeline(oinfo) {
      var vm = this;
      vm.$wechat.onMenuShareTimeline({
        title: `一群高颜值的狼队友正在组局，[12缺${12-oinfo.Booked}]点击立即加入!【${oinfo.OrderDate2}】 【${oinfo.ShopName}】 【${oinfo.DeskName}】,快来吧！`, // 分享标题
        link: `${vm.apiServer}wx/login`,
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
/*begin bottom*/

.bottom-fix {
  display: block;
  z-index: 100;
  position: fixed;
  left: 0;
  bottom: 47px;
  width: 100%;
  text-align: center;
  background-color: #fff;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  font-size: 0
}

.responsive-wrapper {
  margin: 0 auto;
}

.responsive-wrapper a {
  cursor: pointer;
}

.mini-btn-2-1 {
  float: left;
  width: 120px;
  font-size: 10px;
  text-align: center;
}

.mini-btn-2-1 a {
  width: 60px;
  min-width: 60px;
  line-height: 50px;
  position: relative;
  ;
  float: left;
}

.mini-btn-2-1 a i {
  font-family: 'bn-icon';
  font-size: 15px;
}

.mini-btn-2-1 a span {
  position: absolute;
  line-height: normal;
  ;
  left: 0px;
  bottom: 5px;
  width: 100%;
}

.big-btn-2-1 {
  font-size: 0;
  overflow: hidden;
  text-align: center;
  line-height: 50px;
}

.big-btn-2-1 .big-btn {
  width: 50%;
}

.big-btn {
  height: 50px;
  line-height: 50px;
  font-size: 16px;
  padding: 0;
  border: none;
  display: inline-block;
  vertical-align: top;
}

.orange-btn {
  background: #f85;
  color: #fff;
  position: relative;
}

.red-btn {
  background: #f44;
  color: #fff;
  position: relative;
}


/*end bottom*/

.btn-order {
  position: absolute;
  bottom: 10px;
  right: 5px;
  background: #f44;
  color: #fff;
  padding: 4px;
}

.desgin-warp {
  background-color: transparent;
  padding: 2px 5px;
}

.desgin-header {
  position: absolute;
  top: 5px;
  right: 5px;
  color: #5e5e5e;
  padding: 4px;
}
.desgin-header span{
  font-size: 14px;
}
.preview-warp {
  padding: 5px;
  position: relative;
  border-bottom: 1px solid #e5e5e5;
}

.preview-warp img {
  width: 30%;
  min-height: 80px;
  /*border: 1px solid #bbbbbb;*/
  background-color: #ffffff;
}

#shareit {
  -webkit-user-select: none;
  position: absolute;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.85);
  text-align: center;
  top: 0;
  left: 0;
  z-index: 105;
}

#shareit img {
  max-width: 70%;
}

.arrow {
  position: absolute;
  right: 10%;
  top: 5%;
}

#follow {
  width: 100%;
  height: 50px;
  line-height: 50px;
  text-align: center;
  text-decoration: none;
  font-size: 18px;
  color: white;
  float: left;
  margin-top: 400px;
}

</style>
