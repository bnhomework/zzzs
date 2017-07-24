<template>
  <div class="router-view">
    <div class="topImg">
      <img src="">
    </div>
    <div class="functions">
      <grid :row="4">
        <grid-item link="/component/cell" label="我的设计">
          <span slot="icon" class="xx">&#xe60b;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" label="我的收藏">
          <span slot="icon" class="xx">&#xe623;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick">
          <span slot="icon" class="xx">&#xe665;</span>
          <span slot="label">{{ 购物车 }}</span>
        </grid-item>
        <grid-item link="/component/cell" label="订单">
          <span slot="icon" class="xx">&#xe637;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" label="地址">
          <span slot="icon" class="xx">&#xe621;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="消息">
          <span slot="icon" class="xx">&#xe895;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="分享">
          <span slot="icon" class="xx">&#xe6a0;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="联系客服">
          <span slot="icon" class="xx">&#xe619;</span>
        </grid-item>
      </grid>
      <br>
      <grid>
        <grid-item link="/component/cell" label="xxxx">
          <span slot="icon" class="xx">&#xe664;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" label="意见反馈">
          <span slot="icon" class="xx">&#xe676;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick" label="关于我们">
          <span slot="icon" class="xx">&#xe618;</span>
        </grid-item>
      </grid>
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
.topImg img {
  width: 100%;
}
.functions{
	position: fixed;
	width: 100%;
	bottom: 56px;
}
</style>
