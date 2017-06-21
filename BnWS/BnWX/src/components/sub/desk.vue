<template>
  <!-- <svg :width="width" :height="height" xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox">
	-->
  <svg xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox">
    <!-- <defs>
			<pattern id="tableImg" x="0" y="0" patternUnits="userSpaceOnUse" :height="height" :width="width">
				<image :x="cx-rdesk2" :y="cy-rdesk2" :height="2*rdesk2" :width="2*rdesk2" v-bind:xlink:href="bk_table"></image>
			</pattern>
		</defs>
		<circle :cx="cx" :cy="cy" :r="rdesk2" fill="url(#tableImg)" /> -->
    <image :x="cx-rdesk2" :y="cy-rdesk2" :height="2*rdesk2" :width="2*rdesk2" v-bind:xlink:href="bk_table"></image>
    <!-- <path v-for="item in pList" :d="trackPath" stroke-width="1" :fill="fillColor(item)" @click="positionClick(item)" stroke="#ffffff"  :transform="trans(item)" :id="'p_'+item"/> -->
    <!-- <text x="10" y="100" style="fill: #ffffff;" v-for="item in pList" :font-size="fontSize"  @click="positionClick(item)">
			<textPath v-bind:xlink:href="'#p_'+item">{{item}}</textPath>
		</text> -->
    <image v-for="item in pList" x="10" y="160" width="80" height="80" :transform="trans(item)" @click="positionClick(item)" v-bind:xlink:href="fillColor3(item)" />
  </svg>
</template>
<script>
export default {
  data() {
      return {
        temValue: undefined,
        visible: true,
        defaultValue: 'Empty',
        pList: [],
        selectedPosition: [],
        bk_table: require('@/assets/img/bk_table_240.png'),
        bk_pickedImg: require('@/assets/img/picked_80.png'),
        bk_bookedImg: require('@/assets/img/booked_80.png'),
        bk_absentImg: require('@/assets/img/absent_80.png'),
      };
    },
    props: {
      v: { default: { bookedPositions: '2,5' } },
      width: { type: Number, default: 400 },
      height: { type: Number, default: 400 },
      positions: { type: Number, default: 12 },
      avaliableColor: { type: String, default: '#0099FF' },
      selectedColor: { type: String, default: '#1122FF' },
      disableColor: { type: String, default: '#dddddd' },
      fontSize: { type: Number, default: 28 },
      readOnly: false
    },
    created() {
      // this.pList=range(1,this.positions)
      // console.log(this.pList)
      for (var i = 0; i < this.positions; i++) {
        var v = '' + (i + 1)
        this.pList.push(v);
      }
    },
    methods: {
      reset() {
        this.selectedPosition = [];
      },
      trans(i) {
        var x = this.cx;
        var y = this.cy;
        return `rotate(${this.a*i} ${x} ${y})`
      },
      booked(i) {
        return this.bookedList.indexOf(i + '') >= 0;
      },
      isSelected(i) {
        return this.selectedPosition.indexOf(i + '') >= 0;
      },
      fillColor(i) {
        return this.booked(i) ? this.disableColor : this.isSelected(i) ? this.selectedColor : this.avaliableColor
          // return "url("+this.booked(i)?"#bookedImg":this.isSelected(i)?"#pickedImg":"#absentImg"+")"
      },
      fillColor3(i) {
        // return this.booked(i)?this.disableColor:this.isSelected(i)?this.selectedColor:this.avaliableColor
        return this.booked(i) ? this.bk_bookedImg : this.isSelected(i) ? this.bk_pickedImg : this.bk_absentImg
      },
      positionClick(i) {
        if (this.readOnly == true)
          return
        if (this.booked(i))
          return;
        var index = this.selectedPosition.indexOf(i)
        if (index >= 0) {
          this.selectedPosition.splice(index, 1);
        } else {
          this.selectedPosition.push(i);
        }
        this.$emit('SelectedPostionChanged', this.selectedPosition);
      }
    },
    computed: {
      desk() {

      },
      viewBox() {
        return `0 0 ${this.width} ${this.height}`
      },
      a() {
        return 360.00 / this.positions;
      },
      r() {
        return parseFloat(this.width) / 2;
      },
      rdesk() {
        return parseFloat(this.width) / 2 * 0.7;
      },
      rdesk2() {
        return parseFloat(this.width) / 2 * 0.6;
      },
      cx() {
        return parseFloat(this.width) / 2;
      },
      cy() {
        return parseFloat(this.height) / 2;
      },
      trackPath() {
        var hudu = (2 * Math.PI / (parseFloat(360) / this.positions));
        var p1y = parseFloat(this.height) / 2;
        var p2x = this.r - this.r * Math.cos(hudu);
        var p2y = this.r + this.r * Math.sin(hudu);
        var p3x = this.r - this.rdesk * Math.cos(hudu);
        var p3y = this.r + this.rdesk * Math.sin(hudu);
        var p4x = parseFloat(this.width) / 2 - this.rdesk
        var p4y = parseFloat(this.height) / 2
        var p = `M0 ${p1y}
				A ${this.cx} ${this.cx}, 0, 0, 0, ${p2x} ${p2y}
				L${p3x} ${p3y}
				A ${this.rdesk} ${this.rdesk}, 0, 0, 1, ${p4x} ${p4y}
				Z`
        return p;
      },
      bookedList() {
        var bps = [];
        if (this.v.bookedPositions) {
          bps = this.v.bookedPositions.split(',');
        }
        return bps;
      },
      isAllBooked() {
        var vm = this;
        return this.pList.filter((x) => !vm.booked(x)).length == 0
      },
      fillColor2() {
        return this.isAllBooked ? this.disableColor : this.avaliableColor
      }
    }
}
</script>
<style scoped>
svg {
  /*background-color: #555555*/
}
</style>
