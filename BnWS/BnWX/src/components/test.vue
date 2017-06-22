<template>
  <div>
    <div class="vux-demo">
      <img class="logo" >
      <h1></h1>
    </div>
    <div style="width:400px;height:400px">
    <image-editor :bgImg="bgImg" :logoImg="logoImg"></image-editor>
      
    </div>
  </div>
</template>
<script>
import { Group, Cell } from 'vux'
import utils from '@/mixins/utils'
import imageEditor from '@/components/sub/imageEditor.vue'
export default {
  mixins: [utils],
  components: {
  imageEditor
  },
  data() {
    return {
      bgImg:'/static/a.png'
      ,logoImg:'/static/b.png'
    }
  },
  created() {
  },
  methods: {
    
  }
}
</script>
<style scoped>
.vux-demo {
  text-align: center;
}

.logo {
  width: 100%;
  height: 187px;
}
</style>
