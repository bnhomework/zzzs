<template>
  <div style="width:100%;">
    <div v-for="item in designs">
      <div class="desgin-warp">
        <div class="preview-warp" @click.stop="goTo({name:'Desgin',params:{designId:item.Id}})">
          <!-- <div class="desgin-header">
            <span v-show="!item.IsPublic" @click.prevent.stop="setIsPublic(item,true)" class="bn-icon">&#xe6c9;</span>
            <span v-show="item.IsPublic" @click.prevent.stop="setIsPublic(item,false)" class="bn-icon">&#xe6ca;</span>
          </div> -->
          <img :src="getImgSrc(item.Preview1)">
          <div style="display:inline-block;vertical-align:top;">
            <div class="content-1">{{item.Name}}</div>
            <div style="font-size:10px;color:#5e5e5e">
              <span v-for="tag in desginTags(item.Tags)" class="tag content-2">{{tag}}</span>
            </div>
            <div><span class="amount">￥{{item.UnitPrice}}</span></div>
          </div>
          <div class="btn-order" @click="">开始订购</div>
        </div>
      </div>
    </div>
    <div v-show="loadingData==false&&designs.length==0" style="text-align:center;margin-top:40%">
      还没有收藏设计...
      <br/>
      <div></div>
      <br/>
      <x-button mini plain  type="primary" link="/">去收藏</x-button>
    </div>
  </div>
</template>
<script>
import {
  Toast,
  XButton
} from 'vux'
import utils from '@/mixins/utils'

export default {
  mixins: [utils],
  components: {
    Toast,
    XButton
  },
  data() {
    return {
      designs: [],
      loadingData:false
    }
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.loadDesigns();
    },
    loadDesigns() {
      this.loadingData=true;
      var url = this.apiServer + 'zz/GetMyFollowedDesgins';
      var data = {
        customerId: this.$store.state.bn.openId
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          vm.loadingData=false;
          vm.designs = res.data;
        });
    },
    desginTags(t) {
      var tags = [];
      if (t) {
        tags = t.split(',');
      }
      return tags;
    }
  },
  computed: {

  }
}

</script>
<style>
/*begin bottom*/

.bottom-fix {
  display: block;
  z-index: 100;
  position: fixed;
  left: 0;
  bottom: 47px;
  width: 100%;
  text-align: center;
  background-color: #fff;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  font-size: 0
}

.responsive-wrapper {
  margin: 0 auto;
}

.responsive-wrapper a {
  cursor: pointer;
}

.mini-btn-2-1 {
  float: left;
  width: 120px;
  font-size: 10px;
  text-align: center;
}

.mini-btn-2-1 a {
  width: 60px;
  min-width: 60px;
  line-height: 50px;
  position: relative;
  ;
  float: left;
}

.mini-btn-2-1 a i {
  font-family: 'bn-icon';
  font-size: 15px;
}

.mini-btn-2-1 a span {
  position: absolute;
  line-height: normal;
  ;
  left: 0px;
  bottom: 5px;
  width: 100%;
}

.big-btn-2-1 {
  font-size: 0;
  overflow: hidden;
  text-align: center;
  line-height: 50px;
}

.big-btn-2-1 .big-btn {
  width: 50%;
}

.big-btn {
  height: 50px;
  line-height: 50px;
  font-size: 16px;
  padding: 0;
  border: none;
  display: inline-block;
  vertical-align: top;
}

.orange-btn {
  background: #f85;
  color: #fff;
  position: relative;
}

.red-btn {
  background: #f44;
  color: #fff;
  position: relative;
}


/*end bottom*/

.btn-order {
  position: absolute;
  bottom: 10px;
  right: 5px;
  background: #f44;
  color: #fff;
  padding: 4px;
}

.desgin-warp {
  background-color: transparent;
  padding: 2px 5px;
}

.desgin-header {
  position: absolute;
  top: 5px;
  right: 5px;
  color: #5e5e5e;
  padding: 4px;
}
.desgin-header span{
  font-size: 14px;
}
.preview-warp {
  padding: 5px;
  position: relative;
  border-bottom: 1px solid #e5e5e5;
}

.preview-warp img {
  width: 30%;
  min-height: 80px;
  /*border: 1px solid #bbbbbb;*/
  background-color: #ffffff;
}

#shareit {
  -webkit-user-select: none;
  position: absolute;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.85);
  text-align: center;
  top: 0;
  left: 0;
  z-index: 105;
}

#shareit img {
  max-width: 70%;
}

.arrow {
  position: absolute;
  right: 10%;
  top: 5%;
}

#follow {
  width: 100%;
  height: 50px;
  line-height: 50px;
  text-align: center;
  text-decoration: none;
  font-size: 18px;
  color: white;
  float: left;
  margin-top: 400px;
}

</style>
