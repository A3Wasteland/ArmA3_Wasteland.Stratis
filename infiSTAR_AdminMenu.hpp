/*
Antihack & AdminTools - Christian Lorenzen - www.infiSTAR.de
#16966
*/
class RscListBox_infiSTAR {
access=0;
type=5;
style=0;
font="PuristaLight";
sizeEx=0.03;
rowHeight=0;
colorText[]={1,1,1,1};
colorScrollbar[]={1,1,1,1};
colorSelect[]={0,0,0,1};
colorSelect2[]={1,0.5,0,1};
colorSelectBackground[]={0.6,0.6,0.6,1};
colorSelectBackground2[]={0.2,0.2,0.2,1};
colorBackground[]={0,0,0,0.8};
maxHistoryDelay=1.0;
soundSelect[]={"",0.1,1};
period=1;
autoScrollSpeed=-1;
autoScrollDelay=5;
autoScrollRewind=0;
arrowEmpty="#(argb,8,8,3)color(1,1,1,1)";
arrowFull="#(argb,8,8,3)color(1,1,1,1)";
shadow=0;
colorDisabled[]={1,1,1,0.25};
border=false;
borderSize=0;
class ScrollBar
{
arrowEmpty="#(argb,8,8,3)color(1,1,1,1)";
arrowFull="#(argb,8,8,3)color(1,1,1,1)";
border="#(argb,8,8,3)color(1,1,1,1)";
color[]={1,1,1,0.6};
colorActive[]={1,1,1,1};
colorDisabled[]={1,1,1,0.3};
thumb="#(argb,8,8,3)color(1,1,1,1)";
};
class ListScrollBar:ScrollBar
{
color[]={1,1,1,0.6};
colorActive[]={1,1,1,1};
colorDisabled[]={1,1,1,0.3};
thumb="#(argb,8,8,3)color(1,1,1,1)";
arrowEmpty="#(argb,8,8,3)color(1,1,1,1)";
arrowFull="#(argb,8,8,3)color(1,1,1,1)";
border="#(argb,8,8,3)color(1,1,1,1)";
shadow=0;
};
};
class RscText_infiSTAR {
access=0;
idc=-1;
type=0;
style=0;
linespacing=1;
colorBackground[]={0,0,0,0};
colorText[]={0.84,0.07,0,1};
shadow=1;
font="PuristaBold";
sizeex=0.0400;
fixedWidth=0;
};
class RscEdit_infiSTAR {
access=0;
type=2;
style=0;
colorBackground[]={0,0,0,0.6};
colorText[]={1,1,1,1};
colorSelection[]={1,1,1,0.25};
colorDisabled[]={1,1,1,0};
font="PuristaBold";
sizeEx=0.04;
autocomplete="";
text="";
size=0.2;
shadow=0;
};
class RscButton_infiSTAR {
access=0;
idc=-1;
type=1;
style=0;
text="";
action="";
colorText[]={1,1,1,0.9};
colorDisabled[]={0.6,0.1,0.3,0};
colorBackground[]={0,0,0,0.8};
colorBackgroundDisabled[]={0,0.0,0};
colorBackgroundActive[]={0.15,0.35,0.55,0.7};
colorFocused[]={0.58,0.05,0,0.7};
colorShadow[]={0.023529,0,0.0313725,1};
colorBorder[]={0.023529,0,0.0313725,1};
soundEnter[]={"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
soundPush[]={"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
soundClick[]={"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
soundEscape[]={"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
shadow=0;
font="PuristaMedium";
sizeEx=0.02921;
offsetX=0.003;
offsetY=0.003;
offsetPressedX=0.002;
offsetPressedY=0.002;
borderSize=0;
};
class RscHTML_infiSTAR {
colorText[]={1,1,1,1};
colorBold[]={1,1,1,0.75};
colorLink[]={"63/255","212/255","252/255",1};
colorLinkActive[]={"63/255","212/255","252/255",0.75};
colorBackground[]={0,0,0,0};
colorPicture[]={1,1,1,1};
colorPictureBorder[]={0,0,0,0};
colorPictureLink[]={1,1,1,1};
colorPictureSelected[]={1,1,1,1};
hppversion=3;
filename="";
sizeEx=0.03921;
type=9;
style=0;
prevPage="\ca\ui\data\arrow_left_ca.paa";
nextPage="\ca\ui\data\arrow_right_ca.paa";
shadow=2;
class def {
font="PuristaMedium";
fontBold="PuristaBold";
align="left";
};
class H1:def {
sizeEx="38 * pixelH";
};
class H2:def {
sizeEx="32 * pixelH";
};
class H3:def {
sizeEx="26 * pixelH";
};
class H4:def {
sizeEx="20 * pixelH";
};
class H5:def {
sizeEx="17 * pixelH";
};
class H6:def {
sizeEx="15 * pixelH";
};
class P:def {
sizeEx="18 * pixelH";
};
};
class RscEdit_infiSTAR_multi:RscEdit_infiSTAR {
idc=1339;
x=0.1 * safezoneW + safezoneX;
y=0.038 * safezoneH + safezoneY;
w=0.658333 * safezoneW;
h=(0.143 * safezoneH)*3;
font="EtelkaMonospacePro";
colorText[]={0.95,0.95,0.95,1};
style=16;
sizeEx="0.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
show=1;
};
class RscEdit_infiSTAR_ss:RscEdit_infiSTAR {
x=0;
y=(safeZoneY + 0.01)+1;
w=1;
h=0.05;
idc=1380;
font="EtelkaMonospacePro";
colorText[]={0.95,0.95,0.95,1};
sizeEx="0.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
show=1;
autocomplete="scripting";
};
class infiSTAR_EDITBOX
{
idd=-1341;
movingenable=true;
class controls
{
class RscEditMultiSTAR:RscEdit_infiSTAR_multi
{
idc=1336;
x=0.25;
y=0.25;
w=0.5;
h=0.5;
};
};
};
class infiSTAR_EDITBOX2
{
idd=-1341;
movingenable=true;
class controls
{
class RscEditMultiSTAR:RscEdit_infiSTAR_multi{autocomplete="scripting";};
class RscEditSingle1STAR:RscEdit_infiSTAR_ss{idc=1380;};
class RscEditSingle2STAR:RscEdit_infiSTAR_ss{idc=1381;};
class RscEditSingle3STAR:RscEdit_infiSTAR_ss{idc=1382;};
class RscEditSingle4STAR:RscEdit_infiSTAR_ss{idc=1383;};
class infi_LIST1384:RscListBox_infiSTAR{idc=1384;x=-0.25;y=0.2;w=0.25;h=0.9;sizeEx=0.027;};
};
};
class infiSTAR_CHAT
{
idd=-1340;
movingenable=false;
onKeyDown="call fnc_chat_onKeyDown;";
class controls
{
class RscListbox_1500:RscListBox_infiSTAR
{
idc = 1500;
x = 0.133846 * safezoneW + safezoneX;
y = 0.0929318 * safezoneH + safezoneY;
w = 0.165027 * safezoneW;
h = 0.792133 * safezoneH;
onLoad="uiNamespace setVariable ['chat_playerlist', _this select 0];call fnc_fill_chat_playerlist;(_this select 0) lbSetCurSel 0;";
onLBSelChanged="call fnc_chat_onLBSelChanged;";
};
class RscListbox_1501:RscListBox_infiSTAR
{
idc = 1501;
x = 0.298873 * safezoneW + safezoneX;
y = 0.0929318 * safezoneH + safezoneY;
w = 0.505396 * safezoneW;
h = 0.71512 * safezoneH;
sizeEx=0.03;
onLoad="uiNamespace setVariable ['chat_msgbox', _this select 0];call fnc_fill_chat_history;";
};
class RscEdit_1401:RscEdit_infiSTAR_multi
{
idc = 1401;
x = 0.298873 * safezoneW + safezoneX;
y = 0.808052 * safezoneH + safezoneY;
w = 0.505396 * safezoneW;
h = 0.0770129 * safezoneH;
onLoad="uiNamespace setVariable ['chat_inputfield', _this select 0];";
};
class RscButton_1600:RscButton_infiSTAR
{
idc = 1600;
text = "close";
x = 0.752698 * safezoneW + safezoneX;
y = 0.885064 * safezoneH + safezoneY;
w = 0.051571 * safezoneW;
h = 0.0330055 * safezoneH;
action = "(findDisplay -1340) closeDisplay 0;";
};
class RscButton_1601:RscButton_infiSTAR
{
idc = 1601;
text = "send";
x = (0.752698 * safezoneW + safezoneX)-((0.051571 * safezoneW)*1.1);
y = 0.885064 * safezoneH + safezoneY;
w = 0.051571 * safezoneW;
h = 0.0330055 * safezoneH;
action = "call fnc_chat_send;";
};
class RscButton_1602:RscButton_infiSTAR
{
idc = 1602;
text = "refresh list";
x = 0.133846 * safezoneW + safezoneX;
y = 0.885064 * safezoneH + safezoneY;
w = 0.051571 * safezoneW;
h = 0.0330055 * safezoneH;
action = "call fnc_fill_chat_playerlist;";
};
class RscText_1000:RscText_infiSTAR
{
idc = 1000;
x = 0.133846 * safezoneW + safezoneX;
y = 0.0599262 * safezoneH + safezoneY;
w = 0.670423 * safezoneW;
h = 0.0330055 * safezoneH;
colorText[]={1,1,1,0.9};
colorBackground[]={0,0,0,0.6};
text = "Chatpartner";
onLoad="uiNamespace setVariable ['chat_text1', _this select 0];";
};
};
};
class infiSTAR_AdminMenu
{
idd=-1338;
movingenable=false;
controls[]=
{
infi_TXT2,
infi_BTN10,
infi_BTN11,
infi_BTN12,
infi_LIST1500,
infi_LIST1501,
infi_BTN20,
infi_BTN21,
infi_BTN23,
infi_BTN24,
infi_BTN25,
infi_EDIT1,
infi_EDIT2,
infi_BTN36,
infi_BTN37,
infi_BTN38,
infi_HTML_1
};
class infi_LIST1500:RscListBox_infiSTAR
{
idc=1500;
x=4.99852e-005 * safezoneW + safezoneX;
y=0.0617197 * safezoneH + safezoneY;
w=0.189063 * safezoneW;
h=0.938333 * safezoneH;
};
class infi_LIST1501:RscListBox_infiSTAR
{
idc=1501;
x=0.188975 * safezoneW + safezoneX;
y=0.0617197 * safezoneH + safezoneY;
w=0.344271 * safezoneW;
h=0.945999 * safezoneH;
};
class infi_EDIT1:RscEdit_infiSTAR
{
idc=100;
text="";
x=0.1964 * safezoneW + safezoneX;
y=0.125933 * safezoneH + safezoneY;
w=0.326563 * safezoneW;
h=0.044 * safezoneH;
};
class infi_EDIT2:RscEdit_infiSTAR_multi
{
idc=103;
show=0;
};
class infi_TXT2:RscText_infiSTAR
{
idc=2;
text="infiSTAR.de";
x=-5.31323e-005 * safezoneW + safezoneX;
y=-7.50085e-005 * safezoneH + safezoneY;
w=1 * safezoneW;
h=0.0341667 * safezoneH;
colorText[]={1,1,1,0.9};
colorBackground[]={0.56,0.04,0.04,1};
};
class infi_HTML_1:RscHTML_infiSTAR
{
idc=1;
x=0.535 * safezoneW + safezoneX;
y=0.06 * safezoneH + safezoneY;
w=0.40 * safezoneW;
h=0.35 * safezoneH;
onLoad="uiNamespace setVariable ['RscHTML_infiSTAR_Admin', _this select 0]";
onUnload="uiNamespace setVariable ['RscHTML_infiSTAR_Admin', displayNull]";
};
class infi_BTN10:RscButton_infiSTAR
{
idc=10;
text="Alphabet";
x=0.005 + safezoneX;
y=0.0379694 * safezoneH + safezoneY;
w=0.06 * safezoneW;
h=0.02 * safezoneH;
action="SortRangePlease=nil;SortAlphaPlease=true;SortGroupsPlease=nil;[] call fnc_fill_infiSTAR_Player;[] call fnc_setFocus;";
};
class infi_BTN11:RscButton_infiSTAR
{
idc=11;
text="Groups";
x=0.01 + safezoneX + (0.06 * safezoneW);
y=0.0379694 * safezoneH + safezoneY;
w=0.06 * safezoneW;
h=0.02 * safezoneH;
action="SortAlphaPlease=nil;SortRangePlease=nil;SortGroupsPlease=true;[] call fnc_fill_infiSTAR_Player;[] call fnc_setFocus;";
};
class infi_BTN12:RscButton_infiSTAR
{
idc=12;
text="Range";
x=0.015 + safezoneX + (0.06 * safezoneW)*2;
y=0.0379694 * safezoneH + safezoneY;
w=0.06 * safezoneW;
h=0.02 * safezoneH;
action="SortAlphaPlease=nil;SortRangePlease=true;SortGroupsPlease=nil;[] call fnc_fill_infiSTAR_Player;[] call fnc_setFocus;";
};
class infi_BTN20:RscButton_infiSTAR
{
idc=20;
default="true";
text="MainMenu";
x=0.202072 * safezoneW + safezoneX;
y=0.0379694 * safezoneH + safezoneY;
w=0.0625001 * safezoneW;
h=0.02 * safezoneH;
};
class infi_BTN21:RscButton_infiSTAR
{
idc=21;
text="SpawnMenu";
x=0.287975 * safezoneW + safezoneX;
y=0.0379694 * safezoneH + safezoneY;
w=0.0625001 * safezoneW;
h=0.02 * safezoneH;
};
class infi_BTN23:RscButton_infiSTAR
{
idc=23;
text="AHLog";
x=0.373981 * safezoneW + safezoneX;
y=0.0379694 * safezoneH + safezoneY;
w=0.0625001 * safezoneW;
h=0.02 * safezoneH;
};
class infi_BTN24:RscButton_infiSTAR
{
idc=24;
text="AdminLog";
x=0.459884 * safezoneW + safezoneX;
y=0.0379694 * safezoneH + safezoneY;
w=0.0625001 * safezoneW;
h=0.02 * safezoneH;
};
class infi_BTN25:RscButton_infiSTAR
{
idc=25;
x=0.535 * safezoneW + safezoneX + (0.15 * safezoneW);
y=0.0379694 * safezoneH + safezoneY;
w=0.0625001 * safezoneW;
h=0.02 * safezoneH;
action="call fnc_btn_html";
};
class infi_BTN36:RscButton_infiSTAR
{
idc=36;
text="Items";
x=0.219294 * safezoneW + safezoneX;
y=0.0819514 * safezoneH + safezoneY;
w=0.0916667 * safezoneW;
h=0.0329999 * safezoneH;
};
class infi_BTN37:RscButton_infiSTAR
{
idc=37;
text="Vehicles";
x=0.316644 * safezoneW + safezoneX;
y=0.0819514 * safezoneH + safezoneY;
w=0.0916667 * safezoneW;
h=0.0329999 * safezoneH;
};
class infi_BTN38:RscButton_infiSTAR
{
idc=38;
text="Trader";
x=0.414097 * safezoneW + safezoneX;
y=0.0819514 * safezoneH + safezoneY;
w=0.0916667 * safezoneW;
h=0.0329999 * safezoneH;
};
};
class CfgCommands
{
allowedHTMLLoadURIs[]={"http://*"};
};