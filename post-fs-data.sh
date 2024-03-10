#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}
# This script will be executed in post-fs-data mode

APILEVEL=$(getprop ro.build.version.sdk)

#Copy original fonts.xml to the MODDIR to overwrite dummy file
mkdir -p $MODDIR/system/etc $MODDIR/system/system_ext/etc $MODDIR/system/product/etc
cp /system/etc/fonts.xml $MODDIR/system/etc

#Add workaround for Xiaomi HyperOS
MIVERSION=$(getprop ro.miui.ui.version.code)
if [ $MIVERSION -ge 816 ]
then
	if [ ! -f /data/system/theme/fonts/Roboto-Regular.ttf ]; then
		mkdir /data/system/theme/fonts
		cp $MODDIR/system/fonts/McMejiro-Regular.ttf /data/system/theme/fonts/Roboto-Regular.ttf
		cp $MODDIR/system/fonts/McMejiro-Bold.ttf /data/system/theme/fonts/Roboto-Bold.ttf
		ln -s /data/system/theme/fonts/Roboto-Bold.ttf /data/system/theme/fonts/Miui-Bold.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/Miui-Regular.ttf
		ln -s /data/system/theme/fonts/Roboto-Bold.ttf /data/system/theme/fonts/MiuiEx-Bold.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/MiuiEx-Light.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/MiuiEx-Regular.ttf
		ln -s /data/system/theme/fonts/Roboto-Bold.ttf /data/system/theme/fonts/Roboto-Black.ttf
		ln -s /data/system/theme/fonts/Roboto-Bold.ttf /data/system/theme/fonts/Roboto-BlackItalic.ttf
		ln -s /data/system/theme/fonts/Roboto-Bold.ttf /data/system/theme/fonts/Roboto-BoldItalic.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/Roboto-Italic.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/Roboto-Light.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/Roboto-LightItalic.ttf
		ln -s /data/system/theme/fonts/Roboto-Bold.ttf /data/system/theme/fonts/Roboto-Medium.ttf
		ln -s /data/system/theme/fonts/Roboto-Bold.ttf /data/system/theme/fonts/Roboto-MediumItalic.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/Roboto-ThinItalic.ttf
		ln -s /data/system/theme/fonts/Roboto-Regular.ttf /data/system/theme/fonts/Roboto-ThinItalic.ttf
		chown -R system_theme /data/system/theme/fonts
	fi
fi

#Function to remove original ja
remove_ja() {
  sed -i -e '/<family lang="ja"/,/<\/family>/d' $1
}

#Function to add ja above zh-Hans
add_ja() {
	if [ -e $MODDIR/system/fonts/disable-extra-weights ] ; then
		if [ $APILEVEL -ge 31 ] ; then
			#Android 12 and later
			sed -i 's@<family lang="zh-Hans">@<family lang="ja">\n        <font weight="300" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Bold.ttf</font>\n        <font weight="300" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Bold.ttf</font>\n    </family>\n    <family lang="zh-Hans">@g' $1
		else
			sed -i 's@<family lang="zh-Hans">@<family lang="ja">\n        <font weight="300" style="normal">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal">McMejiro-Bold.ttf</font>\n        <font weight="300" style="normal" fallbackFor="serif">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal" fallbackFor="serif">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal" fallbackFor="serif">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal" fallbackFor="serif">McMejiro-Bold.ttf</font>\n    </family>\n    <family lang="zh-Hans">@g' $1
		fi
	else
		if [ $APILEVEL -ge 31 ]; then
			#Android 12 and later
			sed -i 's@<family lang="zh-Hans">@<family lang="ja">\n        <font weight="100" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Thin.ttf</font>\n        <font weight="300" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Bold.ttf</font>\n        <font weight="800" style="normal" postScriptName="NotoSansCJKjp-Regular">McMejiro-Extrabold.ttf</font>\n        <font weight="100" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Thin.ttf</font>\n        <font weight="300" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Bold.ttf</font>\n        <font weight="800" style="normal" postScriptName="NotoSansCJKjp-Regular" fallbackFor="serif">McMejiro-Extrabold.ttf</font>\n    </family>\n    <family lang="zh-Hans">@g' $1
		else
			sed -i 's@<family lang="zh-Hans">@<family lang="ja">\n        <font weight="100" style="normal">McMejiro-Thin.ttf</font>\n        <font weight="300" style="normal">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal">McMejiro-Bold.ttf</font>\n        <font weight="800" style="normal">McMejiro-Extrabold.ttf</font>\n        <font weight="100" style="normal" fallbackFor="serif">McMejiro-Thin.ttf</font>\n        <font weight="300" style="normal" fallbackFor="serif">McMejiro-Light.ttf</font>\n        <font weight="400" style="normal" fallbackFor="serif">McMejiro-Regular.ttf</font>\n        <font weight="600" style="normal" fallbackFor="serif">McMejiro-Semibold.ttf</font>\n        <font weight="700" style="normal" fallbackFor="serif">McMejiro-Bold.ttf</font>\n        <font weight="800" style="normal" fallbackFor="serif">McMejiro-Extrabold.ttf</font>\n    </family>\n    <family lang="zh-Hans">@g' $1
		fi
	fi
}

