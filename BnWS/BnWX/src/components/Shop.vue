<template>
  <div>
    <swiper :list="imgList" auto style="width:100%;margin:0 auto;" height="180px" dots-class="custom-bottom" dots-position="center"></swiper>
    <group title="地址">
      <div @click="showMap">
      <cell :title="shopInfo.address" is-link >
        <x-icon type="ios-location-outline" slot="icon" size="20"></x-icon>
      </cell>
      </div>
    </group>
    <group title="预约">
      <datetime v-model="pickDate" :title="日期"></datetime>
    </group>
    <div style="padding:15px;">
      <x-button @click.native="book" type="primary">立即预约</x-button>
    </div>
  </div>
</template>

<script>
import { Group, Cell,Swiper,Datetime ,XButton } from 'vux'
import utils from '@/mixins/utils'

export default {
    mixins:[utils],
    components: {
        Group,
        Cell,
        Swiper,Datetime ,XButton
    }
    ,
    data () {
        return {
            shopId:'',
            shopInfo: {}
            ,
            pickDate: this.getCurrentDate()
        }
    }
    ,
    created() {
        this.init();
    }
    ,
    methods: {
        init() {
            this.shopId=this.$route.params.id;
            this.loadShopInfo();
        }
        ,
        loadShopInfo() {
            var url=this.apiServer+'zy/ShopDetail';
            var data= {
                shopId: this.shopId
            }
            ;
            var vm=this;
            this.$http.post(url, data) 
            .then(res=> {
                this.shopInfo=res.data;
            }
            );
        }
        ,
        showMap() {
            this.$wechat.openLocation( {
                latitude: this.shopInfo.latitude, 
                longitude: this.shopInfo.longitude, 
                name: this.shopInfo.shopName, 
                address: this.shopInfo.address, 
                scale: 14, 
                infoUrl: ''
            }
            );
        }
        ,
        book() {
            this.$router.push( {
                name:'desks',
                params: {
                    shopId: this.shopId, 
                    pickDate: this.pickDate,
                    shopName:this.shopName
                }}
            )
        }
    }
    ,
    computed: {
        imgList() {
            var imgs=this.shopInfo.imgs;
            if(!imgs) return [];
            var self=this;
            var result=imgs.map((x)=> {
                return {
                    url: 'javascript:', img: self.getImgSrc(x)
                }
            }
            );
            return result
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
