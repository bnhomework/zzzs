<template>
  <filter :id="id">
    <!-- Colors: -->
    <feFlood flood-color="#4CFED7" flood-opacity="1" result="COL_green-l"></feFlood>
    <feFlood flood-color="#0A4D39" flood-opacity="1" result="COL_green-m"></feFlood>
    <feFlood flood-color="#2A9B83" flood-opacity="1" result="COL_green-d"></feFlood>
    <feFlood flood-color="#FA5C71" flood-opacity="1" result="COL_red-l"></feFlood>
    <feFlood flood-color="#A5122B" flood-opacity="1" result="COL_red-d"></feFlood>
    <feFlood flood-color="rgba(0,0,0,0)" flood-opacity="0" result="TRANSPARENT"></feFlood>
    <!-- Colors end -->
    <!-- Lower Green Bevel -->
    <feMorphology operator="dilate" radius="10" in="SourceAlpha" result="GREEN-BEVEL-1_10"></feMorphology>
    <feConvolveMatrix order="8,8" divisor="1" kernelMatrix="1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1" in="GREEN-BEVEL-1_10" result="GREEN-BEVEL-1_20"></feConvolveMatrix>
    <feComposite operator="in" in="COL_green-d" in2="GREEN-BEVEL-1_20" result="GREEN-BEVEL-1_30"></feComposite>
    <!-- Lower Green Bevel End -->
    <!-- Lower Green Front -->
    <feComposite operator="in" in="COL_green-l" in2="GREEN-BEVEL-1_10" result="GREEN-FRONT-1_0"></feComposite>
    <feOffset dx="4" dy="4" in="GREEN-FRONT-1_0" result="GREEN-FRONT-1_10"></feOffset>
    <feSpecularLighting surfaceScale="0" specularConstant=".75" specularExponent="30" lighting-color="#white" in="GREEN-FRONT-1_10" result="GREEN-FRONT-1_20">
      <fePointLight x="0" y="-30" z="400"></fePointLight>
    </feSpecularLighting>
    <feComposite operator="out" in2="GREEN-FRONT-1_20" in="GREEN-FRONT-1_10" result="GREEN-FRONT-1_30"></feComposite>
    <!-- Lower Green Front End -->
    <!-- Upper Green Bevel -->
    <feMorphology operator="dilate" radius="7" in="SourceAlpha" result="GREEN-BEVEL-2_0"></feMorphology>
    <feConvolveMatrix order="8,8" divisor="1" kernelMatrix="1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1" in="GREEN-BEVEL-2_0" result="GREEN-BEVEL-2_10"></feConvolveMatrix>
    <feComposite operator="in" in="COL_green-d" in2="GREEN-BEVEL-2_10" result="GREEN-BEVEL-2_20"></feComposite>
    <feOffset dx="9" dy="9" in="GREEN-BEVEL-2_20" result="GREEN-BEVEL-2_30"></feOffset>
    <!-- Upper Green Bevel end -->
    <!-- Upper Green Front -->
    <feOffset dx="18" dy="18" in="GREEN-BEVEL-2_0" result="GREEN-FRONT-2_10"></feOffset>
    <feComposite operator="in" in="COL_green-l" in2="GREEN-FRONT-2_10" result="GREEN-FRONT-2_20"></feComposite>
    <feSpecularLighting surfaceScale="0" specularConstant="0.75" specularExponent="40" lighting-color="#white" in="GREEN-FRONT-2_20" result="GREEN-FRONT-2_30">
      <fePointLight x="120" y="170" z="500"></fePointLight>
    </feSpecularLighting>
    <feComposite operator="in" in2="GREEN-FRONT-2_10" in="GREEN-FRONT-2_30" result="GREEN-FRONT-2_40"></feComposite>
    <!-- Upper Green Front end -->
    <!-- Bevels and Front shaded -->
    <feMerge result="SHADED-BEVELS_0">
      <feMergeNode in="GREEN-BEVEL-1_10"></feMergeNode>
      <feMergeNode in="GREEN-FRONT-1_30"></feMergeNode>
      <feMergeNode in="GREEN-BEVEL-2_30"></feMergeNode>
      <feMergeNode in="GREEN-FRONT-2_20"></feMergeNode>
      <feMergeNode in="GREEN-FRONT-2_40"></feMergeNode>
      <feMergeNode in="TRANSPARENT"></feMergeNode>
    </feMerge>
    <feSpecularLighting surfaceScale="0" specularConstant="0.45" specularExponent="30" lighting-color="#white" in="SHADED-BEVELS_0" result="SHADED-BEVELS_10">
      <fePointLight x="320" y="-20" z="400"></fePointLight>
    </feSpecularLighting>
    <feComposite operator="in" in2="SHADED-BEVELS_0" in="SHADED-BEVELS_10" result="SHADED-BEVELS_30"></feComposite>
    <!-- Bevels and Front shaded end -->
    <!-- Upper Red Bevel -->
    <feConvolveMatrix order="4,4" divisor="1" kernelMatrix="1 0 0 0
          0 1 0 0
          0 0 1 0
          0 0 0 1" in="SourceAlpha" result="RED-BEVEL-0_0"></feConvolveMatrix>
    <feComposite in="COL_red-d" in2="RED-BEVEL-0_0" operator="in" result="RED-BEVEL-0_10"></feComposite>
    <feOffset dx="20" dy="20" in="RED-BEVEL-0_10" result="RED-BEVEL-0_20"></feOffset>
    <!-- Upper Red Bevel end -->
    <!-- Upper Red Front -->
    <feComposite operator="in" in="COL_red-l" in2="SourceAlpha" result="RED-FRONT-0_0"></feComposite>
    <feOffset dx="24" dy="24" in="RED-FRONT-0_0" result="RED-FRONT-0_10"></feOffset>
    <feSpecularLighting surfaceScale="0" specularConstant=".45" specularExponent="30" lighting-color="#white" in="RED-FRONT-0_10" result="RED-FRONT-0_20">
      <fePointLight x="20" y="180" z="300"></fePointLight>
    </feSpecularLighting>
    <feComposite operator="in" in2="RED-FRONT-0_10" in="RED-FRONT-0_20" result="RED-FRONT-0_30"></feComposite>
    <!-- Upper Red Front end-->
    <!-- Inner Line -->
    <feMorphology radius="4" in="SourceAlpha" result="INNER-LINE_0"></feMorphology>
    <feMorphology radius="5" in="SourceAlpha" result="INNER-LINE_10"></feMorphology>
    <feComposite operator="out" in="INNER-LINE_0" in2="INNER-LINE_10" result="INNER-LINE_20"></feComposite>
    <feComposite operator="in" in="COL_green-l" in2="INNER-LINE_20" result="INNER-LINE_30"></feComposite>
    <feOffset dx="24" dy="24" in="INNER-LINE_30" result="INNER-LINE_40"></feOffset>
    <!-- Inner Line end -->
    <feMerge result="extruded-m">
      <feMergeNode in="SHADED-BEVELS_0"></feMergeNode>
      <feMergeNode in="SHADED-BEVELS_30"></feMergeNode>
      <feMergeNode in="RED-BEVEL-0_20"></feMergeNode>
      <feMergeNode in="RED-FRONT-0_10"></feMergeNode>
      <feMergeNode in="RED-FRONT-0_30"></feMergeNode>
      <feMergeNode in="INNER-LINE_40"></feMergeNode>
      <feMergeNode in="TRANSPARENT"></feMergeNode>
    </feMerge>
  </filter>
</template>
<script>
export default {
  props: {
    id: {
      type: String,
      default: "filter1"
    }
  }
}
</script>
