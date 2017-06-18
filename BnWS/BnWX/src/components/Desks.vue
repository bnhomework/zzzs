<template>
  <div>
    <h2>{{shopName}}(<span>{{pickDate}}</span>)</h2>
    <divider></divider>
    <group-title></group-title>
    <div style="margin-bottom: 30px">
      <grid :rows="2">
        <grid-item v-for="(d,i) in shopDesks" :key="i">
        <div @click="pickDesk(d)">
          <desk :v="d" ></desk>
        </div>
        </grid-item>
      </grid>      
    </div>
    
  </div>
</template>

<script>
import { Group, Cell,Swiper,Datetime ,XButton,Grid, GridItem,Divider,Toast,XDialog, TransferDomDirective as TransferDom  } from 'vux'
import utils from '@/mixins/utils'
import desk from '@/components/sub/desk.vue'

export default {
  mixins: [utils],
  components: {
    Group,
    Cell,
    Swiper,
    desk,
    Datetime,
    XButton,
    Grid,
    GridItem,
    Divider,
    Toast,
    XDialog
  },
  directives: {
    TransferDom
  },
  data() {
    return {
      shopId: '',
      shopName: '',
      pickDate: this.getCurrentDate(),
      shopDesks: [],
      showPickPositions: false,
      selectedDesk: undefined,
      selectedPositions: [],
      toastMessage: '',
      showToastMessage: false
    }
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.pickDate = this.$route.params.pickDate;
      this.shopId = this.$route.params.shopId;
      this.shopName = this.$route.params.shopName;
      this.loadDesks();
    },
    loadDesks() {
      var url = this.apiServer + 'zy/ShopDesks';
      var data = {
        shopId: this.shopId,
        selectedDate: this.pickDate
      };
      var vm = this;
      this.$http.post(url, data)
        .then(res => {
          this.shopDesks = res.data;
        });
    },
    pickDesk(desk) {
      this.selectedDesk = desk;
      this.showPickPositions = true;
      this.$router.push({
                name:'deskPositions',
                params: {
                    deskId: desk.deskId, 
                    pickDate: this.pickDate,
                    deskName:desk.deskName,
                    unitPrice:desk.unitPrice
                }});
    }
  }
}
</script>

<style>

</style>
