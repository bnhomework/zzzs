<template>
  <svg xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox" v-finger:pinch="pinch" v-finger:press-move="pressMove" v-finger:rotate="rotate">
    <image :x="0" :y="0" :height="height" :width="width" v-bind:xlink:href="bgImg"></image>
    <path :d="areaBoarderPath" :style="borderStyle"></path>
    <image id='bnLogo' :x="logo.x" :y="logo.y" :width="logo.width" :height="logo.height" v-bind:xlink:href="logoImg" v-show="logoImg!=undefined">
    </image>
    <text :x="txtLogo.x" :y="txtLogo.y" :transform="textRotate" :style="textStyle" v-show="txtLogo!=undefined">{{txtLogoText}}</text>
  </svg>
</template>
<script>
export default {
  data() {
      return {
        isMoving: false,
        isResize: false,
        isMouseOver: false,
        startPosition: { x: 0, y: 0 },
        logo: { x: 100, y: 100, width: 200, height: 200 },
        txtLogo: { x: 100, y: 100, angle: 0, color: '#000000',fontFamily:'Times New Roman' },
        borderStyle: '`stroke:#000000;stroke-width:0.4;stroke-dasharray:10;stroke-linejoin = round`'
      };
    },
    props: {
      width: { type: Number, default: 400 },
      height: { type: Number, default: 400 },
      bgImg: { type: String },
      txtLogoText:{type:String},
      logoImg: { type: String },
      controlElementId:{type:Number,default:1},
      readOnly:{type:Boolean,default:false}
    },
    created() {
      this.init();
    },

    methods: {
      init() {

      },
      pressMove: function(evt) {
        if(this.readOnly)
          return
        this.controlElement.x += evt.deltaX;
        this.controlElement.y += evt.deltaY;
      },
      pinch: function(evt) {
        if(this.readOnly)
          return
        var el = this.controlElement;
        var s = 1;
        var offsetX = 0;
        var offsetY = 0;
        var z = 10.00;
        if (evt.scale > 1) {
          s = 1.0 + (evt.scale - 1) / z;
          offsetX = 0 - (this.controlElement.width * (evt.scale - 1) / z) / 2.00;
          offsetY = 0 - (this.controlElement.height * (evt.scale - 1) / z) / 2.00;
        } else {
          s = 1.0 - (1.0 - evt.scale) / z;
          offsetX = (this.controlElement.width * (1.0 - evt.scale) / z) / 2.00;
          offsetY = (this.controlElement.height * (1.0 - evt.scale) / z) / 2.00;
        }
        this.controlElement.height = this.controlElement.height * s;
        this.controlElement.width = this.controlElement.width * s;
        this.controlElement.x += offsetX;
        this.controlElement.y += offsetY;
      },
      rotate:function(evt){
        if(this.readOnly)
          return
          var a=this.controlElement.angle||0;
          this.controlElement.angle=a+evt.angle;
          console.log(evt.angle);
          console.log('onRotate'); 
      }

    },
    computed: {
      viewBox() {
        return `0 0 ${this.width} ${this.height}`
      },
      areaBoarderPath() {
        var A = { x: this.logo.x, y: this.logo.y };
        var B = { x: this.logo.x + this.logo.width, y: this.logo.y };
        var C = { x: this.logo.x + this.logo.width, y: this.logo.y + this.logo.height };
        var D = { x: this.logo.x, y: this.logo.y + this.logo.height };
        var p = {
          top: `M${A.x} ${A.y} L${B.x} ${B.y}`,
          right: `M${B.x} ${B.y} L${C.x} ${C.y}`,
          bottom: `M${C.x} ${C.y} L${D.x} ${D.y}`,
          left: `M${D.x} ${D.y} L${A.x} ${A.y}`,
        }
        return `M${A.x} ${A.y} L${B.x} ${B.y} L${C.x} ${C.y} L${D.x} ${D.y} L${A.x} ${A.y}`
      },
      textRotate() {
        var x = this.txtLogo.x || 100;
        var y = this.txtLogo.y || 100;
        var ag = this.txtLogo.angle || 0;
        return `rotate(${ag} ${x},${y})`;
        // return `rotate(${x} ${y},${ag})`;
      },
      textStyle() {
        var color = this.txtLogo.color || "#000000"
        var fontFamily=this.txtLogo.fontFamily||"Times New Roman";
        return `font-family: ${fontFamily}; stroke:none; fill:${color};`
      },
      controlElement() {
        if(this.controlElementId==1){
          return this.logo;
        }else{
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
