<template>
  <div style="height:100%;">
    <div v-transfer-dom>
       <loading v-model="isLoading"></loading>
    </div>
    <!-- <div v-transfer-dom>
      <actionsheet :menus="menus" v-model="showMenu" @on-click-menu="changeLocale"></actionsheet>
    </div> -->

    <!-- <view-box ref="viewBox" body-padding-top="46px" body-padding-bottom="55px"> -->
    <view-box ref="viewBox" body-padding-bottom="55px">
      
     <!--  <x-header slot="header"
      style="width:100%;position:absolute;left:0;top:0;z-index:100;"
      :left-options="leftOptions"
      :title="title"
      :transition="headerTransition"
      @on-click-more="onClickMore" v-if="this.$store.state.bn.openId==''||this.$store.state.bn.openId==undefined"></x-header> -->

      <transition :name="'vux-pop-' + (direction === 'forward' ? 'in' : 'out')">
        <router-view></router-view>
      </transition>

      <tabbar class="zy-tabbar" icon-class="vux-center" v-show="route.meta.showTabbar" slot="bottom">
        <tabbar-item :link="{name:'home'}" :selected="route.name === 'home'">
          <span class="zy-icon-22 zy-tabbar-icon-home" slot="icon" style="position:relative;top: -2px;">&#xe7a4;</span>
          <span slot="label">主页</span>
        </tabbar-item>
        <tabbar-item :link="{path:'/'}" :selected="route.name === 'home'">
          <span class="zy-icon-22 zy-tabbar-icon-home" slot="icon" style="position:relative;top: -2px;">&#xe64e;</span>
          <span slot="label">订单</span>
        </tabbar-item>
        <tabbar-item :link="{name:'DesginStep1'}" :selected="(route.name||'').indexOf('DesginStep')>=0">
          <span class="zy-icon-22 zy-tabbar-icon-home" slot="icon" style="position:relative;top: -2px;">&#xe602;</span>
          <span slot="label">创意设计</span>
        </tabbar-item>
        <tabbar-item :link="{name:'OF1'}" :selected="(route.name||'').indexOf('OF')>=0">
          <span class="zy-icon-22 zy-tabbar-icon-home" slot="icon" style="position:relative;top: -2px;">&#xe624;</span>
          <span slot="label">我的</span>
        </tabbar-item>
      </tabbar>
  </view-box>
  </div>
</template>

<script>
import { Actionsheet, ButtonTab, ButtonTabItem, ViewBox, XHeader, Tabbar, TabbarItem, Loading, TransferDom } from 'vux'
import { mapState, mapActions } from 'vuex'
export default {
   directives: {
    TransferDom
  },
  components: {
    ButtonTab,
    ButtonTabItem,
    ViewBox,
    XHeader,
    Tabbar,
    TabbarItem,
    Loading,
    Actionsheet
  },
  methods: {
    onClickMore () {
      this.showMenu = true
    },
    changeLocale (locale) {
      this.$i18n.set(locale)
      this.$locale.set(locale)
    },
    ...mapActions([
      'updateDemoPosition'
    ])
  },
  mounted () {
    this.handler = () => {
      // if (this.path === '/demo') {
      //   this.box = document.querySelector('#demo_list_box')
      //   this.updateDemoPosition(this.box.scrollTop)
      // }
    }
  },
  beforeDestroy () {
    this.box.removeEventListener('scroll', this.handler, false)
  },
  watch: {
    path (path) {
      if (path === '/component/demo') {
        this.$router.replace('/demo')
        return
      }
      if (path === '/demo') {
        setTimeout(() => {
          this.box = document.querySelector('#demo_list_box')
          if (this.box) {
            this.box.removeEventListener('scroll', this.handler, false)
            this.box.addEventListener('scroll', this.handler, false)
          }
        }, 1000)
      } else {
        this.box && this.box.removeEventListener('scroll', this.handler, false)
      }
    }
  },
  computed: {
    ...mapState({
      route: state => state.bn.route,
      path: state => state.bn.route.path,
      isLoading: state => state.bn.isLoading,
      direction: state => state.bn.direction
    }),
    isShowBar () {
      if (/component/.test(this.path)) {
        return true
      }
      return false
    },
    leftOptions () {
      return {
        showBack: this.route.path !== '/'&&this.route.name!='home'
      }
    },
    rightOptions () {
      return {
        showMore: true
      }
    },
    headerTransition () {
      return this.direction === 'forward' ? 'vux-header-fade-in-right' : 'vux-header-fade-in-left'
    },
    componentName () {
      return this.route.meta.componentName||'';
    },
    isDemo () {
      return /component|demo/.test(this.route.path)
    },
    isTabbarDemo () {
      return /tabbar/.test(this.route.path)
    },
    title () {
      // if (this.route.path === '/') return 'Home'
      // if (this.route.path === '/project/donate') return 'Donate'
      // if (this.route.path === '/demo') return 'Demo list'
      // return this.componentName ? `Demo/${this.componentName}` : 'Demo/~~'
      return this.route.meta.title||'xxx'
    }
  },
  data () {
    return {
      
    }
  }
}
</script>

