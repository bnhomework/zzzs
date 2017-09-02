<template>
  <div class="router-view">
    <div id="otherfunctions">
      <div class="top-warp">
        <div class="planet-wrap wrap" p-id="231">
          <div class="planet planet-9" p-id="232"></div>
          <div class="planet planet-10" p-id="233"></div>
          <div class="planet planet-11" p-id="234"></div>
          <div class="planet planet-12" p-id="235"></div>
        </div>
        <div style="width:100px;height:100px;margin:0 auto;margin-top:50px">
        <img style="width:100%" :src="getImgSrc(this.$store.state.bn.userInfo.Avatar)"></div>
        <div class="uname">{{this.$store.state.bn.userInfo.UserName}}</div>
      </div>
      <div class="functions">
        <grid :rows="4">
          <grid-item @on-item-click="goTo({name:'DesginList'})" label="我的设计">
            <span slot="icon" class="bn-icon">&#xe60b;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'FavoriteList'})" label="我的收藏">
            <span slot="icon" class="bn-icon">&#xe623;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'shoppingCart'})" label="购物车">
            <span slot="icon" class="bn-icon">&#xe665;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'OrderList'})" label="订单">
            <span slot="icon" class="bn-icon">&#xe637;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'AddressList'})" label="地址">
            <span slot="icon" class="bn-icon">&#xe621;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'DesginList'})" label="消息">
            <span slot="icon" class="bn-icon">&#xe895;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'DesginList'})" label="分享">
            <span slot="icon" class="bn-icon">&#xe6a0;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'DesginList'})" label="联系客服">
            <span slot="icon" class="bn-icon">&#xe619;</span>
          </grid-item>
        </grid>
        <br>
        <grid :rows="4">
          <grid-item label="">
            <span slot="icon" class="bn-icon"></span>
            <span slot="label">&nbsp;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'DesginList'})" label="意见反馈">
            <span slot="icon" class="bn-icon">&#xe676;</span>
          </grid-item>
          <grid-item @on-item-click="goTo({name:'DesginList'})" label="关于我们">
            <span slot="icon" class="bn-icon">&#xe618;</span>
          </grid-item>
          <grid-item label="">
            <span slot="icon" class="bn-icon"></span>
            <span slot="label">&nbsp;</span>
          </grid-item>
        </grid>
      </div>
    </div>
  </div>
</template>
<script>
import {
  Grid,
  GridItem,
  GroupTitle
}
from 'vux'
import utils from '@/mixins/utils'
export default {
  mixins: [utils],
  components: {
    Grid,
    GridItem,
    GroupTitle
  },
  data() {
    return {
      sex: 1,
      selectedColor: '#E2DDDB',
      templates: [],
      xxxx: 'dddd'

    }
  },
  methods: {
    onItemClick() {

    }
  }
}

</script>
<style scoped>
#otherfunctions {}

.top-warp {
  background-color: #090723;
  /*background-color: #33CCCC;*/
  text-align: center;
  padding-bottom: 40px;
  min-height: 180px;
  background: #090723;
  position: absolute;
  width: 100%;
  height: 180px;
  left: 0;
  top: -55px;
  padding-top: 55px;
  overflow: hidden;
  z-index: 200;
}

.top-warp img {
  width: 40%;
  /*border:2px solid #f1f1f1;*/
  border-radius: 400px;

}

.top-warp .uname {
  font-size: 20px;
  font-weight: bold;
  color: #ffffff;
}

.functions {
  /*background-color: #ffffff;*/
  /*position: fixed;*/
  width: 100%;
  /*bottom: 56px;*/
  margin-top: 220px;
  overflow-y: hidden;
}



.planet-wrap {
  position: fixed;
  width: 100%;
  /*height: 100%;*/
  top: 50px;
  left: 0
}

.planet-wrap .planet {
  position: absolute;
  width: 100px;
  height: 100px;
  right: 0;
  top: 0;
  opacity: .3;
  border-radius: 50%
}

.planet-wrap .planet-1 {
  width: 474px;
  height: 474px;
  right: 100px;
  top: -395px;
  background: linear-gradient(90deg, #ff5a25, #ff005a);
  transition: all 1s linear
}

.planet-wrap .planet-2 {
  width: 90px;
  height: 90px;
  right: 100px;
  top: 220px;
  opacity: .1;
  background: linear-gradient(90deg, #ffd000, #f90);
  transition: all .6s linear
}

.planet-wrap .planet-3 {
  width: 60px;
  height: 60px;
  right: 330px;
  top: 395px;
  opacity: .07;
  background: linear-gradient(-90deg, #271e5b, #0d76ef);
  transition: all .4s linear
}

.planet-wrap .planet-8 {
  width: 25px;
  height: 25px;
  right: 445px;
  top: 136px;
  opacity: .07;
  background: linear-gradient(-90deg, #bd4c86, #c864ae);
  transition: all .5s linear
}

.planet-wrap .planet-9 {
  width: 135px;
  height: 135px;
  /*right: 432px;*/
  right: 40px;
  top: -136px;
  opacity: .3;
  background: linear-gradient(0deg, #ff5a25, #ff005a);
  z-index: 999
}

.planet-wrap .planet-10 {
  width: 25px;
  height: 25px;
  right: 278px;
  top: 41px;
  opacity: .3;
  background: linear-gradient(-90deg, #bd4c86, #c864ae)
}

.planet-wrap .planet-11 {
  width: 78px;
  height: 78px;
  right: 577px;
  top: 108px;
  opacity: .3;
  background: linear-gradient(-90deg, #00d5c8, #00b481)
}

.planet-wrap .planet-12 {
  width: 90px;
  height: 90px;
  right: -23px;
  top: 75px;
  opacity: .3;
  background: linear-gradient(-90deg, #271e5b, #0d76ef)
}

</style>