#Function to replace Google Sans
replace_gsans() {
	sed -i 's@GoogleSans-Italic.ttf@GoogleSans-Regular.ttf\n      <axis tag="ital" stylevalue="1" />@g' $1
}

#Change fonts.xml file
remove_ja $MODDIR/system/etc/fonts.xml
add_ja $MODDIR/system/etc/fonts.xml

gsans=/system/product/etc/fonts_customization.xml
if [ -e $gsans ]; then
	cp $gsans $MODDIR$gsans
	replace_gsans $MODDIR$gsans
fi

#Goodbye, SomcUDGothic
sed -i 's@SomcUDGothic-Light.ttf@null.ttf@g' $MODDIR/system/etc/fonts.xml
sed -i 's@SomcUDGothic-Regular.ttf@null.ttf@g' $MODDIR/system/etc/fonts.xml

#Goodbye, OnePlus Font
sed -i 's@OpFont-@Roboto-@g' $MODDIR/system/etc/fonts.xml
sed -i 's@NotoSerif-@Roboto-@g' $MODDIR/system/etc/fonts.xml

#Goodbye, OPLUS Font
if [ -f /system/fonts/SysFont-Regular.ttf ]; then
	cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/SysFont-Regular.ttf
fi
if [ -f /system/fonts/SysFont-Static-Regular.ttf ]; then
	cp /system/fonts/RobotoStatic-Regular.ttf $MODDIR/system/fonts/SysFont-Static-Regular.ttf
fi
if [ -f /system/fonts/SysSans-En-Regular.ttf ]; then
	sed -i 's@SysSans-En-Regular@Roboto-Regular@g' $MODDIR/system/etc/fonts.xml
	cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/SysSans-En-Regular.ttf
fi

#Goodbye, Xiaomi Font
/system/bin/sed -i -z 's@<family name="sans-serif">\n    <!-- # MIUI Edit Start -->.*<!-- # MIUI Edit END -->@<family name="sans-serif">@' $MODDIR/system/etc/fonts.xml
#/system/bin/sed -i -z 's@<family name="sans-serif">\n    <!-- For WebView font -->.*<font weight="100" style="normal">Roboto@<family name="sans-serif">\n      <font weight="100" style="normal">Roboto@' $MODDIR/system/etc/fonts.xml
sed -i 's@MiSansVF.ttf@Roboto-Regular.ttf@g' $MODDIR/system/etc/fonts.xml
if [ -e /system/fonts/MiSansVF.ttf ]; then
	cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/MiSansVF.ttf
fi
#For MIUI 13+
sed -i 's@MiSansVF_Overlay.ttf@Roboto-Regular.ttf@g' $MODDIR/system/etc/fonts.xml
if [ -e /system/fonts/MiSansVF_Overlay.ttf ]; then
	cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/MiSansVF_Overlay.ttf
fi

#Goodbye, vivo Font
sed -i 's@VivoFont.ttf@McMejiro-Regular.ttf@g' $MODDIR/system/etc/fonts.xml
sed -i 's@DroidSansFallbackBBK.ttf@McMejiro-Regular.ttf@g' $MODDIR/system/etc/fonts.xml
if [ -e /system/fonts/HYQiHei-50.ttf ]; then
cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/HYQiHei-50.ttf
fi
if [ -e /system/fonts/DroidSansFallbackBBK.ttf ]; then
cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/DroidSansFallbackBBK.ttf
fi
if [ -e /system/fonts/DroidSansFallbackMonster.ttf ]; then
cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/DroidSansFallbackMonster.ttf
fi
if [ -e /system/fonts/DroidSansFallbackZW.ttf ]; then
cp /system/fonts/Roboto-Regular.ttf $MODDIR/system/fonts/DroidSansFallbackZW.ttf
fi

#Goodbye, Sansita Font
sed -i 's@Sansita-@Roboto-@g' $MODDIR/system/etc/fonts.xml

