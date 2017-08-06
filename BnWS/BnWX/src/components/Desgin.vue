<template>
  <div style="width:100%">
    <div>
      <div></div>
      <img :src="design.Preview1" v-show="isFront">
      <img :src="design.Preview2" v-show="!isFront">
    </div>
    <div style="padding:15px; background-color:#ffffff;">
      <div>
        <span class="amount">￥{{design.UnitPrice}}</span>
        <span style="float:right;padding-right:5px" class="content-1">{{design.Name}}</span>
      </div>
      <div>
        <span class="tag content-2" v-for="t in desginTags">
          {{t}}
        </span>
        <span style="float:right;padding-right:5px" class="content-2">设计师：{{design.Designer}}</span>
      </div>
    </div>
    <br/>
    <div id="shareit" v-show="showShare" @click="showShare=false">
      <img class="arrow" :src="shareIcon">
      <a href="#" id="follow"></a>
    </div>
    <div class="bottom-fix">
      <div class="responsive-wrapper">
        <div class="mini-btn-2-1">
          <!-- <a href="javascript:;" class="js-im-icon new-btn service"><i>&#xe665;</i><span>test</span></a> -->
          <a class="new-btn buy-cart">
            <i>&#xe623;</i><span class="desc">收藏</span>
          </a>
          <a class="new-btn buy-cart" style="">
            <i>&#xe665;</i><span class="desc">购物车</span>
          </a>
        </div>
        <div class="big-btn-2-1">
          <a class="big-btn orange-btn vice-btn" @click="onAddCard">加入购物车</a>
          <a class="big-btn red-btn main-btn" @click="onPlaceOrder">立即下单</a>
        </div>
      </div>
    </div>
    <popup-order-info :showmodel="showCardModel" :design="design" :action="action" @on-showmodel-change="(v)=>{showCardModel=v}"></popup-order-info>
  </div>
</template>
<script>
import {
  Toast,
  XButton,
  Popup,
  Group,
  TransferDom,
} from 'vux'
import utils from '@/mixins/utils'
import popupOrderInfo from '@/components/sub/popupOrderInfo.vue'

export default {
  mixins: [utils],
  directives: {
    TransferDom
  },
  components: {
    Toast,
    XButton,
    Popup,
    Group,
    popupOrderInfo
  },
  data() {
    return {
      showShare: false,
      isFront: true,
      shareIcon: require('@/assets/img/share.png'),
      design: {},
      colors: ['a','b','c'],
      designId: undefined,
      showCardModel: false,
      action:0
    }
  },
  created() {
    this.designId = this.$route.params.designId;
    this.init();
  },
  methods: {
    init() {
      this.loadDesign();
    },
    switchSide() {
      this.isFront = !this.isFront;
    },
    loadDesign() {
      var url = this.apiServer + 'zz/GetDesign';
      var data = {
        designId: this.designId
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          vm.design = res.data;
        });
    },
    onAddCard(){
      this.showCardModel=true;
      this.action=0;
    },
    onPlaceOrder(){
      this.showCardModel=true;
      this.action=1;
    }
    ,
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
    desginTags() {
      var tags = [];
      if (this.design.Tags) {
        tags = this.design.Tags.split(',');
      }
      return tags;
    }
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

/*.big-btn {
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
}*/


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

.desgin-header span {
  float: right;
  margin-right: 5px;
  font-size: 14px;
  color: #5e5e5e
}

.preview-warp {
  padding: 5px;
  position: relative;
  border-bottom: 1px solid #e5e5e5;
}

.preview-warp img {
  width: 30%;
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
