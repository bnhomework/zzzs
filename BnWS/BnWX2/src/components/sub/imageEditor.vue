<template>
  <svg xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox" v-finger:pinch="pinch">
    <image :x="0" :y="0" :height="height" :width="width" v-bind:xlink:href="bgImg"></image>
    <path :d="borderPath.top" :style="borderStyle('n-resize')" @mousedown="down2"></path>
    <path :d="borderPath.right" :style="borderStyle('e-resize')" @mousedown="down2"></path>
    <path :d="borderPath.bottom" :style="borderStyle('n-resize')" @mousedown="down2"></path>
    <path :d="borderPath.left" :style="borderStyle('e-resize')" @mousedown="down2"></path>

    <path :d="borderPath.top" :style="borderStyle2()" @mousedown="down2"></path>
    <path :d="borderPath.right" :style="borderStyle2()" @mousedown="down2"></path>
    <path :d="borderPath.bottom" :style="borderStyle2()" @mousedown="down2"></path>
    <path :d="borderPath.left" :style="borderStyle2()" @mousedown="down2"></path>
    <image id='bnLogo' :x="logo.x" :y="logo.y" :width="logo.width" :height="logo.height" v-bind:xlink:href="logoImg" 
    @mouseover="isMouseOver=true" @mouseout="isMouseOver=false" :style="{ cursor: logoCursor}"  @mousedown="down" @mouseup="up"
v-finger:press-move="pressMove"

    ></image>
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
        logo:{x:100,y:100,width:200,height:200},
        logoNaturalSize:{x:1,y:1}
      };
    },
    props: {
      width: { type: Number, default: 400 },
      height: { type: Number, default: 400 },
      bgImg: { type: String },
      logoImg: { type: String }
    },
    created() {
      this.init();
    },

    methods: {
      init() {
        window.addEventListener('mousemove', this.move, false);
        window.addEventListener('mouseup', this.up, false);
      },
      pressMove: function(evt) { 
            this.logo.x += evt.deltaX;
          this.logo.y += evt.deltaY;
            console.log('onPressMove'); 
        },
         pinch: function(evt) { 
          var s=1;
          if(evt.scale>1){
            s=1.0+(evt.scale-1)/10.00;
          }else{
            s=1.0-(1.0-evt.scale)/10.00;
          }
           this.logo.height= this.logo.height*s;
           this.logo.width= this.logo.width*s;
        },

      borderStyle(cursor){
        return  `stroke:transparent;stroke-width:20;cursor:${cursor}`
      },
      borderStyle2(){
        return  `stroke:#000000;stroke-width:0.4;stroke-dasharray:10;stroke-linejoin = round`
      },
      up() {

        console.log('-----up-----')
        this.isMoving = false;
        this.isResize = false;
      },
      down(event) {
        console.log(event)
        this.startPosition.x = parseInt(event.clientX);
        this.startPosition.y = parseInt(event.clientY);
        this.isMoving = true;
      },
      down2(event) {
        this.startPosition.x = parseInt(event.clientX);
        this.startPosition.y = parseInt(event.clientY);
        this.isResize = true;        
      },
      move(event) {

        var offSetX = event.clientX - this.startPosition.x;
        var offSetY = event.clientY - this.startPosition.y;
        this.startPosition.x = event.clientX;
        this.startPosition.y = event.clientY;
        if (this.isMoving && !this.isResize) {
          this.logo.x += offSetX;
          this.logo.y += offSetY;
        }
        if (this.isResize && !this.isMoving) {
          this.logo.height += offSetY;
          this.logo.width += offSetX
        }
      },
      getPosition(eid) {
        var el = document.getElementById(eid);
        if (!el) {
          return { x: 0, y: 0 }
        }
        var xPos = (el.offsetLeft - el.scrollLeft + el.clientLeft);
        var yPos = (el.offsetTop - el.scrollTop + el.clientTop);
        return { x: xPos, y: yPos }
      }
    },
    computed: {
      viewBox() {
        return `0 0 ${this.width} ${this.height}`
      },
      borderPath(){
        var A={x:this.logo.x,y:this.logo.y};
        var B={x:this.logo.x+this.logo.width,y:this.logo.y};
        var C={x:this.logo.x+this.logo.width,y:this.logo.y+this.logo.height};
        var D={x:this.logo.x,y:this.logo.y+this.logo.height};
        var p= {
          top:`M${A.x} ${A.y} L${B.x} ${B.y}`,
          right:`M${B.x} ${B.y} L${C.x} ${C.y}`,
          bottom:`M${C.x} ${C.y} L${D.x} ${D.y}`,
          left:`M${D.x} ${D.y} L${A.x} ${A.y}`,
        }
        return p
      },
      logoCursor() {
        var set = 10;
        if (this.logoPosition.x + set > this.startPosition.x && this.logoPosition.x - set < this.startPosition.x && this.logoPosition.y < this.startPosition.y && this.logoPosition.y + this.logoHeight > this.startPosition.y) {
          return "e-resize"
        }
        return this.isMouseOver ? "move" : "auto"
      },
      logoPosition() {
        return this.getPosition('bnLogo');
      }

    },
    mounted(){

    }, 
    destory() {
      window.removeEventListener('mousemove', this.move)
        window.removeEventListener('mouseup', this.up);
    }
}
</script>
<style scoped>
svg {
  /*background-color: #555555*/
}
</style>
