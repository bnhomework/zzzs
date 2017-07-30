import Vue from 'vue'
import Vuex from 'vuex'
import config from '@/config'
const wx = require('weixin-js-sdk')

Vue.use(Vuex)
const store = new Vuex.Store({

})

store.registerModule('bn', {
  state: {
    openId: '',
    userInfo: {},
    isLoading: false,
    route: {},
    direction: 'forward',
    WX_Config: undefined,
    userLocation: undefined
  },
  mutations: {
    updateOpenId(state, payload) {
      state.openId = payload.openId
      if (payload.openId) {
        Vue.http.defaults.headers.common["ZY_Auth"] = payload.openId;
      }
    },
    updateLoadingStatus(state, payload) {
      state.isLoading = payload.isLoading
    },
    updateRouteStatus(state, payload) {
      state.route = payload.route
    },
    updateDirection(state, payload) {
      state.direction = payload.direction
    },
    updateWX_Config(state, payload) {
      state.WX_Config = payload.WX_Config
    },
    updateUserLocation(state, payload) {
      state.userLocation = payload.userLocation
    },
    updateUserInfo(state, payload) {
      state.userInfo = payload.userInfo
    }

  },
  actions: {
    initWX_JS(context, next) {
      if (context.state.WX_Config) {
        next()
      } else {
        var jsApiList = config.jsApiList;
        var url = config.apiServer + 'wx/JSSDK'
        var vm = this;
        wx.ready(function() {
          console.log('init initWX_JS success')
          next();
        });
        wx.error(function(res) {
          console.log(res)
          console.log('wx config on error')
          //context.commit('updateWX_Config', {WX_Config:undefined});
        });
        Vue.http.get(url, { params: { url: window.location.href } })
          .then(res => {
            var c = res.data;
            c.jsApiList = jsApiList;
            wx.config(c);
            context.commit('updateWX_Config', { WX_Config: c });
            console.log('init initWX_JS config success');
             next();//uncomment test///waiting ready function
          }).catch(error => {
            console.log('init initWX_JS failed')
            next()
          })
      }
    },
    loadCustomerInfo(context,openId) {
      var url = config.apiServer + 'wx/GetUserInfo'
      Vue.http.get(url, { params: { openId: openId } })
        .then(res => {
          var c = res.data;
          context.commit('updateUserInfo', { userInfo: c });
        })
    }
  }
})
export default store
