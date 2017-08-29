<template>
  <div class="router-view">
    <swiper :list="imgList" auto style="width:100%;margin:0 auto;" height="180px" dots-class="custom-bottom" dots-position="center"></swiper>
    
    <group title="牛X设计">
      
      <div v-for="item in publicDesigns">{{item}}</div>
    </group>
  </div>
</template>
<script>
import { Group, Cell , Swiper} from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins: [utils],
  components: {
    Group,
    Cell, Swiper
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
<style scoped>
.vux-demo {
  text-align: center;
}

.logo {
  width: 100%;
  height: 187px;
}

</style>
