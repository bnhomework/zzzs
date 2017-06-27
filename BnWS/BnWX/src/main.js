// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import FastClick from 'fastclick'
import App from './App'
import AlloyFinger from 'alloyfinger'
import AlloyFingerVue from '@/../node_modules/alloyfinger/vue/alloy_finger.vue.js'


import store from './store'
import router from './router'
import { AjaxPlugin, WechatPlugin,ToastPlugin } from 'vux'

window.AlloyFinger=AlloyFinger
Vue.use(ToastPlugin)
Vue.use(AjaxPlugin)
Vue.use(WechatPlugin)
Vue.use(AlloyFingerVue);
window.wx=window.wx||Vue.wechat;
FastClick.attach(document.body)
Vue.config.productionTip = false
// require('es6-promise').polyfill()
/* eslint-disable no-new */
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app-box')
