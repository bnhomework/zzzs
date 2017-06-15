import Vue from 'vue'
import Router from 'vue-router'
// import Hello from '@/components/HelloFromVux'
import store from '@/store'
import config from '@/config'

Vue.use(Router)

const router = new Router({
  routes: [
    { path: '/', name: 'shopList', component: (resolve) => require(['@/components/ShopList.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'主页'}},
    { path: '/:openId', name: 'home', component: (resolve) => require(['@/components/ShopList.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'主页'}},
    { path: '/shop/:id', name: 'shop', component: (resolve) => require(['@/components/Shop.vue'], resolve),meta: { allowAnonymous: true,title:'店铺'}},
    { path: '/shopOnMap/:longitude/:latitude', name: 'shopOnMap', component: (resolve) => require(['@/components/ShopOnMap.vue'], resolve),meta: { allowAnonymous: true,title:'地图'}},
    { path: '/orders', name: 'orders', component: (resolve) => require(['@/components/Orders.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'订单'}}
  ]
})

const wxConfig=function(){
  // var c=config.wx.config;
  // Vue.wechat.config(c);
}
const history = window.sessionStorage
history.clear()
let historyCount = history.getItem('count') * 1 || 0
history.setItem('/', 0)

router.beforeEach(function (to, from, next) {
  store.commit('updateLoadingStatus', {isLoading: true})
  store.commit('updateRouteStatus', {route: to})

  const toIndex = history.getItem(to.path)
  const fromIndex = history.getItem(from.path)

  if (toIndex) {
    if (!fromIndex || parseInt(toIndex, 10) > parseInt(fromIndex, 10) || (toIndex === '0' && fromIndex === '0')) {
      store.commit('updateDirection', {direction: 'forward'})
    } else {
      store.commit('updateDirection', {direction: 'reverse'})
    }
  } else {
    ++historyCount
    history.setItem('count', historyCount)
    to.path !== '/' && history.setItem(to.path, historyCount)
    store.commit('updateDirection', {direction: 'forward'})
  }

  if (/\/http/.test(to.path)) {
    let url = to.path.split('http')[1]
    window.location.href = `http${url}`
  } else {
    next()
  }
  next()
})

router.afterEach(function (to) {
  store.commit('updateLoadingStatus', {isLoading: false})
})
export default router
