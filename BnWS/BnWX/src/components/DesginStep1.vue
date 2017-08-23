<template>
<div class="router-view">
  <box gap="10px 10px">
    <checker v-model="sex" default-item-class="demo5-item" selected-item-class="demo5-item-selected">
      <checker-item :key="1" :value="1">男士</checker-item>
      <checker-item :key="2" :value="2">女士</checker-item>
    </checker>
    <div style="padding:10px ;background-color:#d5d5d5;margin-top:10px">
      <scroller lock-y scrollbar-x>
        <div class="box">
          <color-picker class="box-item" slot="value" :colors="colors" v-model="selectedColor" size="middle"></color-picker>
        </div>
      </scroller>
    </div>
    <div style="margin-top:10px;margin-bottom:10px">
      <img :src="getImgSrc(selectedTemplate.FrontImg)" style="width:100%">
    </div>
    <div class='tool'>
      <x-button plain @click.native="startDesgin" :disabled="selectedTemplate.FrontImg==null">开始设计</x-button>
    </div>
  </box></div>
</template>
<script>
import _ from 'underscore'
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
      selectedColor: '#E2DDDB',
      templates: []

    }
  },
  created() {
    this.initData()
  },
  methods: {
    initData() {
      this.loadTemplates();
    },
    loadTemplates() {
      var vm = this;
      var url = this.apiServer + 'zz/GetTemplates';
      var data = {
        condition: {
          Category: 1
        }
      }
      this.$http.post(url, data)
        .then(res => {
          vm.templates = res.data;
          if (vm.colors.length > 0) {
            vm.selectedColor = vm.colors[0];
          }
        });
    },
    startDesgin() {
      this.$router.push({
        name: 'DesginStep2',
        params: {
          template: this.selectedTemplate
        }
      });
    }
  },
  computed: {
    selectedTemplate() {
      var vm = this;
      var t = this.templates.filter(x => {
        return x.Sex == vm.sex && x.Color == vm.selectedColor
      });
      if (t.length > 0) {
        return t[0];
      }
      else {
        return {};
      }
    },
    colors() {
      var vm = this;
      var t = this.templates.filter(x => {
        return x.Sex == vm.sex
      });
      var clist = _.pluck(t, 'Color').sort();
      return _.uniq(clist);
    }

  }
}
</script>
<style scoped>
.tool {
  position: fixed;
  width: 95%;
  margin: 0 auto;
  bottom: 54px;
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
  border-color: #f85;
  color: #f85
}

.vux-color-checked.weui-icon-success-no-circle:before {
  color: #d5d5d5
}
</style>
