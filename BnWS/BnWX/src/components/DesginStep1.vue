<template>
  <box gap="10px 10px">
    <checker v-model="sex" default-item-class="demo5-item" selected-item-class="demo5-item-selected">
      <checker-item :key="1" :value="1">男士</checker-item>
      <checker-item :key="2" :value="2">女士</checker-item>
    </checker>
    <div>
      <group title="颜色">
        <cell primary="content">
          <color-picker slot="value" :colors="colors" v-model="selectedColor" size="middle"></color-picker>
        </cell>
      </group>
    </div>
    <div style="margin-top:10px">
      
    <img :src="getImgSrc(template.frontImg)" style="width:100%">
    </div>
    <div class='tool'>
      <x-button plain>开始设计</x-button>
    </div>
  </box>
</template>
<script>
import {
  Scroller,
  XButton,
  Box,
  ColorPicker,
  Group,
  Cell,
  Checker,
  CheckerItem
}
from 'vux'
import utils from '@/mixins/utils'
export default {
  mixins: [utils],
  components: {
    Scroller,
    XButton,
    Box,
    ColorPicker,
    Group,
    Cell,
    Checker,
    CheckerItem
  },
  data() {
    return {
      sex: 1,
      selectedColor: '#fff',
      colors: ['#fff', '#FF3B3B', '#FFEF7D', '#8AEEB1', '#8B8AEE', '#CC68F8'],
      template:{tempalteId:'',frontImg:''}
      
    }
  },
  created() {
    this.initData()
  },
  methods: {
    initData() {
      //this.loadStyleList();
    },
    loadStyleList() {
      this.styleList.push({
        front: 'tshirt/male/whitefront.png',
        backend: 'tshirt/male/whiteback.png'
      });
      this.styleList.push({
        front: 'tshirt/male/whiteback.png',
        backend: 'tshirt/male/whitefront.png'
      });
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
    setStyle(s) {
      this.$set(this.desgin, 'style', s);
    },
    setLogo(l) {
      if (this.isBackend) {
        this.$set(this.desgin, 'backend', l);
      }
      else {
        this.$set(this.desgin, 'front', l);
      }
    },
    switchSide() {
      this.isBackend = !this.isBackend;
    }
  },
  computed: {
    

  }
}
</script>
<style scoped>
.tool {
  position: fixed;
  width: 95%;
  margin: 0 auto;
  bottom: 52px;
}

.demo5-item {
  width: 100px;
  height: 40px;
  line-height: 40px;
  text-align: center;
  border-radius: 3px;
  border: 1px solid #ccc;
  background-color: #fff;
  margin-right: 6px;
}

.demo5-item-selected {
  border-color: #ff4a00;
}
</style>
