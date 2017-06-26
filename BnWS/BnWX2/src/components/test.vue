<template>
  <div>
    <div style="width:100%;">
      <div @click="switchSide" class="switch" >{{isBackend?'后':'前'}}</div>
      <image-editor v-show="!isBackend" :bgImg="bgImg" :logoImg="logoImg"></image-editor>
      <image-editor v-show="isBackend" :bgImg="bgImg" :logoImg="logoImg"></image-editor>
    </div>
    <div class="tool">
      <div v-show="selectedTab==0">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" @click="openMyImages"><span style="font-size: 70px;font-weight: bold;vertical-align: middle;color: #5d5d5d">+</span></div>
            <div class="box-item" :class="{selected:logo==currentSelectedLogo}" v-for="logo in mylogos" @clcik="setLogo"><span>{{' ' + logo + ' '}}</span></div>
          </div>
        </scroller>
      </div>
      <div v-show="selectedTab==1">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" :class="{selected:s==currentSelectedStyle}" v-for="s in styleList" @click="setStyle"><span>{{' ' + s + ' '}}</span></div>
          </div>
        </scroller>
      </div>
      <tab>
        <tab-item :selected="selectedTab==0" @on-item-click="onItemClick(0)">素材</tab-item>
        <tab-item :selected="selectedTab==1" @on-item-click="onItemClick(1)">款式</tab-item>
        <!-- <tab-item @on-item-click="onItemClick">xxx</tab-item> -->
      </tab>
    </div>
  </div>
</template>
<script>
import { Scroller, Divider, Spinner, XButton, Group, Cell, LoadMore, Tab, TabItem } from 'vux'
import utils from '@/mixins/utils'
import imageEditor from '@/components/sub/imageEditor.vue'
export default {
  mixins: [utils],
  components: {
    imageEditor,
    Scroller,
    Divider,
    Spinner,
    XButton,
    Group,
    Cell,
    LoadMore,
    Tab,
    TabItem
  },
  data() {
    return {
      bgImg: '/static/a.png',
      logoImg: '/static/b.png',
      mylogos: ['a', 'b', 'c', 'c', 'c', 'c'],
      styleList:['','y','z'],
      desgin:{forent:'',backend:'',style:''},
      defaultStyle:{front:'',backend:''},
      defaultlogo:'',
      selectedTab: 0,
      isBackend:false
    }
  },
  created() {},
  methods: {
    initData(){

    },
    loadStyleList(){
      this.styleList.push('/img/tshirt/male/whitefront.png');
      this.styleList.push('/img/tshirt/male/whiteback.png');
    }
    onItemClick(id) {
      this.selectedTab = id;
    },
    openMyImages() {
      var vm=this;
      console.log('xxx')
      this.$wechat.chooseImage({
        count: 1, // 默认9
        sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
        success: function(res) {
          if(res.localIds&&res.localIds.length>0){
            for (var i = 0; i < res.localIds.length; i++) {
              var l=res.localIds[i]
              vm.mylogos.push(l)
            }
          }
        }
      });
    },
    setStyle(s){
      this.$set(this.desgin,'style',s);
    },
    setLogo(l){
      if(this.isBackend){
        this.$set(this.desgin,'backend',l);
      }else{
        this.$set(this.desgin,'forent',l);        
      }
    },
    switchSide(){
      this.isBackend=!this.isBackend;
    }
  },
  computed:{
    bgImg_f(){
      if(this.desgin.style){
        return this.desgin.style.front;
      }
      return this.defaultStyle.front;
    },
    bgImg_b(){
      if(this.desgin.style){
        return this.desgin.style.backend;
      }
      return this.defaultStyle.backend;
    },
    logo_f(){
      if(this.desgin.front){
        return this.desgin.front;
      }
      return defaultlogo;
    },
    logo_b(){
      if(this.desgin.backend){
        return this.desgin.backend;
      }
      return defaultlogo;
    },
    currentSelectedLogo(){
      if(this.isBackend)
        return this.desgin.backend;
      else
        return this.desgin.front;
    },
    currentSelectedStyle(){
      return this.desgin.style;
    }


  }
}
</script>
<style scoped>
.tool {
  position: fixed;
  width: 100%;
  bottom: 43px
}

.box {
  height: 100px;
  position: relative;
  width: 1490px;
}

.box-item {
  width: 100px;
  height: 100px;
  background-color: #ccc;
  display: inline-block;
  margin-left: 15px;
  float: left;
  text-align: center;
  line-height: 100px;
}

.box-item:first-child {
  margin-left: 0;
}
.switch{
position: fixed;
right: 0px;
margin:10px;
padding: 10px; 
font-size: 20px;
line-height: 20px;
border-radius: 30px;
border: solid 1px #5d5d5d
}
.switch:hover{
border: solid 1px #1d1d1d
}
</style>
