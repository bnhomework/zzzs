<template>
  <svg xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox" v-finger:pinch="pinch" v-finger:press-move="pressMove" v-finger:rotate="rotate"
  v-finger:touch-start="touchStart" v-finger:touch-end="touchEnd">
    <defs>
      <clipPath id="areaPath">
        <path :d="areaBoarderPath" />
      </clipPath>
    </defs>

    <image :x="0" :y="0" :height="height" :width="width" v-bind:xlink:href="bgImg"></image>
    <image :clip-path="printArea" id='bnLogo' @click="onlogoclick" :x="logo.x" :y="logo.y" :width="logo.width" :height="logo.height" v-bind:xlink:href="logoImg" v-show="logoImg!=''">
    </image>
    <text :clip-path="printArea" :x="txtLogo.x" @click="onlogotextclick" :font-size="txtLogo.fontSize"  :y="txtLogo.y" :transform="textRotate" :style="textStyle" text-anchor="middle" v-show="txtLogo!=undefined">{{txtLogoText}}</text>
    <path :d="areaBoarderPath" :style="borderStyle" v-show="showPrintArea&&!readOnly"></path>
  </svg>
</template>
<script>
export default {
  data() {
      return {
        isMoving: false,
        isResize: false,
        isMouseOver: false,
        startPosition: {
          x: 0, 
          y: 0
        },
        logo: {
          x: 100,
          y: 100,
          width: 200,
          height: 200
        },
        txtLogo: {
          x: 200,
          y: 200,
          angle: 0,
          color: '#000000',
          fontFamily: 'Times New Roman',
          fontSize:20
        },
        borderStyle: 'stroke:#d3d3d3;stroke-width:2;stroke-dasharray:10;stroke-linejoin = round;fill:none',
        showPrintArea:false
      };
    },
    props: {
      width: {
        type: Number,
        default: 400
      },
      height: {
        type: Number,
        default: 400
      },
      areaBoarderPath:{
        type:String,
        default:'M 100 100 L300 100 L300 300 L100 300 Z'
      },
      bgImg: {
        type: String
      },
      txtLogoText: {
        type: String
      },
      logoImg: {
        type: String
      },
      controlElementId: {
        type: Number,
        default: 1
      },
      readOnly: {
        type: Boolean,
        default: false
      }
    },
    created() {
      this.init();
    },

    methods: {
      init() {

      },
      touchStart(){
        this.showPrintArea=true;
      },
      touchEnd(){
        this.showPrintArea=false;
      },
      pressMove: function(evt) {
        if (this.readOnly)
          return
        var offset=10;
        var x=this.controlElement.x+evt.deltaX;
        var y=this.controlElement.y+evt.deltaY;
        var width=this.controlElement.width||0;
        var height=this.controlElement.height||0;
        if(x<(0-width+offset)||x>(this.width-offset)
          ||y<(0-height+offset)||y>(this.height-offset))
          return;
        this.controlElement.x += evt.deltaX;
        this.controlElement.y += evt.deltaY;
      },
      pinch: function(evt) {
        if (this.readOnly)
          return
        if (this.controlElement == this.logo) {
          var el = this.controlElement;
          var s = 1;
          var offsetX = 0;
          var offsetY = 0;
          var z = 10.00;
          if (evt.scale > 1) {
            s = 1.0 + (evt.scale - 1) / z;
            offsetX = 0 - (this.controlElement.width * (evt.scale - 1) / z) / 2.00;
            offsetY = 0 - (this.controlElement.height * (evt.scale - 1) / z) / 2.00;
          }
          else {
            s = 1.0 - (1.0 - evt.scale) / z;
            offsetX = (this.controlElement.width * (1.0 - evt.scale) / z) / 2.00;
            offsetY = (this.controlElement.height * (1.0 - evt.scale) / z) / 2.00;
          }

          // if(this.controlElement.height * s>=this.height*0.8||this.controlElement.width * s>=this.width*0.8)
          //   return
          this.controlElement.height = this.controlElement.height * s;
          this.controlElement.width = this.controlElement.width * s;
          this.controlElement.x += offsetX;
          this.controlElement.y += offsetY;

        }
        else {
          var z = 10.00;
          var s = 1;
          if (evt.scale > 1) {
            s = 1.0 + (evt.scale - 1) / z;
          }else{
            s = 1.0 - (1.0 - evt.scale) / z;
          }
          if(s<1.005&&s>0.995){
            return
          }
          var tmp=this.txtLogo.fontSize*s;
          if(tmp>200||tmp<5)
            return
          this.txtLogo.fontSize=tmp;
        }
      },
      rotate: function(evt) {
        if (this.readOnly)
          return
        if (this.controlElement == this.logo) {}
        else {
          if(evt.angle<0.2&&evt.angle>-0.2)
            return
          var a = this.controlElement.angle || 0;
          this.controlElement.angle = a + evt.angle;
        }
      },
      onlogotextclick(){
        this.$emit('onlogotextclick');
      },
      onlogoclick(){
        this.$emit('onlogoclick');
      },
      getSettings(){
        return{logo:this.logoImg,logoText:this.logoText};
      }

    },
    computed: {
      viewBox() {
        return `0 0 ${this.width} ${this.height}`
      },
      printArea(){
        if(this.readOnly||!this.showPrintArea){
          return "url(#areaPath)"
        }else{
          return ""
        }
      },
      // areaBoarderPath() {
      //   var A = {
      //     x: this.logo.x,
      //     y: this.logo.y
      //   };
      //   var B = {
      //     x: this.logo.x + this.logo.width,
      //     y: this.logo.y
      //   };
      //   var C = {
      //     x: this.logo.x + this.logo.width,
      //     y: this.logo.y + this.logo.height
      //   };
      //   var D = {
      //     x: this.logo.x,
      //     y: this.logo.y + this.logo.height
      //   };
      //   var p = {
      //     top: `M${A.x} ${A.y} L${B.x} ${B.y}`,
      //     right: `M${B.x} ${B.y} L${C.x} ${C.y}`,
      //     bottom: `M${C.x} ${C.y} L${D.x} ${D.y}`,
      //     left: `M${D.x} ${D.y} L${A.x} ${A.y}`,
      //   }
      //   return `M${A.x} ${A.y} L${B.x} ${B.y} L${C.x} ${C.y} L${D.x} ${D.y} L${A.x} ${A.y}`
      // },
      textRotate() {
        var x = this.txtLogo.x || 100;
        var y = this.txtLogo.y || 100;
        var ag = this.txtLogo.angle || 0;
        return `rotate(${ag},${x} ${y})`;
      },
      textStyle() {
        var color = this.txtLogo.color || "#000000"
        var fontFamily = this.txtLogo.fontFamily || "Times New Roman";
        var fontSize=this.txtLogo.fontSize||20;
        return `font-family: ${fontFamily};stroke:none; fill:${color};`
      },
      controlElement() {
        if (this.controlElementId == 1) {
          return this.logo;
        }
        else {
          return this.txtLogo;
        }
      }
    },
    mounted() {

    },
    destory() {}
}
</script>
<style scoped>
svg {
  /*background-color: #555555*/
}
</style>
