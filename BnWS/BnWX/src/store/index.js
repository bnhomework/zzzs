import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
const store = new Vuex.Store({

})

store.registerModule('bn', {
  state: {
    openId:'',
    isLoading: false,
    route:{},
    direction: 'forward'
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
    }
  }
})
export default store
