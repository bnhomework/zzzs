<template>
  <div>
    <div class="vux-demo">
      <img class="logo" src="../assets/vux_logo.png">
      <h1></h1>
    </div>
    <group title="cell demo">
      <cell title="Vux" :value="item.dist" :link="{path:'/shop/'+item.shopId}" v-for="item in shops">
        <img slot="icon" width="100" style="display:block;margin-right:5px;" :src="getImgSrc(item.imgUrl)">
        <span slot="title">{{item.name}}</span>
        <span slot="inline-desc">{{item.description}}</span>
      </cell>
    </group>
  </div>
</template>

<script>
import { Group, Cell } from 'vux'
import utils from '@/mixins/utils'

export default {
    mixins:[utils],
    components: {
        Group,
        Cell
    }
    ,
    data () {
        return {
            shops: []
        }
    }
    ,
    created() {
        this.init();
    }
    ,
    methods: {
        init() {
            var openId=this.$route.params.openId;
            if(openId!=undefined&&openId!='') {
                this.$store.commit("updateOpenId", {
                    openId: this.$route.params.openId
                }
                )
            }
            var vm=this;
            this.$wechat.getLocation( {
                type: 'wgs84', success: function (res) {
                    var userLocation= {
                        longitude: res.longitude, latitude: res.latitude
                    };
                    vm.$store.commit('updateUserLocation', {userLocation: userLocation});
                    vm.loadShops();
                }
                , fail:function() {
                    vm.loadShops();
                }
            }
            );
            vm.loadShops();//test
        },
        loadShops(condition) {
            var url=this.apiServer+'zy/shops';
            condition=condition||this.$store.state.bn.userLocation|| {};
            var data= {
                condition: condition
            };
            var vm=this;
            this.$http.post(url, data).then(res=> {
                this.shops=res.data;
            }
            );
        }
    }
}


</script>

<style>
.vux-demo {
  text-align: center;
}
.logo {
  width: 100px;
  height: 100px
}
</style>
