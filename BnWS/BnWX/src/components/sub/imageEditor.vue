<template>
  <!-- <svg :width="width" :height="height" xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox">
	-->
  <svg xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox">
    
    <image :x="0" :y="0" :height="height" :width="width" v-bind:xlink:href="bgImg"></image>
      
    <image id='bnLogo' :x="logoX" :y="logoY" :height="logoHeight" :width="logoWidth" @mousedown="down"  @mouseup="up" v-bind:xlink:href="logoImg" @mouseover="isMouseOver=true" @mouseout="isMouseOver=false"
:style="{ cursor: logoCursor}"
    ></image>
  </svg>
</template>
<script>
export default {
  data() {
      return {
        isMoving:false,
        isResize:false,
        isMouseOver:false,
        startPosition:{x:0,y:0},
        logoX:100,
        logoY:100,
        logoWidth:200,
        logoHeight:200
      };
    },
    props: {
      width: { type: Number, default: 400 },
      height: { type: Number, default: 400 },
      bgImg:{type:String},
      logoImg:{type:String}
    },
    created() {
      this.init();
    },
    methods: {
      init(){
        window.addEventListener('mousemove',this.move,false);
      },
      up(){

        console.log('-----up-----')
        this.isMoving=false;
        this.isResize=false;
      },
      down(event){
        console.log(event)
        this.startPosition.x=parseInt(event.clientX);
        this.startPosition.y=parseInt(event.clientY);

        if(event.ctrlKey){

        this.isResize=true;
      }else{

        this.isMoving=true;
      }
      },
      move(event){

          var offSetX=event.clientX-this.startPosition.x;
          var offSetY=event.clientY-this.startPosition.y;
          this.startPosition.x=event.clientX;
          this.startPosition.y=event.clientY;
           // console.log({offSetX:offSetX,offSetY:offSetY})
           // console.log({logoX:this.logoX,logoY:this.logoY})
        if(this.isMoving&&!this.isResize){
          this.logoX+=offSetX;
          this.logoY+=offSetY;
        }
        if(this.isResize&&!this.isMoving){
          this.logoHeight+=offSetY;
          this.logoWidth+=offSetX
        }
      },
      getPosition(eid){
        var el=document.getElementById(eid);
        if(!el){
          return{x:0,y:0}
        }
        var xPos = (el.offsetLeft - el.scrollLeft + el.clientLeft);
     var yPos = (el.offsetTop - el.scrollTop + el.clientTop);
     return {x:xPos,y:yPos}
      }
    },
    computed: {
      viewBox() {
        return `0 0 ${this.width} ${this.height}`
      },
      logoCursor(){
        var set=10;
        // console.log(this.logoPosition.x+set)
        // console.log(this.logoPosition.x-set)
        // console.log(this.startPosition.x)
        if(this.logoPosition.x+set>this.startPosition.x
          &&this.logoPosition.x-set<this.startPosition.x
          &&this.logoPosition.y<this.startPosition.y
          &&this.logoPosition.y+this.logoHeight>this.startPosition.y){
          return "e-resize"
        }
        return this.isMouseOver?"move":"auto"
      },
      logoBorderCursor(){

      },
      logoPosition(){
        return this.getPosition('bnLogo');
      }

    },destory(){
      window.removeEventListener('mousemove',this.move)
    }
}
</script>
<style scoped>
svg {
  /*background-color: #555555*/
}
</style>
