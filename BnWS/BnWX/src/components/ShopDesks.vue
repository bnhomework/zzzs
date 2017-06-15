<template>
  <div>
    <swiper :list="imgList" auto style="width:100%;margin:0 auto;" height="180px" dots-class="custom-bottom" dots-position="center"></swiper>
    
    {{shopId}}
    <group title="地址">
      <cell :title="shopInfo.address" is-link :link="{name:'shopOnMap',params:{longitude:shopInfo.longitude,latitude:shopInfo.latitude}}">
        <x-icon type="ios-location-outline" slot="icon" size="20"></x-icon>
      </cell>
    </group>
    <group-title>rows = 2</group-title>
    <grid :rows="2">
      <grid-item :label="'ss'" v-for="(d,i) in shopInfo.desks" :key="i">
        <desk :v="d" ></desk>
      </grid-item>
    </grid>
  </div>
</template>

<script>
import { Group, Cell,Swiper } from 'vux'
import utils from '@/mixins/utils'
import desk from '@/components/sub/desk.vue'

export default {
  mixins:[utils],
  components: {
    Group,
    Cell,
    Swiper,
    desk
  },
  data () {
    return {
      shopId:'',
      shopInfo:{}
    }
  },
  created(){
    this.init();
  },
  methods:{
    init(){
      this.shopId=this.$route.params.id
      this.loadShopInfo();
    },
    loadShopInfo(){
      this.shopInfo={address:'xxx xxx xxx xxx',longitude:'121.5273285',latitude:'31.21515044',detailDescription:'',
      // imgs:['uploads/product/328716.jpg','uploads/product/328716.jpg','uploads/product/328716.jpg'],
       desks:[{},{},{},{},{},{},{},{},{}]
       }
    }
  },
  computed:{
    imgList(){
      var imgs=this.shopInfo.imgs;
      if(!imgs)
        return []
      var self=this;
      var result= imgs.map((x)=>{return {
  url: 'javascript:',
  img: self.getImgSrc(x)
} });
      return result
    }
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
</style>