<style lang="less">
@import '~vux/src/styles/reset.less';
@import '~vux/src/styles/1px.less';
@import '~vux/src/styles/tap.less';

body {
  background-color: #fbf9fe;
}
html, body {
  height: 100%;
  width: 100%;
  overflow-x: hidden;
}
.bn-icon{
   font-family: 'bn-icon';
  font-size: 25px;
  color: #888;
}
.content-1{
  font-size:16px;
  color:#5e5e5e;
}
.content-2{
  font-size:12px;
  color:#9a9a9a;
}
.big-btn {
  height: 50px;
  line-height: 50px;
  font-size: 16px;
  padding: 0;
  border: none;
  display: inline-block;
  vertical-align: top;
}

.orange-btn {
  background: #f85;
  color: #fff;
  position: relative;
}

.red-btn {
  background: #f44;
  color: #fff;
  position: relative;
}
span.option{
  border: 1px solid #a5a5a5;
  border-radius:5px;
  padding:5px;
  display: inline-block;
}
span.option.active{
  border: 1px solid #f85;
}
span.tag{
  border: 1px solid #e1e1e1;
  border-radius:5px;
  color:#9a9a9a;
  padding:2px;
}
span.amount{
  color:#f85;
  font-size:20px;
}
.pull-right{
  float: right;
}

.zy-icon-22 {
  font-family: 'bn-icon';
  font-size: 22px;
  color: #888;
}

.zy-tabbar .weui-bar__item_on .zy-icon-22 {
  color: #F70968;
}
.zy-tabbar .weui-tabbar_item.weui-bar__item_on .zy-tabbar-icon-home {
  color: rgb(53, 73, 94);
}
.zy-icon-22:before {
  content: attr(icon);
}
.zy-tabbar-component {
  background-color: #F70968;
  color: #fff;
  border-radius: 7px;
  padding: 0 4px;
  line-height: 14px;
}
.weui-tabbar__icon + .weui-tabbar__label {
  margin-top: 0!important;
}
.vux-demo-header-box {
  z-index: 100;
  position: absolute;
  width: 100%;
  left: 0;
  top: 0;
}

@font-face {
  font-family: 'bn-icon';  /* project id 338215 */
  src: url('//at.alicdn.com/t/font_xl3x130d804l5wmi.eot');
  src: url('//at.alicdn.com/t/font_xl3x130d804l5wmi.eot?#iefix') format('embedded-opentype'),
  url('//at.alicdn.com/t/font_xl3x130d804l5wmi.woff') format('woff'),
  url('//at.alicdn.com/t/font_xl3x130d804l5wmi.ttf') format('truetype'),
  url('//at.alicdn.com/t/font_xl3x130d804l5wmi.svg#iconfont') format('svg');
}

.demo-icon {
  font-family: 'vux-demo';
  font-size: 20px;
  color: #04BE02;
}

.demo-icon-big {
  font-size: 28px;
}

.demo-icon:before {
  content: attr(icon);
}

.router-view {
  width: 100%;
  /**top: 46px;**/
}
.vux-pop-out-enter-active,
.vux-pop-out-leave-active,
.vux-pop-in-enter-active,
.vux-pop-in-leave-active {
  will-change: transform;
  transition: all 500ms;
  height: 100%;
  /**top: 46px;**/
  position: absolute;
  backface-visibility: hidden;
  perspective: 1000;
}
.vux-pop-out-enter {
  opacity: 0;
  transform: translate3d(-100%, 0, 0);
}
.vux-pop-out-leave-active {
  opacity: 0;
  transform: translate3d(100%, 0, 0);
}
.vux-pop-in-enter {
  opacity: 0;
  transform: translate3d(100%, 0, 0);
}
.vux-pop-in-leave-active {
  opacity: 0;
  transform: translate3d(-100%, 0, 0);
}
.menu-title {
  color: #888;
}
</style>
