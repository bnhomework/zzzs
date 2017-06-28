<template>
  <div>
    <div style="min-height:46px"></div>
    <div style="width:100%;">
      <div @click="switchSide" class="switch">{{isbackend?'前':'后'}}</div>
      <image-editor ref="front" v-show="!isbackend" :bgImg="getImgSrc(bgImg_f)" :logoImg="getImgSrc(logo_f)" :txtLogoText="desgin.frontTxt" :controlElementId="controlElementId"></image-editor>
      <image-editor ref="back" v-show="isbackend" :bgImg="getImgSrc(bgImg_b)" :logoImg="getImgSrc(logo_b)" :txtLogoText="desgin.backTxt" :controlElementId="controlElementId"></image-editor>
    </div>
    <div class="tool">
      <div v-show="selectedTab==0">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" @click="openMyImages"><span style="font-size: 70px;font-weight: bold;vertical-align: middle;color: #5d5d5d">+</span></div>
            <div class="box-item" :class="{selected:logo==currentSelectedLogo}" v-for="logo in mylogos" @click="setLogo(logo)">
              <img :src="getImgSrc(logo)">
            </div>
          </div>
        </scroller>
      </div>
      <div v-show="selectedTab==10">
        <group title="">
          <x-input title="输入文本" v-model="desgin.frontTxt" v-show="!isbackend"></x-input>
          <x-input title="输入文本" v-model="desgin.backTxt" v-show="isbackend"></x-input>
        </group>
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="vux-color-picker box-color">
              <div class="vux-flexbox vux-flex-row">
                <div class="vux-flexbox-item vux-color-box" style="min-width:10px" v-for="c in colors" ><span class="vux-color-item" style=" width: 10px;height:46px" :style="{'background-color':c}" @click="setTextColor(c)"></span></div>
              </div>
            </div>
          </div>
        </scroller>
        <scroller lock-y scrollbar-x>
          <div class="box">
           <div class="box-color" style="min-width:50px;height:46px;width:100px" :style="{'background-color':'#d5d5d5','font-family':f}" v-for="f in fonts" @click="setFonts(f)">创意T恤</div>
          </div>
        </scroller>
      </div>
      <div v-show="selectedTab==20">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" :class="{selected:s==currentSelectedStyle}" v-for="s in styleList" @click="setStyle(s)">
              <!-- <span>{{' ' + s + ' '}}</span> -->
              <img :src="getImgSrc(s.front)">
            </div>
          </div>
        </scroller>
      </div>
      <div v-show="selectedTab==30">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" :class="{selected:s==currentSelectedStyle}" v-for="s in styleList" @click="setStyle(s)">
              <!-- <span>{{' ' + s + ' '}}</span> -->
              <img :src="getImgSrc(s.front)">
            </div>
          </div>
        </scroller>
      </div>
      <tab>
        <tab-item :selected="selectedTab==0" @on-item-click="onItemClick(0)"><span class="bn-icon">&#xe73f;</span> 图片</tab-item>
        <tab-item :selected="selectedTab==10" @on-item-click="onItemClick(10)"><span class="bn-icon">&#xe627;</span> 文字</tab-item>
        <tab-item :selected="selectedTab==20" @on-item-click="onItemClick(20)"><span class="bn-icon">&#xe608;</span> 模板</tab-item>
        <!-- <tab-item :selected="selectedTab==30" @on-item-click="onItemClick(30)"><span class="bn-icon">&#xe664;</span> 款式</tab-item> -->
        <!-- <tab-item @on-item-click="onItemClick">xxx</tab-item> -->
      </tab>
    </div>
  </div>
