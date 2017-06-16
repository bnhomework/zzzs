import Vue from 'vue'
import Vuex from 'vuex'
import config from '@/config'
const wx = require('weixin-js-sdk')

Vue.use(Vuex)
const store = new Vuex.Store({

})

store.registerModule('bn', {
  state: {
    openId:'',
    isLoading: false,
    route:{},
    direction: 'forward',
    WX_Config:undefined,
    userLocation:undefined
  },
  mutations: {
    updateOpenId (state, payload) {
      state.openId = payload.openId
    },
    updateLoadingStatus (state, payload) {
      state.isLoading = payload.isLoading
    },
    updateRouteStatus (state, payload) {
      state.route = payload.route
    },
    updateDirection (state, payload) {
      state.direction = payload.direction
    },
    updateWX_Config (state, payload) {
      state.WX_Config = payload.WX_Config
    },
    updateUserLocation (state, payload) {
      state.userLocation = payload.userLocation
    }
  },
  actions: {
        initWX_JS(context, next) {
            if (context.state.WX_Config) {
                next()
            } else {
                var jsApiList=config.jsApiList;
                var url=config.apiServer+'wx/JSSDK'
                var vm=this;
                Vue.http.get(url,{params:{url:window.location.href}})
                .then(res=>{
                  var c=res.data;
                  c.jsApiList=jsApiList;
                  wx.config(c);
                  context.commit('updateWX_Config', {WX_Config:c});                  
                  console.log('init initWX_JS success')
                  next();
                }).catch(error=>{
                  console.log('init initWX_JS failed')
                  next()
                })                
            }
        }
    }
})
export default store
