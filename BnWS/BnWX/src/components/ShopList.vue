<template>
  <div>
    <div class="vux-demo">
      <img class="logo" src="../assets/vux_logo.png">
      <h1>{{this.$store.state.bn.openId}}</h1>
    </div>
    <group title="cell demo">
      <cell title="Vux" :value="item.dist" :link="{path:'/shop/'+item.shopId}" v-for="item in shops">
        <img slot="icon" width="100" style="display:block;margin-right:5px;" :src="getImgSrc(item.imgUrl)">
        <span slot="title">{{item.name}}</span>
        <span slot="inline-desc">{{item.description}}</span>
      </cell>
    </group>
  </div>
</template>

<script>
import { Group, Cell } from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins:[utils],
  components: {
    Group,
    Cell
  },
  data () {
    return {
      shops:[],
      msg: 'Hello World!'
    }
  },
  created(){
    this.init();
  },
  methods:{
    init(){
      var openId=this.$route.params.openId;
      if(openId!=undefined&&openId!=''){
        this.$store.commit("updateOpenId",{openId:this.$route.params.openId})
      }
      this.loadShops();
    },
    loadShops(){
      var url=this.apiServer+'zy/shops'
      var data={condition:{}};
      var vm=this;
      this.$http.post(url,data).then(res=>{
        this.shops=res.data;
      });
      // this.shops=[{shopId:'1',name:'ac',imgUrl:'',description:'111 222 333',dist:'100m'},
      // {shopId:'2',name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      // {shopId:'3',name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      // {shopId:'1',name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      // {shopId:'1',name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      // {shopId:'1',name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},]
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
