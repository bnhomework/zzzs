<template>
  <div class="router-view">
    <div class="topImg">
      <img src="">
    </div>
    <div class="functions">
      <grid :row="3">
        <grid-item link="/component/cell" :label="xxxx">
          <span slot="icon" class="xx">&#xe664;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" :label="xxxx">
          <span slot="icon" class="xx">&#xe664;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick">
          <span slot="icon" class="xx">&#xe664;</span>
          <span slot="label">{{ xxxx }}</span>
        </grid-item>
        <grid-item link="/component/cell" :label="xxxx">
          <span slot="icon" class="xx">&#xe664;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" :label="xxxx">
          <span slot="icon" class="xx">&#xe664;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick">
          <span slot="icon" class="xx">&#xe664;</span>
          <span slot="label">{{ xxxx }}</span>
        </grid-item>
      </grid>
      <br>
      <grid>
        <grid-item link="/component/cell" :label="xxxx">
          <span slot="icon" class="xx">&#xe664;</span>
        </grid-item>
        <grid-item :link="{ path: '/component/cell'}" :label="xxxx">
          <span slot="icon" class="xx">&#xe664;</span>
        </grid-item>
        <grid-item link="/component/cell" @on-item-click="onItemClick">
          <span slot="icon" class="xx">&#xe664;</span>
          <span slot="label">{{ xxxx }}</span>
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
