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
      <grid-item v-for="(d,i) in shopDesks" :key="i">
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
      shopInfo:{},
      shopDesks:[],
    }
  },
  created(){
    this.init();
  },
  methods:{
    init(){
      this.shopId=this.$route.params.id
      this.loadShopInfo();
      this.loadDesks(new Date());
    },
    loadShopInfo(){
      var url=this.apiServer+'zy/ShopDetail';
      var data={shopId:this.shopId};
      var vm=this;
      this.$http.post(url,data)
      .then(res=>{
        this.shopInfo=res.data;
      });
    },
    loadDesks(d){
      var url=this.apiServer+'zy/ShopDesks';
      var data={shopId:this.shopId,selectedDate:d};
      var vm=this;
      this.$http.post(url,data)
      .then(res=>{
        this.shopDesks=res.data;
      });
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
