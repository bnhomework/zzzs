<template>
  <div class="popup-address-container">
    <div v-if="addressList.length==0" @click="addNewAddress" style="line-height:80px;padding:5px">
      <span class="bn-icon">&#xe622;</span><span>   创建新的收货地址</span>
    </div>
    <div v-if="addressList.length>0&&selectedAddress!=undefined" @click="popupAddressList" style="line-height:40px;min-height:80px;padding:5px">
      <div class="content-1">
        <span class="bn-icon">&#xe621;</span>
        <span>{{selectedAddress.ContactName}}</span>
        <span style="float: right;margin-right:20px">{{selectedAddress.Phone}}</span>
      </div>
      <div class="content-2" style="line-height:normal;margin-right:15px">{{selectedAddress.Province}} {{selectedAddress.City}} {{selectedAddress.Town}} {{selectedAddress.AddressLine1}}</div>
    </div>
    <div style="width: 100%;height: 10px; background-repeat:repeat-x;" :style="{backgroundImage: 'url(' + eb + ')'}"></div>
    <div v-transfer-dom>
      <popup v-model="showAddressList" is-transparent>
        <div style="width: 100%;background-color:#fff;height:300px;margin:0 auto;">
          <div class="vux-popup-picker-header">
            <div class="vux-flexbox vux-flex-row">
              <div class="vux-flexbox-item vux-popup-picker-header-menu vux-popup-picker-cancel" style="margin-left: 8px;" @click="showAddressList=false">取消</div>
              <div class="vux-flexbox-item vux-popup-picker-header-menu vux-popup-picker-header-menu-right" style="margin-left: 8px;" @click="showAddressList=false">完成</div>
            </div>
          </div>
          <div style="height:210px;overflow-y:auto">
            <radio title="请选择地址" :options="addressListOptions" :value="selectedAddressId" @on-change="changeSelectedAddress"></radio>
          </div>
          <div @click="addNewAddress"><span class="bn-icon">&#xe622;</span><span>创建新的收货地址</span></div>
        </div>
      </popup>
    </div>
    <div v-transfer-dom>
      <popup v-model="showAddressDetail" is-transparent>
        <div style="width: 100%;background-color:#fff;height:100%;margin:0 auto;">
          <!-- <div style="text-align: center;padding-top:10px"><span>新建收件地址</span><span class="bn-icon pull-right" style="padding-right:15px" @click="showAddressDetail=false">&#xe633;</span></div> -->
          <div class="vux-popup-picker-header">
            <div class="vux-flexbox vux-flex-row">
              <div class="vux-flexbox-item vux-popup-picker-header-menu vux-popup-picker-cancel" style="margin-left: 8px;" @click="showAddressDetail=false">取消</div>
              <div class="vux-flexbox-item vux-popup-picker-header-menu vux-popup-picker-header-menu-right" style="margin-left: 8px;" @click="saveNewAddress">保存</div>
            </div>
          </div>
          <div style="text-align: center;padding-top:10px"><span>新建收件地址</span></div>
          <group>
            <x-input title="收件人" v-model="newAddress.ContactName"></x-input>
            <x-input title="联系电话" v-model="newAddress.Phone"></x-input>
            <x-address title="选择地区" v-model="newAddress.AddressLine" raw-value :list="addressData"></x-address>
            <x-input title="详细地址" v-model="newAddress.AddressLine1"></x-input>
          </group>
          <div style="padding: 0 15px;margin:10px">
            <!-- <x-button type="primary" @click.native="saveNewAddress">保存地址</x-button> -->
          </div>
        </div>
      </popup>
    </div>
  </div>
