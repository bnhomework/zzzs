<template>
  <div class="router-view" id="home">
    <swiper :list="imgList" auto style="width:100%;margin:0 auto;" height="180px" dots-class="custom-bottom" dots-position="center"></swiper>
     <group-title>牛X设计</group-title>
    <grid :rows="2">
      <grid-item v-for="item in publicDesigns" >
        <img slot="icon" :src="item.Preview1" @click="goTo({name:'Desgin',params:{designId:item.Id}})">
        <div slot="label" style="text-align: left">
          <!-- <div>{{item.Name}}</div> -->
          <img :src="getImgSrc(item.DesignerAvatar)" class="small-avatar">
          <span style="position:absolute;margin-left:5px">{{item.Designer}}</span>
          <div @click="updateFollowStatus(item)" class="pull-right">
          <span class="bn-icon" v-show="!item.IsFollowed" style="font-size:15px;margin-right:5px">&#xe74b;</span>
          <span class="bn-icon" v-show="item.IsFollowed" style="font-size:15px;margin-right:5px">&#xe8cf;</span>
          {{item.Follows||0}}</div>
        </div>
      </grid-item>
    </grid>
  </div>
</template>
<script>
import { Group, Cell , Swiper,Grid,GridItem, GroupTitle} from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins: [utils],
  components: {
    Group,
    Cell, Swiper,Grid,GridItem, GroupTitle
  },
  data() {
    return {
      publicDesigns: [],
      imgs:['/upload/home/a1.jpg','/upload/home/a2.jpg','/upload/home/a3.jpg','/upload/home/a4.jpg']
    }
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      var vm = this;
      var openId = vm.$route.params.openId;
      if (openId != undefined && openId != '') {
        vm.$store.commit("updateOpenId", {
          openId: openId
        });
        vm.$store.dispatch('loadCustomerInfo', openId);
      }
      vm.loadPublicDesigns(openId);
    },
    loadPublicDesigns(openId) {
      var url = this.apiServer + 'zz/GetPublicDesgins';
      var data = {
        openId: openId
      };
      var vm = this;
      this.$http.post(url, data).then(res => {
        this.publicDesigns = res.data;
      });
    },
    updateFollowStatus(item){
      var follow=!item.IsFollowed;
      var url = this.apiServer + 'zz/UpdateDesginFollowStatus';
      var data = {
        designId: item.Id,
        customerId: this.$store.state.bn.openId,
        follow:follow
      };
      var vm = this;
      this.$http.post(url, data).then(res => {
        if(follow){
          item.IsFollowed=true;
          item.Follows+=1;
        }else{

          item.IsFollowed=false;
          item.Follows-=1;
        }
      });
    }
  },
  computed: {
    imgList() {
      var imgs = this.imgs;
      if (!imgs) return [];
      var self = this;
      var result = imgs.map((x) => {
        return {
          url: 'javascript:',
          img: self.getImgSrc(x)
        }
      });
      return result
    }
  }
}

</script>
<style>
#home .weui-grid__icon {
    width: 90% !important;
    height: 90% !important;
    min-height: 120px;
    border-bottom: 1px solid #d5d5d5;
}
#home .weui-grid:before {
  border-right: none;
  border-top: none;
  border-bottom: none;
}
#home .weui-grid:after {
  border-right: none;
  border-top: none;
  border-bottom: none;
  border-left: none;
}
#home .weui-grid__label{
  height: 35px!important;
  color: #5d5d5d;
  line-height:30px;
}
.small-avatar{
  width: 30px;
  border-radius: 30px;
}
</style>