</template>
<script>
import {
  Scroller,
  Divider,
  Spinner,
  XButton,
  Group,
  Cell,
  LoadMore,
  Tab,
  TabItem,
  ColorPicker,
  XInput
}
from 'vux'
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
    TabItem,
    XInput,
    ColorPicker,
  },
  data() {
    return {
      template: {},
      colors: [],
      fonts:[],
      mylogos: [],
      styleList: [],
      desgin: {
        front: '',
        back: '',
        frontTxt: '',
        backTxt: ''
      },
      defaultStyle: {
        front: 'tshirt/male/whitefront.png',
        back: 'tshirt/male/whiteback.png'
      },
      defaultlogo: '', //require('@/assets/img/blank.png'), //todo create a blank image
      selectedTab: 0,
      isbackend: false
    }
  },
  created() {
    this.template = this.$route.params.template;
    this.initData()
  },
  methods: {
    initData() {
      this.initColors();
      this.initFonts();
    },
    initColors() {
      var n = 0;
      // var hex = new Array('FF', 'CC', '99', '66', '33', '00');
      var hex = new Array('00', '33' , '66','99', 'CC','FF');
      this.colors=[];
      for (var i = 0; i < 6; i++) {
          for (var j = 0; j < 6; j++) {
            for (var k = 0; k < 6; k++) {
              n++;
              var color = '#'+hex[j] + hex[k] + hex[i];
              this.colors.push(color);
            }
          }
        }
    },
    setTextColor(c){
      if(!this.isbackend){
        this.$refs.front.txtLogo.color=c;
      }else{
        this.$refs.back.txtLogo.color=c;
      }
    },
    initFonts(){
      this.fonts=["Times New Roman","aaa","Times New Roman","Times New Roman","Times New Roman","Times New Roman","Times New Roman"];

    },
    setFonts(f){
      if(!this.isbackend){
        this.$refs.front.txtLogo.fontFamily=f;
      }else{
        this.$refs.back.txtLogo.fontFamily=f;
      }
    },
    onItemClick(id) {
      this.selectedTab = id;
    },
    openMyImages() {
      var vm = this;
      this.$wechat.chooseImage({
        // count: 1, // 默认9
        sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
        success: function(res) {
          if (res.localIds && res.localIds.length > 0) {
            for (var i = 0; i < res.localIds.length; i++) {
              var l = res.localIds[i]
              vm.loadImageData(l)
            }
          }
        }
      });
    },
    loadImageData(i) {
      var vm = this;
      //if not ios
      // vm.mylogos.push(i)
      //if ios
      this.$wechat.getLocalImgData({
        localId: i, // 图片的localID
        success: function(res) {
          vm.mylogos.push(res.localData); // localData是图片的base64数据，可以用img标签显示
        }
      });
    },
    setLogo(l) {
      if (this.isbackend) {
        this.$set(this.desgin, 'back', l);
      }
      else {
        this.$set(this.desgin, 'front', l);
      }
    },
    switchSide() {
      this.isbackend = !this.isbackend;
    }
  },
  computed: {
    bgImg_f() {
      if (this.template) {
        return this.template.FrontImg;
      }
      return this.template.FrontImg;
    },
    bgImg_b() {
      if (this.template) {
        return this.template.BackImg;
      }
      return this.template.BackImg;
    },
    logo_f() {
      if (this.desgin.front) {
        return this.desgin.front;
      }
      return this.defaultlogo;
    },
    logo_b() {
      if (this.desgin.back) {
        return this.desgin.back;
      }
      return this.defaultlogo;
    },
    currentSelectedLogo() {
      if (this.isbackend)
        return this.desgin.back;
      else
        return this.desgin.front;
    },
    currentSelectedStyle() {
      return this.desgin.style;
    },
    controlElementId() {
      return this.selectedTab == 10 ? 2 : 1;
    }


  }
}
</script>
<style scoped>
.tool {
  position: fixed;
  width: 100%;
  bottom: 0px
}

.box {
  position: relative;
  width: 1490px;
}

.box-item {
  width: 100px;
  height: 100px;
  background-color: #f1f1f1;
  display: inline-block;
  margin-left: 5px;
  float: left;
  text-align: center;
  line-height: 100px;
}

.box-color {
  height: 46px;
  display: inline-block;
  margin-left: 1px;
  float: left;
  text-align: center;
  line-height: 46px;
}

.box-item.selected {
  background-color: #e6e6e6;
  border: solid 1px #5d5d5d;
}

.box-item img {
  width: 100px;
  height: 100px;
}

.box-item:first-child ,.box-color:first-child {
  margin-left: 0;
}

.switch {
  position: fixed;
  right: 0px;
  margin: 10px;
  padding: 10px;
  font-size: 20px;
  line-height: 20px;
  border-radius: 30px;
  border: solid 1px #5d5d5d
}

.switch:hover {
  border: solid 1px #1d1d1d
}
</style>