#Copy fonts_slate.xml for OnePlus
opslate=fonts_slate.xml
if [ -e /system/etc/$opslate ]; then
    cp /system/etc/$opslate $MODDIR/system/etc
	
	#Change fonts_slate.xml file
	remove_ja $MODDIR/system/etc/$opslate
	add_ja $MODDIR/system/etc/$opslate

	sed -i 's@SlateForOnePlus-Thin.ttf@McMejiro-Light.ttf@g' $MODDIR/system/etc/$opslate
	sed -i 's@SlateForOnePlus-Light.ttf@McMejiro-Light.ttf@g' $MODDIR/system/etc/$opslate
	sed -i 's@SlateForOnePlus-Book.ttf@McMejiro-Regular.ttf@g' $MODDIR/system/etc/$opslate
	sed -i 's@SlateForOnePlus-Regular.ttf@McMejiro-Regular.ttf@g' $MODDIR/system/etc/$opslate
	sed -i 's@SlateForOnePlus-Medium.ttf@McMejiro-Semibold.ttf@g' $MODDIR/system/etc/$opslate
	sed -i 's@SlateForOnePlus-Bold.ttf@McMejiro-Bold.ttf@g' $MODDIR/system/etc/$opslate
	sed -i 's@SlateForOnePlus-Black.ttf@McMejiro-Extrabold.ttf@g' $MODDIR/system/etc/$opslate
fi

#Copy fonts_base.xml for OnePlus OxygenOS 11
oos11=fonts_base.xml
if [ -e /system/etc/$oos11 ]; then
    cp /system/etc/$oos11 $MODDIR/system/etc
	
	#Change fonts_slate.xml file
	remove_ja $MODDIR/system/etc/$oos11
	add_ja $MODDIR/system/etc/$oos11

	sed -i 's@NotoSerif-@Roboto-@g' $MODDIR/system/etc/$oos11
fi

#Copy fonts_base.xml for OnePlus OxygenOS 12+
oos12=fonts_base.xml
if [ -e /system/system_ext/etc/$oos12 ]; then
    cp /system/system_ext/etc/$oos12 $MODDIR/system/system_ext/etc
	
	#Change fonts_slate.xml file
	remove_ja $MODDIR/system/system_ext/etc/$oos12
	add_ja $MODDIR/system/system_ext/etc/$oos12

	sed -i 's@SysSans-En-Regular@Roboto-Regular@g' $MODDIR/system/system_ext/etc/$oos12
	sed -i 's@NotoSerif-@Roboto-@g' $MODDIR/system/system_ext/etc/$oos12
fi

#Copy fonts_customization.xml for OnePlus OxygenOS 12+
oos12c=fonts_customization.xml
if [ -e /system/system_ext/etc/$oos12c ]; then
    cp /system/system_ext/etc/$oos12c $MODDIR/system/system_ext/etc
	sed -i 's@OplusSansText-25Th@McMejiro-Light@g' $MODDIR/system/system_ext/etc/$oos12c
	sed -i 's@OplusSansText-35ExLt@McMejiro-Light@g' $MODDIR/system/system_ext/etc/$oos12c
	sed -i 's@OplusSansText-45Lt@McMejiro-Light@g' $MODDIR/system/system_ext/etc/$oos12c
	sed -i 's@OplusSansText-55Rg@McMejiro-Regular@g' $MODDIR/system/system_ext/etc/$oos12c
	sed -i 's@OplusSansText-65Md@McMejiro-Semibold@g' $MODDIR/system/system_ext/etc/$oos12c
	sed -i 's@NHGMYHOplusHK-W4@McMejiro-Regular@g' $MODDIR/system/system_ext/etc/$oos12c
	sed -i 's@NHGMYHOplusPRC-W4@McMejiro-Regular@g' $MODDIR/system/system_ext/etc/$oos12c
	sed -i 's@OplusSansDisplay-45Lt@McMejiro-Light@g' $MODDIR/system/system_ext/etc/$oos12c
fi

#Copy fonts_customization.xml for OnePlus OxygenOS 12+
oos12p=fonts_customization.xml
if [ -e /system/product/etc/$oos12p ]; then
    cp /system/product/etc/$oos12p $MODDIR/system/product/etc
	sed -i 's@OplusSansText-25Th@McMejiro-Light@g' $MODDIR/system/product/etc/$oos12p
	sed -i 's@OplusSansText-35ExLt@McMejiro-Light@g' $MODDIR/system/product/etc/$oos12p
	sed -i 's@OplusSansText-45Lt@McMejiro-Light@g' $MODDIR/system/product/etc/$oos12p
	sed -i 's@OplusSansText-55Rg@McMejiro-Regular@g' $MODDIR/system/product/etc/$oos12p
	sed -i 's@OplusSansText-65Md@McMejiro-Semibold@g' $MODDIR/system/product/etc/$oos12p
	sed -i 's@NHGMYHOplusHK-W4@McMejiro-Regular@g' $MODDIR/system/product/etc/$oos12p
	sed -i 's@NHGMYHOplusPRC-W4@McMejiro-Regular@g' $MODDIR/system/product/etc/$oos12p
	sed -i 's@OplusSansDisplay-45Lt@McMejiro-Light@g' $MODDIR/system/product/etc/$oos12p
fi