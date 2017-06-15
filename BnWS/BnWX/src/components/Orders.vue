<template>
  <div>
    <div class="vux-demo">
      <img class="logo" src="../assets/vux_logo.png">
      <h1> </h1>
    </div>
    <group title="cell demo">
      <cell title="Vux" :value="item.dist" is-link v-for="item in shops">
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
      this.loadShops();
    },
    loadShops(){
      this.shops=[{name:'ac',imgUrl:'',description:'111 222 333',dist:'100m'},
      {name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      {name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      {name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      {name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},
      {name:'abc',imgUrl:'uploads/product/328716.jpg',description:'111 222 333',dist:'100m'},]
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
