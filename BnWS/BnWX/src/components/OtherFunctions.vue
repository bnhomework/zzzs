<template>
  <div class="router-view">
  <div id="otherfunctions">
    <div class="top-warp">
      <img :src="getImgSrc(this.$store.state.bn.userInfo.Avatar)">
      <div class="uname">{{this.$store.state.bn.userInfo.UserName}}</div>
    </div>
    <div class="functions">
      <grid :rows="4">
        <grid-item link="/component/cell" label="我的设计">
          <span slot="icon" class="bn-icon">&#xe60b;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" label="我的收藏">
          <span slot="icon" class="bn-icon">&#xe623;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="购物车">
          <span slot="icon" class="bn-icon">&#xe665;</span>
        </grid-item>
        <grid-item link="/component/cell" label="订单">
          <span slot="icon" class="bn-icon">&#xe637;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" label="地址">
          <span slot="icon" class="bn-icon">&#xe621;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="消息">
          <span slot="icon" class="bn-icon">&#xe895;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="分享">
          <span slot="icon" class="bn-icon">&#xe6a0;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="联系客服">
          <span slot="icon" class="bn-icon">&#xe619;</span>
        </grid-item>
      </grid>
      <br>
      <grid :rows="4">
        <grid-item label="">
          <span slot="icon" class="bn-icon"></span>
          <span slot="label">&nbsp;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" label="意见反馈">
          <span slot="icon" class="bn-icon">&#xe676;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="关于我们">
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
      xxxx:'dddd'

    }
  },
  methods:{
  	onItemClick(){

  	}
  }
}
</script>
<style scoped>
#otherfunctions{
}
.top-warp{
  background-color: #33CCCC;
  text-align: center;
  padding-bottom: 40px;
}
.top-warp img {
  padding: 10px;
  width: 40%;
  border-radius: 400px
}
.top-warp .uname{
  font-size: 20px;
  font-weight: bold;
  color: #555555;
}
.functions{
  /*background-color: #ffffff;*/
	/*position: fixed;*/
	width: 100%;
	/*bottom: 56px;*/
}
</style>
