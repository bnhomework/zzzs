<template>
  <div style="overflow-x:hidden;width:100%">
    <div class="popup-address-container">
      <div @click="onShowAddressDetail" style="line-height:80px;padding:5px">
        <span class="bn-icon">&#xe622;</span><span>  创建新的收货地址</span>
      </div>
      <div style="width: 100%;height: 21px;background-repeat:repeat-x;" :style="{backgroundImage: 'url(' + eb + ')'}"></div>
    </div>
    <div>
      <div v-for="item in addressListOptions" class="address-warp">
      	<div class="right-action" @click="deleteAddress(item.key)"><span class="bn-icon">&#xe61a;</span></div>
        <div class="address-title">{{item.value}}</div>
        <div class="address-title">{{item.phone}}</div>
        <div class="address-detail">{{item.inlineDesc}}</div>
      </div>
    </div>
    <div v-transfer-dom>
      <popup v-model="showAddressDetail" is-transparent>
        <div style="width: 100%;background-color:#fff;height:100%;margin:0 auto;">
          <!--  -->
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
  Checklist,
  XInput,
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
    Checklist,
    XInput
  },
  data() {
    return {
      addressList: [],
      selectedAddress: undefined,
      addressData: ChinaAddressV3Data,
      showAddressDetail: false,
      newAddress: {},
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
        });
    },
    onShowAddressDetail() {
      this.showAddressDetail = true;
      this.newAddress = {};
    },
    saveNewAddress() {
      //todo save new address
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
          }
        });
    },
    deleteAddress(addressId){
    	var vm=this;
    	var url = this.apiServer + 'zz/DeleteAddress';
      var data = { addressId: addressId }
      this.$http.post(url, data)
        .then(res => {
          var index=_.findIndex(vm.addressList,function(x){return x.AddressId==addressId});
          vm.addressList.splice(index,1)
        });
    },
    addressConvertToName(id) {
      var vm = this;
      var tmp = _.filter(vm.addressData, function(x) { return x.value == id });
      if (tmp.length > 0) {
        return tmp[0].name;
      }
      return '';
    }
  },
  computed: {
    addressListOptions() {
      return _.map(this.addressList, function(a) {
        return {
          key: a.AddressId,
          value: '收件人：'+a.ContactName  ,
          phone:' 联系电话：' + a.Phone,
          inlineDesc: '地址：'+a.Province + ' ' +
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
  min-height: 100px;
  background-color: #e7e8eb;
  /*padding: 10px;*/
  position: relative;
}

.address-warp {
  padding: 10px;
  background-color: #ffffff;
  border-radius: 5px;
  margin: 5px;
}
.right-action{
	display: inline-block;
	float: right;
}

</style>
