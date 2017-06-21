<template>
  <div>
    <el-amap vid="bnmap" :zoom="zoom" :center="center" class="bnmap">
      <el-amap-marker :position="center" visible="true" draggable="false"></el-amap-marker>
    </el-amap>
  </div>
</template>
<script>
import { Group, Cell, Swiper } from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins: [utils],
  components: {
    Group,
    Cell,
    Swiper
  },
  data() {
    return {
      zoom: 14,
      center: [121.5273285, 31.21515044],
      plugin: [{
        pName: 'Geolocation',
        events: {
          init(o) {
            o.getCurrentPosition((status, result) => {
              if (result && result.position) {
                self.lng = result.position.lng;
                self.lat = result.position.lat;
                self.center = [self.lng, self.lat];
                self.$nextTick();
              }
            });
          }
        }
      }]
    };
  },
  created() {
    this.init();
  },
  methods: {

    init() {
      console.log(this.center)
      var lng = this.$route.params.longitude
      var lat = this.$route.params.latitude

      this.center = [lng, lat];
      console.log(this.center)
    }
  }
}
</script>
<style>
.bnmap {
  height: 300px;
  min-height: 300px;
}
</style>
