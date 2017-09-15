import Vue from 'vue'
import Router from 'vue-router'
import store from '@/store'
import config from '@/config'

Vue.use(Router)

const router = new Router({
  routes: [
    { path: '/wx/:openId', name: 'home', component: (resolve) => require(['@/components/Home.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'主页',componentName:'主页'}}
    ,{ path: '/DesginStep1', name: 'DesginStep1', component: (resolve) => require(['@/components/DesginStep1.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'设计',componentName:'创意设计'}}
    
    ,{ path: '/DesginStep2', name: 'DesginStep2', component: (resolve) => require(['@/components/DesginStep2.vue'], resolve),meta: { allowAnonymous: true, showTabbar:false,title:'设计',componentName:'创意设计'}}
    ,{ path: '/OtherFunctions', name: 'OF1', component: (resolve) => require(['@/components/OtherFunctions.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'我的',componentName:'我的'}}
    ,{ path: '/DesginList', name: 'DesginList', component: (resolve) => require(['@/components/DesginList.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'我的设计',componentName:'我的设计'}}
    ,{ path: '/FavoriteList', name: 'FavoriteList', component: (resolve) => require(['@/components/FavoriteList.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'收藏夹',componentName:'我的'}}
    ,{ path: '/Desgin', name: 'Desgin', component: (resolve) => require(['@/components/Desgin.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'设计',componentName:'设计'}}
    ,{ path: '/submitOrders', name: 'submitOrders', component: (resolve) => require(['@/components/submitOrders.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'提交订单'}}
    ,{ path: '/shoppingCart', name: 'shoppingCart', component: (resolve) => require(['@/components/submitOrders.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'提交订单'}}
    ,{ path: '/AddressList', name: 'AddressList', component: (resolve) => require(['@/components/AddressList.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'收货地址'}}
    ,{ path: '/OrderList', name: 'OrderList', component: (resolve) => require(['@/components/OrderList.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'我的订单'}}
    ,{ path: '/MessageList', name: 'MessageList', component: (resolve) => require(['@/components/MessageList.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'我的消息'}}
    ,{ path: '/AboutUS', name: 'AboutUS', component: (resolve) => require(['@/components/AboutUS.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'关于我们'}}
    ,{ path: '/ContactUS', name: 'ContactUS', component: (resolve) => require(['@/components/ContactUS.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'联系客服'}}
    ,{ path: '/Feedback', name: 'Feedback', component: (resolve) => require(['@/components/Feedback.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'意见反馈'}}
    ,{ path: '/LogisticsInfo', name: 'LogisticsInfo', component: (resolve) => require(['@/components/LogisticsInfo.vue'], resolve),meta: { allowAnonymous: true, showTabbar:true,title:'物流信息'}}
    ,{path:'*',redirect:{name:'home'}}
    ,{path:'/401',name:'401',component: (resolve) => require(['@/components/OtherFunctions.vue'], resolve),meta: { allowAnonymous: true, showTabbar:false,title:'Opps',componentName:'Opps'}}
    ]
})

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
    store.dispatch('initWX_JS', next)
    window.scrollTo(0, 0)
  }
})

router.afterEach(function (to) {
  store.commit('updateLoadingStatus', {isLoading: false})
  if(to.meta&&to.meta.title){
    console.log(to)
    document.title=to.meta.title
  }
})
export default router
