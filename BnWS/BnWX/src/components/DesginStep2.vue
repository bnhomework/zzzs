<template>
  <div class="router-view">
    <div style="min-height:26px"></div>
    <div style="width:100%;">
      <div @click="switchSide" class="switch">{{isbackend?'前':'后'}}</div>
      <image-editor ref="front" @logoclick="onItemClick(0)" @logotextclick="onItemClick(10)" v-show="!isbackend" :bgImg="getImgSrc(bgImg_f)" :logoImg="logo_f==undefined||logo_f==''?'':getImgSrc(logo_f)" :txtLogoText="desgin.frontTxt" :controlElementId="controlElementId"></image-editor>
      <image-editor ref="back" @logoclick="onItemClick(0)" @logotextclick="onItemClick(10)" v-show="isbackend" :bgImg="getImgSrc(bgImg_b)" :logoImg="logo_b==undefined||logo_b==''?'':getImgSrc(logo_b)" :txtLogoText="desgin.backTxt" :controlElementId="controlElementId"></image-editor>
    </div>
    <!-- <div>
      <img :src="getImgSrc(result1)">
      <img :src="getImgSrc(result2)">
    </div> -->
    <div v-transfer-dom>
      <popup v-model="saveDialogVisible" height="270px" is-transparent>
        <div style="width: 100%;background-color:#fff;height:100%;margin:0 auto;border-radius:5px;padding-top:10px;">
          <group>
            <x-input title="名字:" v-model="desginName"></x-input>
            <x-input title="标签:" v-model="desginTags"></x-input>
          </group>
          <div style="padding:20px 15px;">
            <x-button type="primary" :disabled="Preview1_120==''||Preview2_120==''" @click.native="saveDesign">保存</x-button>
            <x-button @click.native="saveDialogVisible = false">取消</x-button>
          </div>
        </div>
      </popup>
    </div>
    <div class="tool">
      <div class="tool-item" v-show="selectedTab==0">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" @click="openMyImages"><span style="font-size: 70px;font-weight: bold;vertical-align: middle;color: #5d5d5d;font-family:bn-icon">&#xe622;</span></div>
            <div class="box-item" :class="{selected:logo==currentSelectedLogo}" v-for="logo in mylogos" @click="setLogo(logo)">
              <img :src="getImgSrc(logo)">
            </div>
          </div>
        </scroller>
      </div>
      <div class="tool-item" v-if="selectedTab==10">
        <group>
          <x-input placeholder="正面写点什么呢..." v-model="desgin.frontTxt" v-show="!isbackend"></x-input>
          <x-input placeholder="背面写点什么呢..." v-model="desgin.backTxt" v-show="isbackend"></x-input>
        </group>
        <scroller lock-y scrollbar-x>
          <div class="box" style="width:2500px">
            <div class="box-item box-item-color" v-for="c in colors">
              <div style="width:10px;height:50px" :style="{'background-color':c}" @click="setTextColor(c)"></div>
            </div>
          </div>
        </scroller>
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item box-item-font" style="width:100px" :style="{'background-color':'#f5f5f5','font-family':f.cname}" v-for="f in fonts" @click="setFonts(f.cname)">
              <!-- <div class="box-item box-item-font" style="width:100px" :style="{'background-color':'#f5f5f5'}" v-for="f in fonts" @click="setFonts(f)"> -->
              <div style="width:100px;height:46px" :class="f.cname">{{f.cvalue}}</div>
            </div>
          </div>
        </scroller>
      </div>
      <div class="tool-item" v-show="selectedTab==20">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" v-for="s in styleList" @click="setStyle(s)">
              <img :src="getImgSrc(s.front)">
            </div>
          </div>
        </scroller>
      </div>
      <div class="tool-item" v-show="selectedTab==30">
        <scroller lock-y scrollbar-x>
          <div class="box">
            <div class="box-item" v-for="s in styleList" @click="setStyle(s)">
              <img :src="getImgSrc(s.front)">
            </div>
          </div>
        </scroller>
      </div>
      <!-- <tab>
        <tab-item :selected="selectedTab==0" @on-item-click="onItemClick(0)"><span class="bn-icon">&#xe73f;</span> 图片</tab-item>
        <tab-item :selected="selectedTab==10" @on-item-click="onItemClick(10)"><span class="bn-icon">&#xe627;</span> 文字</tab-item>
        <tab-item :selected="selectedTab==20" @on-item-click="onItemClick(20)"><span class="bn-icon">&#xe608;</span> 模板</tab-item>
      </tab> -->
    </div>
    <tabbar class="zy-tabbar" icon-class="vux-center" slot="bottom">
      <tabbar-item :selected="selectedTab==0" @on-item-click="onItemClick(0)"><span slot="label"> <span  class="bn-icon">&#xe73f;</span> 图片</span>
      </tabbar-item>
      <tabbar-item :selected="selectedTab==10" @on-item-click="onItemClick(10)"><span slot="label"> <span  class="bn-icon">&#xe627;</span> 文字</span>
      </tabbar-item>
      <!-- <tabbar-item :selected="selectedTab==20" @on-item-click="onItemClick(20)"><span slot="label"> <span  class="bn-icon">&#xe608;</span> 模板</span>
      </tabbar-item> -->
      <tabbar-item :selected="selectedTab==20" @on-item-click="showSaveDialog"><span slot="label"> <span  class="bn-icon">&#xe601;</span> 完成</span>
      </tabbar-item>
    </tabbar>
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
  Tabbar,
  TabbarItem,
  Tab,
  TabItem,
  ColorPicker,
  XInput,
  Popup
}
from 'vux'
import utils from '@/mixins/utils'
import imageEditor from '@/components/sub/imageEditor.vue'
import saveSVGasPNG from 'save-svg-as-png'
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
    Tabbar,
    TabbarItem,
    XInput,
    ColorPicker,
    Popup
  },
  data() {
    return {
      template: {},
      colors: [],
      fonts: [],
      mylogos: [],
      styleList: [],
      desgin: {
        front: '',
        frontTxt: '',
        back: '',
        backTxt: ''
      },
      Preview1: '',
      Preview2: '',
      desginName: '',
      desginTags: '',
      saveDialogVisible: false,
      defaultlogo: '',
      selectedTab: 0,
      isbackend: false,
      FrontImg64: '',
      BackImg64: '',
    }
  },
  created() {
    this.template = this.$route.params.template;
    this.initData()
  },
  methods: {
    initData() {
      var vm = this;
      //this.convertImageToBase64_2(this.template.FrontImg, function(u) { vm.FrontImg64 = u });
      //this.convertImageToBase64_2(this.template.BackImg, function(u) { vm.BackImg64 = u });
      this.initColors();
      this.initFonts();
    },
    initColors() {
      var n = 0;
      // var hex = new Array('FF', 'CC', '99', '66', '33', '00');
      var hex = new Array('00', '33', '66', '99', 'CC', 'FF');
      this.colors = [];
      for (var i = 0; i < 6; i++) {
        for (var j = 0; j < 6; j++) {
          for (var k = 0; k < 6; k++) {
            n++;
            var color = '#' + hex[j] + hex[k] + hex[i];
            this.colors.push(color);
          }
        }
      }
    },
    setTextColor(c) {
      if (!this.isbackend) {
        this.$refs.front.txtLogo.color = c;
      } else {
        this.$refs.back.txtLogo.color = c;
      }
    },
    initFonts() {
      window.bnfonts
      this.fonts = [{cname:"Times New Roman",cvalue:'Roman'}];
      if(window.bnfonts&&window.bnfonts.length>0){
        for (var i = window.bnfonts.length - 1; i >= 0; i--) {
          this.fonts.push(window.bnfonts[i]);
        }
      }
        // ,"Buxton Sketch",'Castellar','Curlz MT','Edwardian Script ITC'
        // "Edwardianbbd4cf60119966", "againstmyselfbbd4f196e19966", "Malapropismbbd4fb03019966", "GoodVibrationsRbbd50518119966", "Helvetica-Neue-bbd50d02619966", "Jellyka_-_Love_bbd51821119966", "ChannelSlanted2bbd4784e119966"
     // ]
    },
    reEncode(data) {
      data = encodeURIComponent(data);
      data = data.replace(/%([0-9A-F]{2})/g, function(match, p1) {
        var c = String.fromCharCode('0x' + p1);
        return c === '%' ? '%25' : c;
      });
      return decodeURIComponent(data);
    },
    convertoPNG(uri, cb) {
      var convertToPng = function(src, w, h) {
        var canvas = document.createElement('canvas');
        var context = canvas.getContext('2d');
        canvas.width = w;
        canvas.height = h;


        context.drawImage(src, 0, 0);

        // if (options.backgroundColor) {
        //   context.globalCompositeOperation = 'destination-over';
        //   context.fillStyle = options.backgroundColor;
        //   context.fillRect(0, 0, canvas.width, canvas.height);
        // }

        var png;
        try {
          png = canvas.toDataURL('image/png', 0.8);
        } catch (e) {
          if ((typeof SecurityError !== 'undefined' && e instanceof SecurityError) || e.name == "SecurityError") {
            console.error("Rendered SVG images cannot be downloaded in this browser.");
            return;
          } else {
            throw e;
          }
        }
        cb(png);
      }
      var image = new Image();

      image.onload = function() {
        convertToPng(image, image.width, image.height);
      }

      image.onerror = function() {
        console.error(
          'There was an error loading the data URI as an image on the following SVG');
      }

      image.src = uri;
    },
    showSaveDialog() {
      var vm = this;
      vm.Preview1 = '';
      vm.Preview2 = '';
      vm.Preview1_120 = '';
      vm.Preview2_120 = '';
      vm.saveDialogVisible = true;
      //todo save image to server
      //  var doctype = '<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd" [<!ENTITY nbsp "&#160;">]>';

      // var externalStyles = [];
      // externalStyles.push('http://cdn.webfont.youziku.com/webfonts/nomal/104806/46909/595e3e61f629d80e202e0ba3.css')
      // externalStyles.push('http://cdn.webfont.youziku.com/webfonts/nomal/104806/28818/595e3eedf629d80e202e0ba4.css')
      // externalStyles.push('http://cdn.webfont.youziku.com/webfonts/nomal/104806/37509/595e3f14f629d80e202e0ba5.css')
      // externalStyles.push('http://cdn.webfont.youziku.com/webfonts/nomal/104806/46908/595e3f3df629d80e202e0ba6.css')
      // externalStyles.push('http://cdn.webfont.youziku.com/webfonts/nomal/104806/46882/595e3f5ef629d80e202e0ba7.css')
      // externalStyles.push('http://cdn.webfont.youziku.com/webfonts/nomal/104806/47007/595e3f8bf629d80e202e0ba8.css')
      // externalStyles.push('http://cdn.webfont.youziku.com/webfonts/nomal/104806/45817/595e3cfdf629d80e202e0ba1.css')

      // var x = '';
      // if (externalStyles && externalStyles.length > 0) {
      //   for (var i = externalStyles.length - 1; i >= 0; i--) {
      //     var es = externalStyles[i];
      //     x += '<?xml-stylesheet type="text/css" href="' + es + '" ?>'
      //   }
      // }
      // var uri1 = 'data:image/svg+xml;base64,' + window.btoa(vm.reEncode(doctype + x + vm.$refs.front.$el.outerHTML));
      // var uri2 = 'data:image/svg+xml;base64,' + window.btoa(vm.reEncode(doctype + x + vm.$refs.back.$el.outerHTML));
      // vm.convertoPNG(uri1, function(u) {
      //   vm.Preview1 = u;
      //   vm.Preview1_120 = vm.Preview1;
      // });
      // vm.convertoPNG(uri2, function(u) {
      //   vm.Preview2 = u;
      //   vm.Preview2_120 = vm.Preview2;
      // });
      // vm.Preview1 = 'data:image/svg+xml;base64,' + window.btoa(vm.reEncode(doctype+x + vm.$refs.front.$el.outerHTML));
      // vm.Preview1_120 = vm.Preview1;
      // vm.Preview2 = 'data:image/svg+xml;base64,' + window.btoa(vm.reEncode(doctype+x + vm.$refs.back.$el.outerHTML));
      // vm.Preview2_120 = vm.Preview2;
      // ,externalStyles:externalStyles
      
      var fonts='';
      saveSVGasPNG.svgAsDataUri(vm.$refs.front.$el, { scale: 1,fonts:fonts }, function(uri) {
        // vm.Preview1 = uri;
        vm.Preview1_120 = uri;
        saveSVGasPNG.svgAsDataUri(vm.$refs.back.$el, { scale: 1 ,fonts:fonts}, function(uri) {
          // vm.Preview2 = uri;
          vm.Preview2_120 = uri;
        })
      })

      // saveSVGasPNG.svgAsPngUri(vm.$refs.front.$el, { scale: 1 ,fonts:fonts}, function(uri) {
      //   vm.Preview1 = uri;
      //   // vm.Preview1_120 = uri;
      //   saveSVGasPNG.svgAsPngUri(vm.$refs.back.$el, { scale: 1,fonts:fonts }, function(uri) {
      //     vm.Preview2 = uri;
      //     // vm.Preview2_120 = uri;
      //   })
      // })


      //  saveSVGasPNG.svgAsPngUri(vm.$refs.front.$el, {scale: 0.5}, function(uri) {
      //   vm.Preview1_120 = uri;
      // })
      // saveSVGasPNG.svgAsPngUri(vm.$refs.back.$el, {scale: 1}, function(uri) {
      //   vm.Preview2 = uri;
      //   vm.Preview2_120 = uri;
      // })
      // saveSVGasPNG.svgAsPngUri(vm.$refs.back.$el, {scale: 0.5}, function(uri) {
      //   vm.Preview2_120 = uri;
      // })
    },
    saveDesign() {
      var vm = this;
      this.desgin.frontSetting = this.$refs.front.getSettings();
      this.desgin.backSetting = this.$refs.back.getSettings();
      this.desgin.template = this.template;
      var url = this.apiServer + 'zz/SaveDesgin';
      var data = {
        zzDesign: {
          CustomerId: this.$store.state.bn.openId,
          TemplateId: this.template.TemplateId,
          Name: this.desginName,
          Tags: this.desginTags,
          DesginSettings: JSON.stringify(this.desgin),
          Preview1: this.Preview1,
          Preview2: this.Preview2,
          Preview1_120: this.Preview1_120,
          Preview2_120: this.Preview2_120,
        }
      };
      var vm = this;
      vm.$vux.loading.show({
        text: '正在保存...'
      })
      this.$http.post(url, data)
        .then(res => {
          vm.$vux.loading.hide()
          vm.$vux.toast.show({
            text: '保存成功',
            type: 'success'
          });
          vm.$router.push({
            name: 'DesginList'
          })
        }).catch(err => {
          vm.$vux.loading.hide()
          vm.$vux.toast.show({
            text: '出错啦~~',
            type: 'cancel'
          })
        });
    },
    setFonts(f) {
      if (!this.isbackend) {
        this.$refs.front.txtLogo.fontFamily = f;
      } else {
        this.$refs.back.txtLogo.fontFamily = f;
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
      if (window.__wxjs_is_wkwebview) {
        //if ios
        this.$wechat.getLocalImgData({
          localId: i, // 图片的localID
          success: function(res) {
            vm.mylogos.push(res.localData); // localData是图片的base64数据，可以用img标签显示
          }
        });

      } else {
        vm.$wechat.uploadImage({
          localId: i, // 需要上传的图片的本地ID，由chooseImage接口获得
          isShowProgressTips: 1, // 默认为1，显示进度提示
          success: function(res) {
            var serverId = res.serverId; // 返回图片的服务器端ID
            vm.loadImageFromWX(serverId);
          }
        });

      }
    },
    loadImageFromWX(serverId) {
      var vm = this;
      var url = this.apiServer + 'wx/loadImageFromWX';
      vm.$http.post(url, { serverId: serverId })
        .then(res => {
          vm.convertImageToBase64(res.data)
        }).catch(err => {
          vm.$vux.toast.show({
            text: '图片加载出错啦~~',
            type: 'cancel'
          })
        });
    },
    convertImageToBase64(url) {
      var vm = this;
      var canvas = document.createElement('canvas');
      var ctx = canvas.getContext('2d');
      var img = new Image();
      img.crossOrigin = "anonymous";
      var href = url;
      if (href) {
        img.src = href;
        img.onload = function() {
          canvas.width = img.width;
          canvas.height = img.height;
          ctx.drawImage(img, 0, 0);
          // image.setAttributeNS("http://www.w3.org/1999/xlink", "href", canvas.toDataURL('image/png'));
          vm.mylogos.push(canvas.toDataURL());
        }
        img.onerror = function() {
          console.log("Could not load " + href);
        }
      }
    },
    convertImageToBase64_2(url, cb) {
      var vm = this;
      var canvas = document.createElement('canvas');
      var ctx = canvas.getContext('2d');
      var img = new Image();
      img.crossOrigin = "anonymous";
      var href = this.getImgSrc(url);
      if (href) {
        img.src = href;
        img.onload = function() {
          canvas.width = img.width;
          canvas.height = img.height;
          ctx.drawImage(img, 0, 0);
          // image.setAttributeNS("http://www.w3.org/1999/xlink", "href", canvas.toDataURL('image/png'));
          cb(canvas.toDataURL('image/png'));
        }
        img.onerror = function() {
          console.log("Could not load2 " + href);
        }
      }
    },
    setLogo(l) {
      if (this.isbackend) {
        this.$set(this.desgin, 'back', l);
      } else {
        this.$set(this.desgin, 'front', l);
      }
    },
    switchSide() {
      this.isbackend = !this.isbackend;
    }
  },
  computed: {
    bgImg_f() {
       return this.template.FrontImg;
      // if (this.FrontImg64 == '') {
      //   return this.template.FrontImg;
      // } else {
      //   return this.FrontImg64
      // }
    },
    bgImg_b() {
       return this.template.BackImg;
      // if (this.BackImg64 == '') {
      //   return this.template.BackImg;
      // } else {
      //   return this.BackImg64
      // }
    },
    logo_f() {

      return this.desgin.front;
    },
    logo_b() {

      return this.desgin.back;
    },
    currentSelectedLogo() {
      if (this.isbackend)
        return this.desgin.back;
      else
        return this.desgin.front;
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
  bottom: 47px
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

.box-item.selected {
  background-color: #e6e6e6;
  border: solid 1px #5d5d5d;
}

.box-item img {
  width: 100px;
  height: 100px;
}

.box-item:first-child {
  margin-left: 0;
}

.box-item-color {
  min-width: 10px;
  width: 10px;
  height: 50px;
  margin-left: 0px;
  line-height: 50px;
}

.box-item-font {
  min-width: 10px;
  width: 10px;
  height: 46px;
  margin-left: 2px;
  line-height: 46px;
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
