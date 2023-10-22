<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="snow9_32c" tilewidth="320" tileheight="240" tilecount="1" columns="1">
 <image source="../images/snow9_32c.png" width="320" height="240"/>
 <tile id="0">
  <objectgroup draworder="index" id="2">
   <object id="1" name="trajectory" type="trajectory" x="191.5" y="215.75">
    <polygon points="0,0 38,-5.5 60,-22.75 71,-50.5 74.75,-88 80.5,-132 79.25,-169.75 74,-190 56.75,-197 36.5,-194 39,-163.5 30.75,-129 -12.5,-107.25 -42.25,-101 -60.5,-128.25 -86,-155 -121,-179.75 -138.5,-176.75 -157.5,-159.25 -167.5,-128 -120.5,-19.75"/>
   </object>
   <object id="3" name="sail1" type="modifier" x="26.5" y="28" width="76.75" height="37">
    <properties>
     <property name="action" value="sail"/>
     <property name="threshold" type="int" value="16"/>
    </properties>
   </object>
   <object id="4" name="sail2" type="modifier" x="226.25" y="18.5" width="43" height="14.25">
    <properties>
     <property name="action" value="sail"/>
     <property name="threshold" type="int" value="16"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
</tileset>
