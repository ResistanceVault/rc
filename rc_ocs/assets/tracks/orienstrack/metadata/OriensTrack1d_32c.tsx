<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="OriensTrack1d_32c" tilewidth="320" tileheight="240" tilecount="1" columns="1">
 <editorsettings>
  <export target="trajectory.xml" format="tsx"/>
 </editorsettings>
 <image source="../images/OriensTrack1d_32c.png" width="320" height="240"/>
 <tile id="0">
  <objectgroup draworder="index" id="2">
   <object id="1" name="trajectory" type="trajectory" x="173.333" y="32">
    <polygon points="0,0 -29.3333,3.66667 -49,28.6667 -72.6667,68.3333 -105,88 -124,101.667 -147.667,118.667 -134,145 -111.333,157.667 -70.3333,151.667 -53,130.333 -42,95 -31,73.6667 -10,68.6667 22,77.3333 42.6667,93.6667 24.6667,127 34,171.667 68.3333,183.667 96.6667,169 119.333,145 120.667,112.667 115,80.3333 98.6667,53.6667 72.6667,36 44,18 23,8"/>
   </object>
   <object id="2" name="brake1" type="modifier" x="33.6667" y="173" width="14" height="18.6667">
    <properties>
     <property name="action" value="brake"/>
     <property name="threshold" type="int" value="32"/>
    </properties>
   </object>
   <object id="3" name="brake2" type="modifier" x="152.333" y="93.6667" width="54" height="29">
    <properties>
     <property name="action" value="brake"/>
     <property name="threshold" type="int" value="32"/>
    </properties>
   </object>
   <object id="4" name="brake3" type="modifier" x="227" y="209" width="29.3333" height="15.6667">
    <properties>
     <property name="action" value="brake"/>
     <property name="threshold" type="int" value="32"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
</tileset>
