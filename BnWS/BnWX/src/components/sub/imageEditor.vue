<template>
  <!-- <svg :width="width" :height="height" xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox">
	-->
  <svg xmlns="http://www.w3.org/2000/svg" :viewBox="viewBox">
    
    <image :x="0" :y="0" :height="height" :width="width" v-bind:xlink:href="bgImg"></image>
      
    <image :x="logoX" :y="logoY" :height="logoHeight" :width="logoWidth" @mousedown="down"  @mouseup="up" v-bind:xlink:href="logoImg" @mouseover="isMouseOver=true" @mouseout="isMouseOver=false"
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
        startPosition:{},
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
           console.log({offSetX:offSetX,offSetY:offSetY})
           console.log({logoX:this.logoX,logoY:this.logoY})
        if(this.isMoving&&!this.isResize){
          this.logoX+=offSetX;
          this.logoY+=offSetY;
        }
        if(this.isResize&&!this.isMoving){
          this.logoHeight+=offSetY;
          this.logoWidth+=offSetX
        }
      }
    },
    computed: {
      viewBox() {
        return `0 0 ${this.width} ${this.height}`
      },
      logoCursor(){
        return this.isMouseOver?"move":"auto"
      },
      logoBorderCursor(){

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
