<template>
  <div class="popup-address-container">
    <div v-if="addressList.length==0" @click="addNewAddress">
      <span class="bn-icon">&#xe622;</span><span>创建新的收货地址</span>
    </div>
    <div v-if="addressList.length>0" @click="popupAddressList">
      <div class="content-1">
        <span class="bn-icon">&#xe621;</span>
        <span>{{selectedAddress.ContactName}}</span>
        <span style="float: right;">{{selectedAddress.Phone}}</span>
      </div>
      <div class="content-2">{{selectedAddress.Province}} {{selectedAddress.City}} {{selectedAddress.Town}} {{selectedAddress.AddressLine1}}</div>
    </div>
    <div></div>
    <div v-transfer-dom>
      <popup v-model="showAddressList" is-transparent>
        <div style="width: 100%;background-color:#fff;height:300px;margin:0 auto;">
          <checklist title="请选择地址" :options="addressListOptions" v-model="selectedAddressId"  @on-change="changeSelectedAddress"></checklist>
          <div @click="addNewAddress"><span class="bn-icon">&#xe622;</span><span>创建新的收货地址</span></div>
        </div>
      </popup>
    </div>
    <div v-transfer-dom>
      <popup v-model="showAddressDetail" is-transparent>
        <div style="width: 100%;background-color:#fff;height:300px;margin:0 auto;">
          <div style="text-align: center"><span>新建收件地址</span><span class="bn-icon pull-right" @click="showAddressDetail=false">&#xe633;</span></div>
          <group>
            <cell title="收件人" :value="newAddress.ContactName"></cell>
            <cell title="联系电话" :value="newAddress.Phone"></cell>
            <x-address title="选择地区" v-model="newAddress.AddressLine" raw-value :list="addressData"></x-address>
            <cell title="详细地址" :value="newAddress.AddressLine1"></cell>
            <cell title="邮编(可选填)" :value="getName(newAddress.ZipCode)"></cell>
          </group>
          <div style="padding: 0 15px;">
            <x-button type="primary" @click.native="saveNewAddress">保存地址</x-button>
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
  Checklist
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
    Checklist
  },
  data() {
    return {
      addressList: [],
      selectedAddress: undefined,
      addressData: ChinaAddressV3Data,
      showAddressDetail: false,
      showAddressList: false,
      newAddress: {},
      selectedAddressId:[]
    }
  },
  created() {
    this.loadAddress();
  },
  methods: {
    loadAddress() {
    	var vm=this;
    	var openId=this.$store.state.bn.openId;
    	var url=this.apiServer + 'zz/GetCustomerAddressList';;
    	var data={customerId:openId}
    	this.$http.post(url, data)
        .then(res => {
          vm.addressList=res.data;
        });
    },
    popupAddressList(){
	  this.showAddressList = true;
      this.showAddressDetail = true;
      this.selectedAddressId=[];
      this.selectedAddressId.push(this.selectedAddress.AddressId);
    },
    changeSelectedAddress(v){
    	var aid=v;
      this.selectedAddressId=[];
      this.selectedAddressId.push(aid);
      var tmp=_.filter(this.addressList,function(x){
      	return x.AddressId==aid;
      })
      if(tmp.length>0){
      	this.selectedAddress=tmp[0];
      }
    }
    addNewAddress() {
      this.newAddress = {};
      this.showAddressList = false;
      this.showAddressDetail = true;
    },
    saveNewAddress() {
      //todo save new address
      var vm = this;
      var address = {
        ContactName: vm.newAddress.ContactName,
        Phone: vm.newAddress.Phone,
        Province: vm.newAddress.AddressLine[0],
        City: vm.newAddress.AddressLine[1],
        Town: vm.newAddress.AddressLine[2],
        AddressLine1: vm.newAddress.AddressLine1,
        ZipCode: vm.newAddress.ZipCode
      };

    	var openId=this.$store.state.bn.openId;
    	var url=this.apiServer + 'zz/SaveCustomerAddress';;
    	var data={customerId:openId,address:address}
    	this.$http.post(url, data)
        .then(res => {
          vm.addressList=res.data;
        });

      vm.selectedAddress = address;
      // vm.selectedAddressId=vm.selectedAddress.AddressId;
      vm.addressList.unshift(address);
    }
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
  min-height: 150px;
  background-color: #e7e8eb;
  padding: 10px;
}

</style>