</template>
<script>
import {
  TransferDom,
  Popup,
  Group,
  XAddress,
  ChinaAddressV3Data,
  Cell,
  XButton,
  XInput,
  Radio,
} from 'vux'
import _ from 'underscore'
import utils from '@/mixins/utils'
export default {
  mixins: [utils],
  directives: {
    TransferDom
  },
  components: {
    Popup,
    Group,
    Cell,
    XAddress,
    XButton,
    XInput,
    Radio
  },
  data() {
    return {
      addressList: [],
      selectedAddress: undefined,
      addressData: ChinaAddressV3Data,
      showAddressDetail: false,
      showAddressList: false,
      newAddress: {},
      selectedAddressId: '',
      eb:require('@/assets/img/e.jpg')
    }
  },
  created() {
    this.loadAddress();
  },
  methods: {
    loadAddress() {
      var vm = this;
      var openId = this.$store.state.bn.openId;
      var url = this.apiServer + 'zz/GetCustomerAddress';;
      var data = { openId: openId }
      this.$http.post(url, data)
        .then(res => {
          vm.addressList = res.data;
          if (vm.addressList.length > 0) {
            vm.selectedAddress = vm.addressList[0];
            vm.selectedAddressId = vm.selectedAddress.AddressId;
          }
        });
    },
    popupAddressList() {
      this.showAddressList = true;
      this.showAddressDetail = false;
      this.selectedAddressId = this.selectedAddress.AddressId;
    },
    changeSelectedAddress(v) {
      var vm = this;
      var aid = v;
      if (aid != '') {
        var tmp = _.filter(vm.addressList, function(x) {
          return x.AddressId == aid;
        })
        if (tmp.length > 0) {
          vm.selectedAddress = tmp[0];
        }
      }
    },
    addNewAddress() {
      this.newAddress = {};
      this.showAddressList = false;
      this.showAddressDetail = true;
    },
    saveNewAddress() {
      var vm = this;
      var openId = this.$store.state.bn.openId;
      if (vm.newAddress.ContactName == undefined || vm.newAddress.ContactName == '' ||
        vm.newAddress.Phone == undefined || vm.newAddress.Phone == '' ||
        vm.newAddress.AddressLine1 == undefined || vm.newAddress.AddressLine1 == '' ||
        vm.newAddress.AddressLine == undefined || vm.newAddress.AddressLine.length != 3
      ) {
        vm.$vux.toast.show({
          text: '请填写完整地址',
          type: 'cancel'
        })
        return false;
      }
      var address = {
        ContactName: vm.newAddress.ContactName,
        Phone: vm.newAddress.Phone,
        Province: this.addressConvertToName(vm.newAddress.AddressLine[0]),
        City: this.addressConvertToName(vm.newAddress.AddressLine[1]),
        Town: this.addressConvertToName(vm.newAddress.AddressLine[2]),
        AddressLine1: vm.newAddress.AddressLine1,
        CustomerId: openId
      };
      var url = this.apiServer + 'zz/UpdateAddress';
      var data = { address: address }
      this.$http.post(url, data)
        .then(res => {
          if (address.AddressId == undefined) {
            address.AddressId = res.data;
            vm.addressList.unshift(address);
            vm.showAddressDetail = false;
            vm.selectedAddress = vm.addressList[0];
            vm.selectedAddressId = vm.selectedAddress.AddressId;
          }
        });
    },
    addressConvertToName(id) {
      var vm = this;
      var tmp = _.filter(vm.addressData, function(x) { return x.value == id });
      if (tmp.length > 0) {
        return tmp[0].name;
      }
      return '';
    },
  },
  computed: {
    addressListOptions() {
      return _.map(this.addressList, function(a) {
        return {
          key: a.AddressId,
          value: a.ContactName + ',' + a.Phone,
          inlineDesc: a.Province + ' ' +
            a.City + ' ' +
            a.Town + ' ' +
            a.AddressLine1 + ' '
        }
      });
    }
  }
}

</script>
<style scoped>
.popup-address-container {
  width: 100%;
  overflow-x: hidden;
  min-height: 100px;
  background-color: #e7e8eb;
}

</style>
