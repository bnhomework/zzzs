<template>
  <div>
    <div class="vux-demo">
      <img class="logo">
      <h1></h1>
    </div>
    <div style="width:100%;">
      <image-editor :bgImg="bgImg" :logoImg="logoImg"></image-editor>
    </div>
    <scroller lock-y scrollbar-x>
      <div class="box">
        <div class="box-item" v-for="logo in mylogos"><span>{{' ' + i + ' '}}</span></div>
      </div>
      <div class="box">
        <div class="box-item"><span>{{' ' + i + ' '}}</span></div>
      </div>
    </scroller>
  </div>
</template>
<script>
import { Scroller, Divider, Spinner, XButton, Group, Cell, LoadMore } from 'vux'
import utils from '@/mixins/utils'
import imageEditor from '@/components/sub/imageEditor.vue'
export default {
  mixins: [utils],
  components: {
    imageEditorm,
    Scroller,
    Divider,
    Spinner,
    XButton,
    Group,
    Cell,
    LoadMore
  },
  data() {
    return {
      bgImg: '/static/a.png',
      logoImg: '/static/b.png',
      mylogos: [],
    }
  },
  created() {},
  methods: {

  }
}
</script>
<style scoped>
.box {
  height: 100px;
  position: relative;
  width: 1490px;
}
.box-item {
  width: 200px;
  height: 100px;
  background-color: #ccc;
  display:inline-block;
  margin-left: 15px;
  float: left;
  text-align: center;
  line-height: 100px;
}
.box-item:first-child {
  margin-left: 0;
}
</style>
