<template>
  <div class="router-view">
    <div style="min-height:26px"></div>
    <div style="width:100%;">
      <image-editor ref="front" readOnly="true" :bgImg="getImgSrc(bgImg_f)" :logoImg="logo_f==undefined||logo_f==''?'':getImgSrc(logo_f)" :txtLogoText="desgin.frontTxt"></image-editor>
      <image-editor ref="back" readOnly="true" :bgImg="getImgSrc(bgImg_b)" :logoImg="logo_b==undefined||logo_b==''?'':getImgSrc(logo_b)" :txtLogoText="desgin.backTxt"></image-editor>
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
      isbackend: false
    }
  },
  created() {
    this.template = this.$route.params.template;
    this.initData()
  },
  methods: {
    initData() {
     
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
    }
  },
  computed: {
    bgImg_f() {
      return this.template.FrontImg;
    },
    bgImg_b() {

      return this.template.BackImg;
    },
    logo_f() {

      return this.desgin.front;
    },
    logo_b() {

      return this.desgin.back;
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
