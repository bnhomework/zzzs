// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import FastClick from 'fastclick'
import App from './App'


import store from './store'
import router from './router'
import AMap from 'vue-amap'
import { AjaxPlugin, WechatPlugin } from 'vux'
Vue.use(AjaxPlugin)
Vue.use(WechatPlugin)
Vue.use(AMap)

AMap.initAMapApiLoader({
  key: '9a06cbc0ebd93e4b309bbfe9830c1f16',
  plugin: ['AMap.Autocomplete', 'AMap.PlaceSearch', 'AMap.Scale', 'AMap.OverView', 'AMap.ToolBar', 'AMap.MapType', 'AMap.PolyEditor', 'AMap.CircleEditor']
});


FastClick.attach(document.body)

Vue.config.productionTip = false
// require('es6-promise').polyfill()
/* eslint-disable no-new */
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app-box')
