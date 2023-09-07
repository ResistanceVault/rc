<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="Easy1semi3" tilewidth="320" tileheight="240" tilecount="1" columns="1">
 <image source="Easy1semi3.png" width="320" height="240"/>
 <tile id="0">
  <objectgroup draworder="index" id="2">
   <object id="1" name="trajectory" x="157.667" y="215.333">
    <polygon points="0,0 47.3333,2 83.6667,1.66667 115.667,-5.33333 124.667,-21.3333 133.333,-37 135,-47.3333 133.667,-65.6667 124.333,-73.6667 104.333,-76.6667 96,-70.6667 79,-55.3333 63,-46.6667 35.5,-42.9167 29.75,-68.8333 33.3333,-87 38.3333,-104.333 55,-110.667 83.3333,-123 101.667,-130 107,-143.333 102,-159 91.3333,-172 69,-181 16.4167,-180.667 -92.75,-188.917 -131.5,-174.583 -123.667,-153 -115.333,-144.333 -86.5,-145.167 -44,-130.667 -38.6667,-115 -37.6667,-89 -43.3333,-75.6667 -49.6667,-65.3333 -89.3333,-67.3333 -101,-71.3333 -120.333,-60 -127.333,-46 -125.667,-29.3333 -117.333,-14.6667 -86.5,-14.0833 -53.3333,-12 -22.25,-6.41667"/>
   </object>
   <object id="2" name="sail1" type="modifier" x="279.333" y="127.667" width="17.6667" height="79.3333">
    <properties>
     <property name="action" value="sail"/>
     <property name="treshold" type="int" value="32"/>
    </properties>
   </object>
   <object id="3" name="sail2" type="modifier" x="97.6667" y="91" width="33" height="64">
    <properties>
     <property name="action" value="sail"/>
     <property name="treshold" type="int" value="32"/>
    </properties>
   </object>
   <object id="4" name="sail3" type="modifier" x="30.0833" y="174.833" width="52.5" height="32.3333">
    <properties>
     <property name="action" value="sail"/>
     <property name="treshold" type="int" value="32"/>
    </properties>
   </object>
   <object id="5" name="sail4" type="modifier" x="219.25" y="29.1667" width="59.375" height="32.5">
    <properties>
     <property name="action" value="sail"/>
     <property name="treshold" type="int" value="32"/>
    </properties>
   </object>
   <object id="6" name="sail5" type="modifier" x="37.5" y="66.75" width="35.5" height="13.75">
    <properties>
     <property name="action" value="brake"/>
     <property name="treshold" type="int" value="16"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
</tileset>
