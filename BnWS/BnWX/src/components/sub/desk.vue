<template>
		<!-- <svg :width="width" :height="height" xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox"> -->
		<svg xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox">
		<circle :cx="cx" :cy="cy" :r="rdesk2" :fill="fillColor2"/>
		  <path v-for="item in pList" :d="trackPath" stroke-width="1" :fill="fillColor(item)" stroke="#ffffff"  :transform="trans(item)" :id="'p_'+item"/>
		<text x="10" y="100" style="fill: #ffffff;" v-for="item in pList" :font-size="fontSize">
		    <textPath v-bind:xlink:href="'#p_'+item">
		        {{item}}
		    </textPath>
		</text>          
		</svg>
</template>
<script>
	export default{
		data (){
			return {
				temValue:undefined,
				visible:true,
				defaultValue:'Empty',
				pList:[]
			};
		},
		props:{
			v:{default:{bookedPositions:'2,5'}},
			width:{type:Number,default:400},
			height:{type:Number,default:400},
			positions:{type:Number,default:12},
			avaliableColor:{type:String,default:'#0099FF'},
			disableColor:{type:String,default:'#dddddd'},
			fontSize:{type:Number,default:28}
		},
		created(){
			// this.pList=range(1,this.positions)
			// console.log(this.pList)
			for (var i = 0; i <this.positions; i++) {
				this.pList.push(i+1);
			}
		},
		methods:{
			trans(i){
				var x=this.cx;
				var y=this.cy;
				return `rotate(${this.a*i} ${x} ${y})`
			},
			booked(i){
				return this.bookedList.indexOf(i+'')>=0;
			},
			fillColor(i){
				return this.booked(i)?this.disableColor:this.avaliableColor
			}
		},
		computed:{
			desk(){

			},
			viewBox(){
				return `0 0 ${this.width} ${this.height}`
			},
			a(){
				return 360.00/this.positions;
			},
			r(){
				return parseFloat(this.width)/2;
			},
			rdesk(){
				return parseFloat(this.width)/2*0.7;
			},
			rdesk2(){
				return parseFloat(this.width)/2*0.6;
			},
			cx(){
				return parseFloat(this.width)/2;
			},
			cy(){
				return parseFloat(this.height)/2;
			},
			trackPath(){
				var hudu=(2*Math.PI/(parseFloat(360)/this.positions));
				var p1y=parseFloat(this.height)/2;
				var p2x=this.r- this.r*Math.cos(hudu);
				var p2y=this.r+ this.r*Math.sin(hudu);
				var p3x=this.r- this.rdesk*Math.cos(hudu);
				var p3y=this.r+ this.rdesk*Math.sin(hudu);
				var p4x=parseFloat(this.width)/2-this.rdesk
				var p4y=parseFloat(this.height)/2
				var p= `M0 ${p1y}
				A ${this.cx} ${this.cx}, 0, 0, 0, ${p2x} ${p2y}
				L${p3x} ${p3y}
				A ${this.rdesk} ${this.rdesk}, 0, 0, 1, ${p4x} ${p4y}
				Z`
			     return p;
			},
			bookedList(){
				var bps=[];
				if(this.v.bookedPositions){
					bps=this.v.bookedPositions.split(',');
				}
				return bps;
			},
			isAllBooked(){
				var vm=this;
				return this.pList.filter((x)=>!vm.booked(x)).length==0
			},
			fillColor2(){
				return this.isAllBooked?this.disableColor:this.avaliableColor
			}
		}
	}
</script>
<style scoped>
	svg{
		/*background-color: #555555*/
	}
</style>