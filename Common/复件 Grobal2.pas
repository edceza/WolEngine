unit Grobal2;

interface
uses
  Windows, Classes,JSocket;
const
 /////////// m2
  MAXLEVEL=65536;
  MAXMAGIC=100;
  sSTRING_GOLDNAME='GOLD' ;
  LA_UNDEAD=1;            //?
  ET_FIRE=1;              //?
  ET_HOLYCURTAIN=2;      //?
  ET_STONEMINE =3   ;    //?
  ET_DIGOUTZOMBI=4     ;    //?
  ET_PILESTONES=5 ;//?


  STATE_STONE_MODE=1;
  RCC_MERCHANT =1;
  LOG_GAMEGOLD=1;
  LOG_GAMEPOINT=2;
  MAXBAGITEM=46;
  SLAVEMAXLEVEL=7;
  sSTATUS_FAIL='+FAIL';
  sSTATUS_GOOD='+GOOD';



  SKILL_FIREBALL=1;
  SKILL_HEALLING=2;
  SKILL_ILKWANG =3;
  SKILL_YEDO  =4;
    
  SKILL_FIREBALL2=5;
  SKILL_AMYOUNSUL=6;
    SKILL_ONESWORD =7;
  SKILL_FIREWIND=8;
  SKILL_FIRE=9;
  SKILL_SHOOTLIGHTEN=10;
  SKILL_LIGHTENING=11;
  SKILL_ERGUM=12;
    SKILL_FIRECHARM=13;
    SKILL_HANGMAJINBUB=14;
    SKILL_DEJIWONHO=15;
    SKILL_HOLYSHIELD=16;
    SKILL_SKELLETON=17;
    SKILL_CLOAK=18;
    SKILL_BIGCLOAK=19;
    SKILL_TAMMING=20;
    SKILL_SPACEMOVE=21;
   SKILL_EARTHFIRE=22;
    SKILL_FIREBOOM=23;
    SKILL_LIGHTFLOWER=24;
    SKILL_BANWOL=25;
    SKILL_FIRESWORD=26;
    SKILL_MOOTEBO=27;
    SKILL_SHOWHP=28;
    SKILL_BIGHEALLING=29;
    SKILL_SINSU=30;
    SKILL_SHIELD=31;
    SKILL_KILLUNDEAD=32;
    SKILL_SNOWWIND=33;
    SKILL_UNAMYOUNSUL=34;
    SKILL_WINDTEBO=35;
     SKILL_MABE=36;
   SKILL_GROUPLIGHTENING=37;
   SKILL_GROUPAMYOUNSUL=38;
    SKILL_GROUPDEDING=39;// 地钉}
    SKILL_40=40  ;//双龙斩
    SKILL_41=41 ;  //狮子吼
    SKILL_42=42 ; //狂风斩
     SKILL_43=43;//破空剑
     SKILL_44=44 ; //结冰掌
     SKILL_45=45 ;  //灭天火
     SKILL_46=46 ; //分身术
     SKILL_47=47; //火龙气焰
      SKILL_48=48 ;  //气功波
       SKILL_49=49 ;  //净化术
       SKILL_50=50 ;  //无极真气
      SKILL_51=51 ; //灵魂召唤术
      SKILL_52=52 ;  //诅咒术
      SKILL_53=53;  //灵魂召唤术
      SKILL_54=54 ;  //诅咒术

    
 //
 //  TIPLocal = array [0..100]of char;
 //////////// m2

  tLoginGate=0;
  tLoginSrv=0;
  tDBServer=0;
  tM2Server=0;

  RUNGATECODE=$AA55AA55;//1009;
  
//  RUNGATECODE

    GS_QUIT=0;
    GS_USERACCOUNT=1;
    GS_CHANGEACCOUNTINFO=2;

    SG_FORMHANDLE=1000;
    SG_STARTNOW=1001;
    SG_STARTOK=1002;

    SG_USERACCOUNT=1003;
    SG_USERACCOUNTNOTFOUND=1004;
    SG_USERACCOUNTCHANGESTATUS=1005;
    SG_CHECKCODEADDR=1006;
{}       // SS_OPENSESSION{100}  :GetPasswdSuccess(sBody);
      //  SS_CLOSESESSION{101} :GetCancelAdmission(sBody);
      //  SS_KEEPALIVE{104}    :SetTotalHumanCount(sBody);
     //   UNKNOWMSG: ;
      //  SS_KICKUSER{111}     :GetCancelAdmissionA(sBody);
  



   SS_OPENSESSION=100;
   SS_CLOSESESSION=101;
   SS_SERVERINFO=102;
   SS_SERVERLOAD=113;

   SS_KEEPALIVE=104;
   SS_SOFTOUTSESSION=105;
   SS_LOGINCOST=106;//?


  // SS_212=212;
  // SS_204 =204;

     SS_200 =200 ;
      SS_201=201 ;
      SS_202=202 ;
      SS_WHISPER=203 ;
      SS_204=204 ;
      SS_205=205 ;
      SS_206=206 ;
      SS_207=207 ;
      SS_208=208 ;
      SS_209=209 ;
      SS_210=210 ;
      SS_211=211 ;
      SS_212=212 ;
      SS_213=213 ;
      SS_214=214;


   UNKNOWMSG=106;
   SS_KICKUSER=111;     {
// CM_GETBACKPASSWORD=1000;
 //SM_GETBACKPASSWD_SUCCESS=1002;
// SM_GETBACKPASSWD_FAIL=1003;
// SM_CERTIFICATION_SUCCESS=1001;
  
 }
   DBR_FAIL =2000;
   DBR_LOADHUMANRCD=1100;
   DBR_SAVEHUMANRCD=1101;
  

  DB_LOADHUMANRCD=100;
  DB_SAVEHUMANRCD=101;
  DB_SAVEHUMANRCDEX=102;

/////////////////////// ///////////////////////////
  DR_UP         = 0;
  DR_UPRIGHT    = 1;
  DR_RIGHT      = 2;
  DR_DOWNRIGHT  = 3;
  DR_DOWN       = 4;
  DR_DOWNLEFT   = 5;
  DR_LEFT       = 6;
  DR_UPLEFT     = 7;

  U_DRESS       = 0;
  U_WEAPON      = 1;
  U_RIGHTHAND   = 2;
  U_NECKLACE    = 3;
  U_HELMET      = 4;
  U_ARMRINGL    = 5;
  U_ARMRINGR    = 6;
  U_RINGL       = 7;
  U_RINGR       = 8;
   //m2
    U_BUJUK=9  ;
    U_BELT=10    ;
    U_BOOTS=11   ;
    U_CHARM=12    ;

  DEFBLOCKSIZE  = 16;
  BUFFERSIZE    = 10000;
  DATA_BUFSIZE  = 8192;

  GROUPMAX = 11;
  BAGGOLD  = 5000000;
  BODYLUCKUNIT = 10;
  MAX_STATUS_ATTRIBUTE = 12;

  POISON_DECHEALTH      = 0;
  POISON_DAMAGEARMOR    = 1;
  POISON_LOCKSPELL      = 2;
  POISON_DONTMOVE       = 4;
  POISON_STONE          = 5;
  POISON_68             =68;

  STATE_TRANSPARENT     = 8;
  STATE_DEFENCEUP       = 9;
  STATE_MAGDEFENCEUP    = 10;
  STATE_BUBBLEDEFENCEUP = 11;
  STATE_OPENHEATH =12;


  USERMODE_PLAYGAME = 1;
  USERMODE_LOGIN    = 2;
  USERMODE_LOGOFF   = 3;
  USERMODE_NOTICE   = 4;  

  RUNGATEMAX = 20;


   CM_42HIT             =42;
   CM_QUERYUSERSTATE     = 82;

  CM_QUERYUSERSET       =83;

  CM_QUERYUSERNAME      = 80;
  CM_QUERYBAGITEMS      = 81;

  CM_QUERYCHR           = 100;
  CM_NEWCHR             = 101;
  CM_DELCHR             = 102;
  CM_SELCHR             = 103;
  CM_SELECTSERVER       = 104;

  CM_OPENDOOR           = 1002;
  CM_SOFTCLOSE          = 1009;

  CM_DROPITEM           = 1000;
  CM_PICKUP             = 1001;
  CM_TAKEONITEM		= 1003;
  CM_TAKEOFFITEM        = 1004;
  CM_1005               =1005;
  CM_EAT                = 1006;
  CM_BUTCH              = 1007;
  CM_MAGICKEYCHANGE	= 1008;

  CM_CLICKNPC           = 1010;
  CM_MERCHANTDLGSELECT  = 1011;
  CM_MERCHANTQUERYSELLPRICE = 1012;
  CM_USERSELLITEM       = 1013;
  CM_USERBUYITEM        = 1014;
  CM_USERGETDETAILITEM  = 1015;
  CM_DROPGOLD           = 1016;
  CM_1017               = 1017;
  CM_LOGINNOTICEOK      = 1018;
  CM_GROUPMODE          = 1019;
  CM_CREATEGROUP        = 1020;
  CM_ADDGROUPMEMBER     = 1021;
  CM_DELGROUPMEMBER     = 1022;
  CM_USERREPAIRITEM     = 1023;
  CM_MERCHANTQUERYREPAIRCOST = 1024;
  CM_DEALTRY            = 1025;
  CM_DEALADDITEM        = 1026;
  CM_DEALDELITEM        = 1027;
  CM_DEALCANCEL         = 1028;
  CM_DEALCHGGOLD        = 1029;
  CM_DEALEND            = 1030;
  CM_USERSTORAGEITEM    = 1031;
  CM_USERTAKEBACKSTORAGEITEM = 1032;
  CM_WANTMINIMAP        = 1033;
  CM_USERMAKEDRUGITEM   = 1034;
  CM_OPENGUILDDLG       = 1035;
  CM_GUILDHOME          = 1036;
  CM_GUILDMEMBERLIST    = 1037;
  CM_GUILDADDMEMBER     = 1038;
  CM_GUILDDELMEMBER     = 1039;
  CM_GUILDUPDATENOTICE  = 1040;
  CM_GUILDUPDATERANKINFO = 1041;
  CM_1042                = 1042;
  CM_ADJUST_BONUS       = 1043;
  CM_GUILDALLY          = 1044;
   CM_GUILDBREAKALLY     = 1045;
  CM_SPEEDHACKUSER      = 10430; //??

  CM_PROTOCOL           = 2000;
  CM_IDPASSWORD         = 2001;
  CM_ADDNEWUSER         = 2002;
  CM_CHANGEPASSWORD     = 2003;
  CM_UPDATEUSER         = 2004;
  CM_GETBACKPASSWORD    =2005;

  CM_PASSWORD=     2001;
  CM_CHGPASSWORD=2003;
  CM_SETPASSWORD =    2004;



  CM_THROW              = 3005;
  CM_HORSERUN           =3009        ;
  CM_TURN               = 3010;
  CM_WALK               = 3011;
  CM_SITDOWN            = 3012;
  CM_RUN                = 3013;
  CM_HIT                = 3014;
  CM_HEAVYHIT           = 3015;
  CM_BIGHIT             = 3016;
  CM_SPELL              = 3017;
  CM_POWERHIT           = 3018;
  CM_LONGHIT            = 3019;
  CM_CRSHIT             = 3020;
  CM_TWNHIT             = 3021;

  CM_WIDEHIT            = 3024;
  CM_FIREHIT            = 3025;

  CM_SAY                = 3030;

  // For Game Gate
  GM_OPEN             = 1;
  GM_CLOSE            = 2;
  GM_CHECKSERVER      = 3;// Send check signal to Server
  GM_CHECKCLIENT      = 4;// Send check signal to Client

  GM_DATA             = 5;
  GM_SERVERUSERINDEX  = 6;
  GM_RECEIVE_OK       = 7;
  GM_TEST             = 20;



  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT   = 2;
  OS_EVENTOBJECT  = 3;
  OS_GATEOBJECT   = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT     = 6;
  OS_DOOR         = 7;
  OS_ROON         = 8;

  RC_PLAYOBJECT  = 1;
  RC_MONSTER    = 2;
  RC_ANIMAL     = 6;
  RC_NPC        = 8;
  RC_PEACENPC   = 9; //jacky
  RC_ARCHERGUARD     = 10 ;//?
  RC_GUARD         =11;


  ISM_WHISPER           = 1234;

  //服务器模块之间
  SM_OPENSESSION        = 100;
  SM_CLOSESESSION       = 101;
  CM_CLOSESESSION       = 102;



  SM_PASSWORD          =1;  //?
  SM_PLAYDICE          =2;  /// ?
  SM_PASSWORDSTATUS    =3;   //?

  SM_RUSH               = 6;
  SM_RUSHKUNG           = 7;//
  SM_FIREHIT            = 8;    //烈火
  SM_BACKSTEP           = 9;
  SM_TURN               = 10;
  SM_WALK               = 11;   //走
  SM_SITDOWN            = 12;
  SM_RUN                = 13;
  SM_HORSERUN           = 13;       //?
  SM_HIT                = 14;   //砍
  SM_HEAVYHIT           = 15;//
  SM_BIGHIT             = 16;//
  SM_SPELL              = 17;   //使用魔法
  SM_POWERHIT           = 18;
  SM_LONGHIT            = 19;   //刺杀
  SM_DIGUP              = 20;
  SM_DIGDOWN            = 21;
  SM_FLYAXE             = 22;
  SM_LIGHTING           = 23;
  SM_WIDEHIT            = 24;
  SM_ALIVE              = 27;//
  SM_MOVEFAIL           = 28;//
  SM_HIDE               = 29;//
  SM_DISAPPEAR          = 30;
  SM_STRUCK             = 31;   //弯腰
  SM_DEATH              = 32;
  SM_SKELETON           = 33;
  SM_NOWDEATH           = 34;

  SM_ACTION_MIN = SM_RUSH;
  SM_ACTION_MAX = SM_WIDEHIT;
  SM_ACTION2_MIN=65072;
  SM_ACTION2_MAX =65073;
  
  SM_HEAR               = 40;
  SM_FEATURECHANGED     = 41;
  SM_41                   = 41;
  SM_USERNAME           = 42;
  SM_42                = 42;
  SM_43                 = 43;
  SM_WINEXP             = 44;
  SM_LEVELUP            = 45;
  SM_DAYCHANGING        = 46;

  SM_LOGON              = 50;
  SM_NEWMAP             = 51;
  SM_ABILITY            = 52;
  SM_HEALTHSPELLCHANGED = 53;
  SM_MAPDESCRIPTION     = 54;
  SM_SPELL2             = 117;

  SM_SYSMESSAGE         = 100;
  SM_GROUPMESSAGE       = 101;
  SM_CRY                = 102;
  SM_WHISPER            = 103;
  SM_GUILDMESSAGE       = 104;

  SM_ADDITEM            = 200;
  SM_BAGITEMS           = 201;
  SM_DELITEM            = 202;
  SM_UPDATEITEM         = 203;
  SM_ADDMAGIC           = 210;
  SM_SENDMYMAGIC        = 211;
  SM_DELMAGIC           = 212;

  SM_CERTIFICATION_SUCCESS =500;
  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND        = 502;
  SM_PASSWD_FAIL        = 503;
  SM_NEWID_SUCCESS      = 504;
  SM_NEWID_FAIL         = 505;
  SM_CHGPASSWD_SUCCESS  = 506;
  SM_CHGPASSWD_FAIL     = 507;
  SM_GETBACKPASSWD_SUCCESS=508;
  SM_GETBACKPASSWD_FAIL=509;
  
  SM_QUERYCHR           = 520;
  SM_NEWCHR_SUCCESS     = 521;
  SM_NEWCHR_FAIL        = 522;
  SM_DELCHR_SUCCESS     = 523;
  SM_DELCHR_FAIL        = 524;
  SM_STARTPLAY          = 525;
  SM_STARTFAIL          = 526;//SM_USERFULL
  SM_QUERYCHR_FAIL      = 527;
  SM_OUTOFCONNECTION    = 528; //?
  SM_PASSOK_SELECTSERVER= 529;
  SM_SELECTSERVER_OK    = 530;
  SM_NEEDUPDATE_ACCOUNT = 531;
  SM_UPDATEID_SUCCESS   = 532;
  SM_UPDATEID_FAIL      = 533;



  SM_DROPITEM_SUCCESS   = 600;
  SM_DROPITEM_FAIL      = 601;

  SM_ITEMSHOW           = 610;
  SM_ITEMHIDE           = 611;
//  SM_DOOROPEN           = 612;
  SM_OPENDOOR_OK        = 612;//
  SM_OPENDOOR_LOCK      = 613;
  SM_CLOSEDOOR          = 614;
  SM_TAKEON_OK          = 615;
  SM_TAKEON_FAIL        = 616;
  SM_TAKEOFF_OK         = 619;
  SM_TAKEOFF_FAIL       = 620;
  SM_SENDUSEITEMS       = 621;
  SM_WEIGHTCHANGED      = 622;
  SM_CLEAROBJECTS       = 633;
  SM_CHANGEMAP          = 634;
  SM_EAT_OK             = 635;
  SM_EAT_FAIL           = 636;
  SM_BUTCH              = 637;
  SM_MAGICFIRE          = 638;
  SM_MAGICFIRE_FAIL     = 639;
  SM_MAGIC_LVEXP        = 640;
  SM_DURACHANGE         = 642;
  SM_MERCHANTSAY        = 643;
  SM_MERCHANTDLGCLOSE   = 644;
  SM_SENDGOODSLIST      = 645;
  SM_SENDUSERSELL       = 646;
  SM_SENDBUYPRICE       = 647;
  SM_USERSELLITEM_OK    = 648;
  SM_USERSELLITEM_FAIL  = 649;
  SM_BUYITEM_SUCCESS    = 650;//?
  SM_BUYITEM_FAIL       = 651;//?
  SM_SENDDETAILGOODSLIST= 652;
  SM_GOLDCHANGED        = 653;
  SM_CHANGELIGHT        = 654;
  SM_LAMPCHANGEDURA     = 655;
  SM_CHANGENAMECOLOR    = 656;
  SM_CHARSTATUSCHANGED  = 657;
  SM_SENDNOTICE         = 658;
  SM_GROUPMODECHANGED   = 659;//
  SM_CREATEGROUP_OK     = 660;
  SM_CREATEGROUP_FAIL   = 661;
  SM_GROUPADDMEM_OK     = 662;
  SM_GROUPDELMEM_OK     = 663;
  SM_GROUPADDMEM_FAIL   = 664;
  SM_GROUPDELMEM_FAIL   = 665;
  SM_GROUPCANCEL        = 666;
  SM_GROUPMEMBERS       = 667;
  SM_SENDUSERREPAIR     = 668;
  SM_USERREPAIRITEM_OK  = 669;
  SM_USERREPAIRITEM_FAIL= 670;
  SM_SENDREPAIRCOST     = 671;
  SM_DEALMENU           = 673;
  SM_DEALTRY_FAIL       = 674;
  SM_DEALADDITEM_OK     = 675;
  SM_DEALADDITEM_FAIL   = 676;
  SM_DEALDELITEM_OK     = 677;
  SM_DEALDELITEM_FAIL   = 678;
  SM_DEALCANCEL         = 681;
  SM_DEALREMOTEADDITEM  = 682;
  SM_DEALREMOTEDELITEM  = 683;
  SM_DEALCHGGOLD_OK     = 684;
  SM_DEALCHGGOLD_FAIL   = 685;
  SM_DEALREMOTECHGGOLD  = 686;
  SM_DEALSUCCESS        = 687;
  SM_SENDUSERSTORAGEITEM= 700;
  SM_STORAGE_OK         = 701;
  SM_STORAGE_FULL       = 702;
  SM_STORAGE_FAIL       = 703;
  SM_SAVEITEMLIST       = 704;
  SM_TAKEBACKSTORAGEITEM_OK = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;

  SM_AREASTATE          = 708;
  SM_MYSTATUS           = 766;

  SM_DELITEMS           = 709;
  SM_READMINIMAP_OK     = 710;
  SM_READMINIMAP_FAIL   = 711;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;
  SM_MAKEDRUG_SUCCESS   = 713;
//  714
  SM_716 =716;//  716
  SM_MAKEDRUG_FAIL=65036;

  SM_CHANGEGUILDNAME    = 750;
  SM_SENDUSERSTATE      = 751;//
  SM_SUBABILITY         = 752;
  SM_OPENGUILDDLG       = 753;//
  SM_OPENGUILDDLG_FAIL  = 754;//
  SM_SENDGUILDMEMBERLIST= 756;//
  SM_GUILDADDMEMBER_OK  = 757;//
  SM_GUILDADDMEMBER_FAIL= 758;
  SM_GUILDDELMEMBER_OK  = 759;
  SM_GUILDDELMEMBER_FAIL= 760;
  SM_GUILDRANKUPDATE_FAIL= 761;
  SM_BUILDGUILD_OK      = 762;
  SM_BUILDGUILD_FAIL    = 763;
  SM_DONATE_OK          = 764;
  SM_DONATE_FAIL        = 765;

  SM_MENU_OK            = 767;//?
  SM_GUILDMAKEALLY_OK   = 768;
  SM_GUILDMAKEALLY_FAIL = 769;
  SM_GUILDBREAKALLY_OK  = 770;//?
  SM_GUILDBREAKALLY_FAIL= 771;//?
  SM_DLGMSG             = 772;//Jacky
  SM_SPACEMOVE_HIDE     = 800;
  SM_SPACEMOVE_SHOW     = 801;
  SM_RECONNECT          = 802;//
  SM_GHOST              = 803;
  SM_SHOWEVENT          = 804;
  SM_HIDEEVENT          = 805;
  SM_SPACEMOVE_HIDE2    = 806;
  SM_SPACEMOVE_SHOW2    = 807;
  SM_TIMECHECK_MSG      = 810;
  SM_ADJUST_BONUS       = 811; //?

  SM_OPENHEALTH         = 1100;
  SM_CLOSEHEALTH        = 1101;

  SM_BREAKWEAPON        = 1102;
  SM_INSTANCEHEALGUAGE  = 1103; //??
  SM_CHANGEFACE         = 1104;
  SM_VERSION_FAIL       = 1106;

  SM_ITEMUPDATE         = 1500;
  SM_MONSTERSAY         = 1501;
  SM_CRSHIT             = 10014;
  SM_GAMEGOLDNAME       =10015; //?
  SM_SERVERCONFIG       =10016; //?



  

  SM_EXCHGTAKEON_OK=65023;
  SM_EXCHGTAKEON_FAIL=65024;


  SM_TEST=65037;
  SM_THROW=65069;  


  RM_DELITEMS           = 9000;//Jacky
  RM_TURN               = 10001;
  RM_WALK               = 10002;
  RM_RUN                = 10003;
 
  RM_HIT                = 10004;
   RM_HEAVYHIT          = 10005;
  RM_BIGHIT            = 10006;
  RM_SPELL              = 10007;
  RM_SPELL2             = 10008;
  RM_POWERHIT           = 10009;
  RM_MOVEFAIL           = 10010;
  RM_LONGHIT            = 10011;
  RM_WIDEHIT            = 10012;
  RM_PUSH               = 10013;
  RM_FIREHIT            = 10014;
   RM_CRSHIT            = 10018;
     RM_41               = 41;
     RM_42               = 42;
     RM_43               = 43;
 
  RM_RUSH               = 10015;
  RM_RUSHKUNG           = 10016;
   RM_HORSERUN           = 10017;

  RM_STRUCK             = 10020;
  RM_DEATH              = 10021;
  RM_DISAPPEAR          = 10022;
  RM_MAGSTRUCK          = 10025;
  RM_MAGHEALING         = 10026;  
  RM_STRUCK_MAG         = 10027;
  RM_MAGSTRUCK_MINE     = 10028;
  RM_INSTANCEHEALGUAGE  = 10029; //jacky
  RM_HEAR               = 10030;
  RM_WHISPER            = 10031;
  RM_CRY                = 10032;
  RM_RIDE               = 10033;
  RM_WINEXP             = 10044;
  RM_USERNAME           = 10043;
  RM_LEVELUP            = 10045;
  RM_CHANGENAMECOLOR    = 10046;
  RM_MENU_OK            =10077; //?
  RM_MERCHANTDLGCLOSE   =10048; //?
  RM_SENDDELITEMLIST    =10049 ; //?

  RM_LOGON              = 10050;
  RM_ABILITY            = 10051;
  RM_HEALTHSPELLCHANGED = 10052;
  RM_DAYCHANGING        = 10053;
  RM_ALIVE              = 10054; ///?        
  RM_SENDUSERSREPAIR    =10055 ; //?  以下有问题   //////////////
  RM_SENDGOODSLIST      = 645;
  RM_SENDUSERSELL           =646;
  RM_USERMAKEDRUGITEMLIST   =712;
  RM_USERSTORAGEITEM     =700;
 // RM_USERGETBACKITEM     =  1032;
//  RM_SPACEMOVE_FIRE      = 1033;
  RM_BUYITEM_SUCCESS     = 650;
  RM_BUYITEM_FAIL        = 651;
  RM_SENDDETAILGOODSLIST    = 652;
  RM_SENDUSERREPAIR        =668;
  RM_SENDBUYPRICE          = 647;
  RM_USERSELLITEM_OK       = 648;
  RM_USERSELLITEM_FAIL    = 649;
  RM_MAKEDRUG_SUCCESS     =2092;
  RM_MAKEDRUG_FAIL        =2093;
  RM_SENDREPAIRCOST       =2080;
  RM_USERREPAIRITEM_FAIL  =2082;
  RM_USERREPAIRITEM_OK     =2081;

  RM_ADJUST_BONUS         = 811;

  RM_BUILDGUILD_OK        = 762;
  RM_BUILDGUILD_FAIL      = 763;
  RM_DONATE_OK            =2139;
  RM_GAMEGOLDCHANGED      =2189 ;//?
  RM_SPACEMOVE_SHOW2      =2190;
  RM_MYSTATUS            =2191;
  RM_DELAYPUSHED           =2192;






//////////////////
  RM_SYSMESSAGE         = 10100;
  RM_10101              = 10101;
  RM_GROUPMESSAGE       = 10102;
  RM_SYSMESSAGE2        = 10103;
  RM_GUILDMESSAGE       = 10104;
  RM_SYSMESSAGE3        = 10105; //Jacky
  RM_ITEMSHOW           = 10110;
  RM_ITEMHIDE           = 10111;
  RM_DOOROPEN           = 10112;
  RM_DOORCLOSE          = 10113;
  RM_SENDUSEITEMS       = 10114;
  RM_WEIGHTCHANGED      = 10115;
  RM_FEATURECHANGED     = 10116;
  RM_CLEAROBJECTS       = 10117;
  RM_CHANGEMAP          = 10118;
  RM_BUTCH              = 10119;
  RM_MAGICFIRE          = 10120;
  RM_MAGICFIREFAIL      = 10121;
  RM_SENDMYMAGIC        = 10122;
  RM_MAGIC_LVEXP        = 10123;
  RM_SKELETON           = 10024;
  RM_DURACHANGE         = 10125;
  RM_MERCHANTSAY        = 10126;
  RM_GOLDCHANGED        = 10136;
  RM_CHANGELIGHT        = 10137;
 
  RM_LAMPCHANGEDURA      = 10138;
  RM_CHARSTATUSCHANGED  = 10139;
  RM_GROUPCANCEL        = 10140;
  

  RM_POISON             = 10141; //?中毒
//  RM_SPACEMOVE_FIRE2    = 10142; //?
  RM_CHANGEGUILDNAME    = 10143; //?
   RM_USERGETBACKITEM    = 10147;   //ok
  RM_DELAYMAGIC         = 10154;
//  RM_DELAYPUSHED        = 10155;
  RM_10155              = 10155;

  RM_DIGUP              = 10200;
  RM_DIGDOWN            = 10201;
  RM_FLYAXE             = 10202;
  RM_LIGHTING           = 10204;
  RM_10205=             10205;


  RM_SUBABILITY         = 10302;
  RM_DONATE_FAIL         = 10306;
  RM_TRANSPARENT        = 10308;

   RM_SPACEMOVE_FIRE     =10330  ;
   RM_SPACEMOVE_FIRE2    =10330;
  RM_SPACEMOVE_SHOW     = 10331;
  RM_RECONNECTION        = 10332;
  RM_HIDEEVENT          = 10333;
  RM_SHOWEVENT          = 10334;
  RM_ZEN_BEE            = 10337;

  RM_10401              = 10401;
  RM_OPENHEALTH         = 10410;
  RM_CLOSEHEALTH        = 10411;
  RM_DOOPENHEALTH       = 10412;
  RM_BREAKWEAPON        =10413;
  RM_10414              = 10414;
  RM_CHANGEFACE         = 10415;
  RM_PASSWORD            = 10416;
   RM_PLAYDICE              =10500; 
  RM_PASSWORDSTATUS      =10501;


  RM_ITEMUPDATE         = 11000;
  RM_MONSTERSAY         = 11001;
  RM_MAKESLAVE          = 11002;
type
 /////////////////////////////////////////////
 TGList=class(Tlist)
   // 	CSTGLIST: TRTLCriticalSection;
  public

    procedure lock;
    procedure unlock;
 //   function  GetIndex(sName:String):Integer;
 //   function  AddRecord(sName:String;nIndex:Integer):Boolean;
  end;


 TGStringList=class(TStringlist)
    public

    procedure lock;
    procedure unlock;

  end;

 TQuestUnit=array[0..47]of byte;
 TQuestFlag=array[0..47]of byte;

 TIPaddr=record
 sIpaddr:string;
 dIPaddr:string;
 end;


  TClassProc= procedure(Sender: TObject);    //of object


 TPlugInit=  Pointer; //^integer;
 // PN_GETRGB=string;

 TCheckVersion=pchar ;

 Tplugproc=record
   sProcName:string[20];
   nProcAddr:^integer;
 end;

   TProcArray=array[0..255]of Tplugproc;


  Tobj=record
   sObjcName:string[20];
   obj:TObject;
  end;
  TObjectArray=array[0..255]of Tobj;
 

  TCheckCode=record
  dwThread0:INTEGER;
  end;





 TVarType=(vInteger,vString,vNone);

 TDynamicVar=record
  sName :string;
  VarType:TVarType;
  nInternet:integer;
  sString:string;
  end;
 pTDynamicVar=^TDynamicVar;

  TItemName=record
  nMakeIndex :integer;
  nItemIndex :integer;
  sItemName:string;
  end;
 pTItemName=^TItemName;

 
  TSessInfo=record
     sAccount       :  string;
     sIPaddr        :  string;
     nSessionID     :  integer;
     nPayMent       :  integer;
     nPayMode       :  integer;
     nSessionStatus :  integer;
     dwStartTick    :  integer;
     dwActiveTick   :  integer;
     nRefCount      :  integer;
    end;
  pTSessInfo=^TSessInfo; 

 

  TGateInfo=record
   boUsed          :boolean;
   Socket          :TCustomWinSocket;
   sAddr           :string;
   nPort           :integer;
    n520            :integer;
    UserList        :  TList;
    nUserCount      :integer;
    Buffer          :pchar;//array[0..2000]of char;
    nBuffLen        :integer;
    BufferList      :  TList ;
    boSendKeepAlive :boolean;
    nSendChecked    :integer;
    nSendBlockCount :integer;
    nSendMsgCount   :integer;
    nSendRemainCount:integer;
    dwSendTick      :integer;

    nSendMsgBytes:integer;
    nSendedMsgCount:integer;
    nSendBytesCount:integer;
    nSendCount:integer;
    dwSendCheckTick:integer;

    dwTime544       :integer;
  end;
 pTGateInfo=^TGateInfo ;




  TMagic=record
      wMagicId      :integer;
      sMagicName    : String;
      btEffectType  : Integer;
      btEffect      : Integer;
      wSpell        : Integer;
      wPower        : Integer;
      wMaxPower     : Integer;
      btJob         : Integer;
      TrainLevel:array[0..3]of integer;

      MaxTrain:array[0..3]of integer;

      btTrainLv     :integer;
      dwDelayTime   : Integer;
      btDefSpell    : Integer;
      btDefPower    : Integer;
      btDefMaxPower : Integer;
      sDescr        : String;
  end;
 pTMagic=^TMagic;


  TClientMagic=record
  Key    :char;
  Level   :byte;
  CurTrain  :integer;
  Def  :TMagic;


  end;





  TGoldChangeInfo=record
  sGameMasterName:string;
   sGetGoldUser  :string;
  nGold          :integer;


 end;
 pTGoldChangeInfo=^TGoldChangeInfo;

 TLoadDBInfo=record
   nGateIdx:integer;
   nSocket:integer;
   sAccount         :string;
  sCharName       :string;
   sIPaddr         :string;
  //LoadRcdInfo.boClinetFlag     := boFlag;
  nSessionID       :integer;
  nSoftVersionDate :integer;
   nPayMent         :integer;
   nPayMode         :integer;

  nGSocketIdx      :integer;

  dwNewUserTick    : dword;
   PlayObject       :Tobject;
   nReLoadCount     :integer;
   end;
 pTLoadDBInfo=^TLoadDBInfo ;

 
    TGameCmd=record
     sCmd:string;
      nPerMissionMin:byte;
      nPerMissionMax:byte;
     // nPermissionMin:integer;
     end;
   pTGameCmd=^TGameCmd ;


 
   TDefaultMessage = record
    Recog    :Integer;
    Ident    :Word;
    Param    :Word;
    Tag      :Word;
    Series   :Word;
  end;
   pTDefaultMessage=^TDefaultMessage;

   TOAbility=record
     Level         :word;  //0x198  //0x34
 //   bt035         :Byte;
    AC            :Word;  //0x19A  //0x36
    MAC           :Word;  //0x19C  //0x38
    DC            :Word;  //0x19E  //0x3A
    MC            :Word;  //0x1A0  //0x3C
    SC            :Word;  //0x1A2  //0x4E
    HP            :Word;  //0x1A4  //0x40
    MP            :Word;  //0x1A6  //0x42
    MaxHP         :Word;  //0x1A8  //0x44
    MaxMP         :Word;  //0x1AA  //0x46
    dw1AC         :Dword;  //0x1AC  //0x48
    Exp           :Dword;  //0x1B0  //0x4C
    MaxExp        :Dword;  //0x1B4  //0x50
    Weight        :Word;  //0x1B8   //0x54
    MaxWeight     :Word;  //0x1BA   //0x56
    WearWeight    :Byte;  //0x1BC   //0x58
    MaxWearWeight :Byte;  //0x1BD   //0x59
    HandWeight    :Byte;  //0x1BE   //0x5A
    MaxHandWeight :Byte;  //0x1BF   //0x5B
   end;

 TSlaveInfo=record
    sSalveName:string;
   btSalveLevel :byte;
   dwRoyaltySec  :dword;
   nKillCount    :integer;
   btSlaveExpLevel :byte;
   nHP            :integer;
   nMP            :integer;




    end;
  pTSlaveInfo=^TSlaveInfo;

  TQuestInfo=record
  wFlag:integer;
  btValue   :integer;
  nRandRage  :integer;


  end;

  TScript=record
  nQuest:integer;
  boQuest:boolean;
  RecordList:tlist;
  QuestInfo:array[0..9]of TQuestInfo;
  end;
  pTScript=^TScript ;


  





  TMsgColor=(c_Red,c_Green,c_Blue,c_White);
//  TMsgColor=record
//  end;

  TMsgType=(t_Mon,t_Hint,t_GM,t_System,t_Notice,t_Cust,t_Castle,t_Say) ;

  TMonStatus=(s_KillHuman,s_UnderFire,s_Die,s_MonGen)  ;


 // end;

  //   THumanUseItems=record
   //  end;
  


   TStatusTime=ARRAY[0..11] of  integer;



  TAddAbility =record  //OK    //Size 40
    Level         :Byte;  //0x198  //0x34
    bt035         :Byte;
    wAC            :Word;  //0x19A  //0x36
    wMAC           :Word;  //0x19C  //0x38
    wDC            :Word;  //0x19E  //0x3A
    wMC            :Word;  //0x1A0  //0x3C
    wSC            :Word;  //0x1A2  //0x4E
    wHP            :Word;  //0x1A4  //0x40
    wMP            :Word;  //0x1A6  //0x42
    MaxHP         :Word;  //0x1A8  //0x44
    MaxMP         :Word;  //0x1AA  //0x46
    dw1AC         :Dword;  //0x1AC  //0x48
    Exp           :Dword;  //0x1B0  //0x4C
    MaxExp        :Dword;  //0x1B4  //0x50
    Weight        :Word;  //0x1B8   //0x54
    MaxWeight     :Word;  //0x1BA   //0x56
    WearWeight    :Byte;  //0x1BC   //0x58
    MaxWearWeight :Byte;  //0x1BD   //0x59
    HandWeight    :Byte;  //0x1BE   //0x5A
    MaxHandWeight :Byte;  //0x1BF   //0x5B
    btWeaponStrong  :Byte;
    bt1DF            :Byte;
    wHitPoint         :Word;
    wSpeedPoint        :Word;

    wAntiPoison          :Word;
    wPoisonRecover        :Word;
    wHealthRecover        :Word;
    wSpellRecover        :Word;
    wAntiMagic            :dword;
    btLuck        :Byte;
    btUnLuck       :Byte;
    nHitSpeed     :integer;

  end;


 TNakedAbility=record

  DC              :word ;
  MC              :word ;
  SC              :word ;
  AC              :word ;
  MAC             :word ;
  HP              :word ;
  MP              :word ;
  Hit             :word ;
  Speed           :word ;
  X2              :word ;

 end;
 pTNakedAbility=^TNakedAbility ;

 TMapflag = record
    nMUSICID:integer;
    nL:integer;
  //  boSAFE:boolean;
 //   boDARK:boolean;
     boFIGHT:boolean;
     boFIGHT3:boolean;
 //   boDAY:boolean;
     sReConnectMap:string;
     boMUSIC :boolean;
     boEXPRATE:boolean;
     nEXPRATE:integer;
     nPKWINLEVEL:integer;
     nPKWINEXP:integer;
     nPKLOSTLEVEL:integer;
     nPKLOSTEXP:integer;
     boDECHP:boolean;
     nDECHPPOINT:integer;
     nDECHPTIME:integer;
     boINCHP:boolean;
     nINCHPPOINT:integer;
     nINCHPTIME  :integer;
     boDECGAMEGOLD   :boolean;
     nDECGAMEGOLD    :integer;
     nDECGAMEGOLDTIME    :integer;
     boDECGAMEPOINT      :boolean;
     nDECGAMEPOINT        :integer;
     nDECGAMEPOINTTIME     :integer;
     boINCGAMEGOLD         :boolean;
     nINCGAMEGOLD        :integer;
     nINCGAMEGOLDTIME      :integer;
     boINCGAMEPOINT        :boolean;
     nINCGAMEPOINT          :integer;
     nINCGAMEPOINTTIME       :integer;
     boRUNHUMAN              :boolean;
     boRUNMON                  :boolean;
     boNEEDHOLE                  :boolean;
     boNORECALL                    :boolean;
     boNOGUILDRECALL              :boolean;
     boNODEARRECALL                 :boolean;
     boNOMASTERRECALL                :boolean;
     boNORANDOMMOVE                   :boolean;
     boNODRUG                           :boolean;
     boMINE                               :boolean;

     boPKWINLEVEL  :boolean;

     boPKWINEXP     :boolean;
    boPKLOSTLEVEL      :boolean;
    boPKLOSTEXP           :boolean;

  //   nL                   :integer;

    // nNeedONOFF:integer;
    nRequestLevel      :Integer; //0x18 进入本地图所需等级
     nWidth           :Integer; //0x1C
     nHeight          :Integer; //0x20
     boDARK           :Boolean; //0x24
     boDAY            :Boolean; //0x25
     boDarkness       :Boolean;
     boDayLight       :Boolean;
     DoorList         :TList;   //0x28
     bo2C               :Boolean;
     boSAFE           :Boolean; //0x2D
     boFightZone      :Boolean; //0x2E
     boFight3Zone     :Boolean; //0x2F  //行会战争地图
     boQUIZ           :Boolean; //0x30
     boNORECONNECT    :Boolean; //0x31
  //   boNEEDHOLE       :Boolean; //0x32
  //   boNORECALL       :Boolean; //0x33
  //   boNOGUILDRECALL  :Boolean;
 //    boNODEARRECALL   :Boolean;
//     boNOMASTERRECALL :Boolean;
 //    boNORANDOMMOVE   :Boolean; //0x34
 //    boNODRUG         :Boolean; //0x35
//     boMINE           :Boolean; //0x36
     boNOPOSITIONMOVE :Boolean; //0x37
    sNoReconnectMap    :String;  //0x38
    QuestNPC           :TObject;  //0x3C
    nNEEDSETONFlag     :Integer;  //0x40
    nNeedONOFF         :Integer;  //0x44
    m_QuestList        :TList;   //0x48
    m_boRUNHUMAN       :Boolean;  //可以穿人
    m_boRUNMON         :Boolean;  //可以穿怪
    m_boINCHP          :Boolean;  //自动加HP值
    m_boINCGAMEGOLD    :Boolean;  //自动减游戏币
    m_boINCGAMEPOINT   :Boolean;  //自动加点
    m_boDECHP          :Boolean;  //自动减HP值
    m_boDECGAMEGOLD    :Boolean;  //自动减游戏币
    m_boDECGAMEPOINT   :Boolean;  //自动减点
    m_boMUSIC          :Boolean;  //音乐
    m_boEXPRATE        :Boolean;  //杀怪经验倍数
    m_boPKWINLEVEL     :Boolean;  //PK得等级
    m_boPKWINEXP       :Boolean;  //PK得经验
    m_boPKLOSTLEVEL    :Boolean;  //PK丢等级
    m_boPKLOSTEXP      :Boolean;  //PK丢经验
    m_nPKWINLEVEL      :Integer;  //PK得等级数
    m_nPKLOSTLEVEL     :Integer;  //PK丢等级
    m_nPKWINEXP        :Integer;  //PK得经验数
    m_nPKLOSTEXP       :Integer;  //PK丢经验
    m_nDECHPTIME       :Integer;  //减HP间隔时间
    m_nDECHPPOINT      :Integer;  //一次减点数
    m_nINCHPTIME       :Integer;  //加HP间隔时间
    m_nINCHPPOINT      :Integer;  //一次加点数
    m_nDECGAMEGOLDTIME :Integer;  //减游戏币间隔时间
    m_nDECGAMEGOLD     :Integer;  //一次减数量
    m_nDECGAMEPOINTTIME :Integer;  //减游戏点间隔时间
    m_nDECGAMEPOINT     :Integer;  //一次减数量
    m_nINCGAMEGOLDTIME :Integer;  //加游戏币间隔时间
    m_nINCGAMEGOLD     :Integer;  //一次加数量
    m_nINCGAMEPOINTTIME :Integer;  //加游戏币间隔时间
    m_nINCGAMEPOINT     :Integer;  //一次加数量
    m_nMUSICID         :Integer;  //音乐ID
    m_nEXPRATE         :Integer;  //经验倍率
    m_nMonCount        :Integer;
    m_nHumCount        :Integer;

 end;



 pTMapFlag=^TMapflag;

  TDoorStatus=record
   boOpened   :boolean;
   bo01       :boolean;
   n04        :integer;
   dwOpenTick :  integer;
   nRefCount  :  integer;

  end;
  pTDoorStatus=^TDoorStatus ;






  TCharDesc=record
  feature:integer;
  Status :word;


  end;

  TMessageBodyWL =record

  lParam1 :integer;
  lParam2  :integer;
  lTag1    :integer;
  lTag2    :integer;


  end;

  TMessageBodyW =record
   Param1 :word;
   Param2  :word;
   Tag1    :word;
   Tag2    :word;

  end;

  TShortMessage =record
  Ident   :integer;
  wMsg    :integer;
  end;

  TDoorInfo= record
    nX:integer;
     nY:integer;
     n08:integer;
     Status: pTDoorStatus;

  end;
  pTDoorInfo=^TDoorInfo;


 TProcessMessage=record
   wIdent:word;
   wParam:word;
   BaseObject:tObject;
   nParam1:integer;
   nParam2 :integer;
   nParam3  :integer;
   sMsg:string;

   dwDeliveryTime:integer;
   boLateDelivery:boolean;
   end;
   pTProcessMessage=^TProcessMessage;





 /////////////////////////////////////////////////

  TSrvNetInfo = record
    sIPaddr  :String;
    nPort    :Integer;
  end;
  pTSrvNetInfo = ^TSrvNetInfo;
  TStdItem =record      //OK
    Name         :String[14];
    StdMode      :Byte;
    Shape        :Byte;
    Weight       :Byte;
    AniCount     :Byte;
    Source       :Shortint;
    Reserved     :Byte;
    NeedIdentify :Byte;
    Looks        :Word;
    DuraMax      :Word;
    AC           :Word;
    MAC          :Word;
    DC           :Word;
    MC           :Word;
    SC           :Word;
    Need         :Byte;
    NeedLevel    :Byte;
    Price        :Integer;
  end;
  pTStdItem = ^TStdItem;

 TOStdItem=record
    Name         :String[14];
    StdMode      :Byte;
    Shape        :Byte;
    Weight       :Byte;
    AniCount     :Byte;
    Source       :Shortint;
    Reserved     :Byte;
    NeedIdentify :Byte;
    Looks        :Word;
    DuraMax      :Word;
    AC           :Word;
    MAC          :Word;
    DC           :Word;
    MC           :Word;
    SC           :Word;
    Need         :Byte;
    NeedLevel    :Byte;
    Price        :Integer;
    end;
 pTOStdItem=^TOStdItem;


 


  TClientItem = record  //OK
    S         :TStdItem;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
  end;
  TOClientItem=record
    S         :TStdItem;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
  end;

  PTClientItem =^TClientItem;


   TUserStateInfo=record
    Feature  :integer;
    UserName :string[15] ;
    NameColor :integer;
    GuildName   :string[14];
    GuildRankName: string[16];
    UseItems:array[0..45]of  TClientItem ;
  end;

   TOUserStateInfo =record
    Feature  :integer;
    UserName :string  ;
    NameColor :byte;
    GuildName   :string;
    GuildRankName :string;
    UseItems:array[0..45]of  TOClientItem ;
  end;




  TMonInfo = record
    sName        :String[14];
    btRace       :Byte;
    btRaceImg    :Byte;
    wAppr        :Word;
    btLevel      :Byte;
    btLifeAttrib :integer;
    dwExp        :integer;
    wLevel       :integer;
    boUndead     :Boolean;
    wCoolEye     :Word;
    wExp         :Word;
    wHP          :Word;
    btAC         :Byte;
    btMAC        :Byte;
    btDC         :Byte;
    btMaxDC      :Byte;
    btMC         :Byte;
    btSC         :Byte;
    btSpeed      :Byte;
    btHit        :Byte;
     wMP          : Integer  ;
     wAC          : Integer  ;
      wMAC         : Integer  ;
      wDC          : Integer  ;
     wMaxDC       : Integer  ;
      wMC          : Integer  ;
     wSC          : Integer  ;
      wSpeed       : Integer;
      wHitPoint    : Integer;


    wWalkSpeed   : Integer;
    wWalkStep    : Integer;
    wWalkWait    : Integer;
    wAttackSpeed :integer;
    ItemList     :TList;
  end;
  pTMonInfo = ^TMonInfo;

   TMonGenInfo=record
    sMapName:string;
    nX     :integer;
    nY      :integer;
    sMonName:string;
   end;
   pTMonGenInfo=^TMonGenInfo ;


  TMonItem =record
    n00: integer;
    n04: integer;
    sMonName: string;
    n18: integer;
  end;
  pTMonItem=^TMonItem ;

  TMagicInfo = record
    wMagicId     :Word;
    sMagicName   :String[12];
    btEffectType :Byte;
    btEffect     :Byte;
    wSpell       :Word;
    wPower       :Word;
    wMaxPower    :Word;
    btJob        :Byte;
    btDefSpell   :Byte;
    btDefPower   :Byte;
    btDefMaxPower:Byte;
    TrainLevel   :array[0..3] of Byte;
    MaxTrain     :array[0..3] of Integer;
    btTrainLv    :Byte;
    nDelayTime   :Integer;
    sDescr       :String;
  end;
  pTMagicInfo = ^TMagicInfo;

 
   TUserMagic=packed record      //dbs
    wMagIdx:word;

    btLevel:byte;
    btKey:byte;
    nTranPoint:integer;
   // UserMagic:TMagicInfo;
    end;

   Tm2UserMagic=packed record   //for m2
    wMagIdx:word;

    btLevel:byte;
    btKey:byte;
    nTranPoint:integer;
    MagicInfo:pTMagic;
    end;
  pTUserMagic=^Tm2UserMagic;


  THumMagicInfo=record
    wMagIdx:integer;
    btKey:byte;
    btLevel:byte;
    nTranPoint:integer;
    UserMagic:TMagicInfo;
  end;
  pTHumMagicInfo= ^THumMagicInfo;

  TMinMap = record
    sName  :String[17];
    nID    :Integer;
  end;
  pTMinMap =^TMinMap;
  TMapRoute = record
    sSMapNO    :String[17];
    nDMapX     :Integer;
    nSMapY     :Integer;
    sDMapNO    :String[17];
    nSMapX     :Integer;
    nDMapY     :Integer;
  end;
  pTMapRoute = ^TMapRoute;
  TMapInfo = record
    sName             :String[17];
    sMapNO            :String[17];
    nL                :Integer; //0x10
    nServerIndex      :Integer; //0x24
    nNEEDONOFFFlag    :Integer; //0x28
    boNEEDONOFFFlag   :Boolean; //0x2C
    sShowName         :String;  //0x4C
    sReConnectMap     :String;  //0x50
    boSAFE            :Boolean; //0x51
    boDARK            :Boolean; //0x52
    boFIGHT           :Boolean; //0x53
    boFIGHT3          :Boolean; //0x54
    boDAY             :Boolean; //0x55
    boQUIZ            :Boolean; //0x56
    boNORECONNECT     :Boolean; //0x57
    boNEEDHOLE        :Boolean; //0x58
    boNORECALL        :Boolean; //0x59
    boNORANDOMMOVE    :Boolean; //0x5A
    boNODRUG          :Boolean; //0x5B
    boMINE            :Boolean; //0x5C
    boNOPOSITIONMOVE  :Boolean; //0x5D
  end;
  pTMapInfo = ^TMapInfo;


  TOSObject =record
  btType:byte;
  CellObj:TObject;
  dwAddTime:integer;
  end;
  pTOSObject= ^TOSObject;

  TUnbindInfo = record
    nUnbindCode  :Integer;
    sItemName    :String[14];
  end;
  pTUnbindInfo =^TUnbindInfo;
 
  TQuestDiaryInfo = record
    QDDinfoList:TList;
  end;
  pTQuestDiaryInfo = ^TQuestDiaryInfo;

  TAdminInfo = record
    nLv      :Integer;
    sChrName :String[14];
    sIPaddr:string[20];
  end;
  pTAdminInfo = ^TAdminInfo;

  TAbility = record  //OK    //Size 40
    Level         :word;  //0x198  //0x34
 //   bt035         :Byte;
    AC            :Word;  //0x19A  //0x36
    MAC           :Word;  //0x19C  //0x38
    DC            :Word;  //0x19E  //0x3A
    MC            :Word;  //0x1A0  //0x3C
    SC            :Word;  //0x1A2  //0x4E
    HP            :Word;  //0x1A4  //0x40
    MP            :Word;  //0x1A6  //0x42
    MaxHP         :Word;  //0x1A8  //0x44
    MaxMP         :Word;  //0x1AA  //0x46
    dw1AC         :Dword;  //0x1AC  //0x48
    Exp           :Dword;  //0x1B0  //0x4C
    MaxExp        :Dword;  //0x1B4  //0x50
    Weight        :Word;  //0x1B8   //0x54
    MaxWeight     :Word;  //0x1BA   //0x56
    WearWeight    :Byte;  //0x1BC   //0x58
    MaxWearWeight :Byte;  //0x1BD   //0x59
    HandWeight    :Byte;  //0x1BE   //0x5A
    MaxHandWeight :Byte;  //0x1BF   //0x5B
  end;
  pTAbility=^TAbility;
  
  TWAbility = record
    dwExp         :LongWord; //0x194  怪物经验值(Dword)
    wHP           :Word;     //0x1A4
    wMP           :Word;     //0x1A6
    wMaxHP        :Word;     //0x1A8
    wMaxMP        :Word;     //0x1AA
  end;
  TMerchantInfo = record
    sScript     :String[14];
    sMapName    :String[14];
    nX          :Integer;
    nY          :Integer;
    sNPCName    :String[40];
    nFace       :Integer;
    nBody       :Integer;
    boCastle    :Boolean;
  end;                         
  pTMerchantInfo = ^TMerchantInfo;

  TSocketBuff = record
    Buffer  :PChar;  //0x24
    nLen    :Integer;//0x28
  end;
  pTSocketBuff = ^TSocketBuff;
  TSendBuff = record
    nLen    :Integer;
    Buffer  :array[0..DATA_BUFSIZE -1] of Char;
  end;
  pTSendBuff = ^TSendBuff;

  TUserItem =packed record               //24

    MakeIndex :LongWord;     //4
    wIndex    :Word;   // 2
    Dura      :Word;         //2
    DuraMax   :Word;         //2
    btValue:array[0..13]of byte;     //14
  end;


  PTUserItem = ^TUserItem;


  TMonDrop=record
       sItemName:string[20];
       nDropCount:word;
       nNoDropCount:word;
       nCountLimit:word;
  end;
  pTMonDrop=^TMonDrop;

 
//  Tcolor=(c_Red,c_Green,c_Blue,c_White);

  TMonSayMsg=record
  State:TMonStatus;
   Color:TMsgColor;
  nRate:word;
  sSayMsg:string;
  end;
 pTMonSayMsg=^TMonSayMsg;


  TMonItemInfo = record
    SelPoint:Integer;
    MaxPoint:Integer;
    ItemName:String[20];
    Count   :Integer;    
  end;
  PTMonItemInfo = ^TMonItemInfo;
  TMonsterInfo =record
    Name    :String[20];

    Itemlist:TList;
  end;
  PTMonsterInfo = ^TMonsterInfo;
  TMapItem = record
    Name      :String[15];
    Looks     :Word;
    AniCount  :Byte;
    Reserved  :Byte;
    Count     :Integer;
    UserItem  :TUserItem;
    OfBaseObject:tobject;
    dwCanPickUpTick:integer;
    DropBaseObject:tobject;
  end;
  PTMapItem = ^TMapItem;

 
 TVisibleBaseObject=record
   BaseObject:TObject;
   nVisibleFlag    :integer;
    MapItem:   PTMapItem  ;
    nX:integer;
    nY:integer;

   sName:string[15];
   wLooks:integer;
   end;
  pTVisibleBaseObject=^TVisibleBaseObject ;

 TVisibleMapItem=record
  nVisibleFlag    :integer;
    MapItem:   PTMapItem  ;
    nX:integer;
    nY:integer;

   sName:string[20];
   wLooks:integer;


 end;
 pTVisibleMapItem=^TVisibleMapItem ;

TSwitchDataInfo=record
  sMap:string[17];
  wX  :integer;
  wY   :integer;
  Abil  :TAbility;
  sChrName:string[14];
  nCode:integer;
  boC70:boolean;
  boBanShout     :boolean;
  boHearWhisper  :boolean;
  boBanGuildChat :boolean;
  boAdminMode    :boolean;
  boObMode       :boolean;
   BlockWhisperArr :   array[0..10]of string;
   SlaveArr:array [0..10]of TSlaveInfo;
   StatusValue:array[0..5]of word;
   StatusTimeOut:   array[0..5]of LongWord;
 end;
 pTSwitchDataInfo=^TSwitchDataInfo ;



  TRecordHeader=Packed record       // 28
       boDeleted:boolean;      //  1
       btCount:byte;            // 1
       nSelectID:word;          // 2
       dCreateDate:TDateTime ;   //8
     //  UpdateDate:TDateTime;      //19
       sname:string[15];           //28
  end;

  TLoadHuman=record

   sAccount:string[12];
   sChrName:string[14];
   sUserAddr:string[15];
   nSessionID:integer;

  end;



   THumItems= array[0..8]of TUserItem;

  THumanUseItems=array[0..12] of TUserItem;

   pTHumItems=^THumItems ;

   TBagItems =  array[0..45]of TUserItem;
   pTBagItems=^TBagItems ;

   TStorageItems=array[0..38]of TUserItem;   //38 5    43
   pTStorageItems=^TStorageItems ;

   THumMagic=array[0..19]of TUserMagic;
   pTHumMagic=^THumMagic ;

   THumAddItems=array[9..12]of TUserItem;
   pTHumAddItems=^THumAddItems  ;


  THumanRcd = record
    sUserID    :String[10];
    sChrName  :String[14];

    btLevel      :Byte;
    btHair       :Byte;
    btsex   :Byte;
    btJob      :Byte;
//    char	szTakeItem[10][12];

  
    Abil:      TAbility;
    sMapName     :String[15];
    btAttackMode :Byte;
    btIsAdmin    :Byte;
    nX           :Integer;
    nY           :Integer;
    nGold        :Integer;
    dwExp        :LongWord;
    boSelected   :boolean;
    sCurMap:string[15];
    HumItems:THumItems;//THumItems;
    BagItems :    TBagItems   ;
    Magic  :THumMagic ;
    StorageItems  :  TStorageItems ;
    HumAddItems :  THumAddItems  ;
    BonusAbil :TNakedAbility  ;
  end;
  pTHumanRcd = ^THumanRcd;



   THmrcd=packed record       //487     //没有使用，调试用
     sChrName  :String[14];
     sCurMap :string[16];    //16
     wCurX:word;             //2
     wCurY:word;            //2
     btDir    :byte;          //1
     btHair       :Byte;       //1
     btsex   :Byte;            //1
     btJob      :Byte;        //1
     nGold:integer;             //4
     Abil:      TAbility;       //40
     nPKPoint:integer;         //4
     sDearName:string[19];     //20
     sHomeMap:string[17];    // 16
     wHomeX:word;            // 2
     wHomeY:word;             //  2
     // btLevel      :Byte;

      btCreditPoint:integer;   //4
      btReLevel:integer;       //4

      sMasterName:string[20]  ;  //20
      sStoragePwd:string[42];     //15
      nGamePoint:integer;           //4
      boMaster: boolean;            //1

      btMarryCount:integer;          //4

      nGameGold:integer;              //4

      nPayMentPoint:integer;            //4

      wContribution:integer;            //4
      nBonusPoint:integer;              //4

      sAccount    :String[10];    //221   97
      unkon:array[0..217] of byte;   //  245

    HumItems:THumItems;//THumItems;            身上装备
    BagItems : TBagItems   ;                   //
    Magic  :THumMagic ;
    StorageItems  : TStorageItems ;
     unkown1:array[0..147] of byte;
    BonusAbil     : TNakedAbility  ;       //20
  //  HumAddItems   : THumAddItems  ;
    end;




 THumData=Packed record
     sChrName  :String[14];
     sCurMap :string[16];    //16
     wCurX:word;             //2
     wCurY:word;            //2
     btDir    :byte;          //1
     btHair       :Byte;       //1
     btsex   :Byte;            //1
     btJob      :Byte;        //1
     nGold:integer;             //4
     Abil:      TAbility;       //40
     nGameGold:integer;          //4
     sDearName:string[19];     //20
     sHomeMap:string[17];    // 16
     wHomeX:word;            // 2
     wHomeY:word;             //  2
     knownword:word;
     // btLevel      :Byte;

      btCreditPoint:integer;   //4
      btReLevel:integer;       //4

      sMasterName:string[20]  ;  //20
      sStoragePwd:string[42];     //15
      nGamePoint:integer;           //4
      nBonusPoint:integer;              //1
      nPayMentPoint:integer;           //4
          

      nPKPoint:integer;
      wContribution:integer;            //4
      btMarryCount:word;        //4
      boMaster: boolean;
      sAccount    :String[10];    //221   97
  //////
      wStatusTimeArr: Tstatustime;     //96; 48
      btAllowGroup    :byte;
      btF9            : byte;
      btAttatckMode       :byte;
       btIncHealth       :byte;
      btIncSpell          :byte;
      btIncHealing        :byte;
      btFightZoneDieCount  :byte;
      btEE                  :byte;
      boLockLogon           :boolean;
      btEF                   :byte;
      nHungerStatus         :integer;
      boAllowGuildReCall    :boolean;
      wGroupRcallTime       :word;
      dBodyLuck             :Double;     //8
      boAllowGroupReCall    :boolean;       //26              74
      QuestUnitOpen        : TQuestUnit;       //100
      QuestUnit               :TQuestUnit;    //0x11C   //100
      QuestFlag               :TQuestFlag;
  //    unkon:array[0..217] of byte;   //  218

    HumItems:THumItems;//THumItems;            身上装备
    BagItems : TBagItems   ;                   //
    Magic  :THumMagic ;
    StorageItems  : TStorageItems ;
    unkown1:array[0..147] of byte;
    BonusAbil     : TNakedAbility  ;       //20
    HumAddItems   : THumAddItems  ;

 //   unkown2:array[0..147]of byte;       //27
 end;

  pTHumData=^THumData;

  THumInfo=Packed record                    //72
      Header:TRecordHeader;            //28
      sChrName:string[14];             //14
      sAccount:string[9];             // 11
       boDeleted:boolean;                   //   1
       boSelected:boolean;      //               1
       btCount:byte;                    //操作记数       1
     // bcount:byte;
     // nSelectID:word;                  //        2
    //  dCreateDate:TDateTime ;          //       8
       UpdateDate:TDateTime; //20      //         8
       dModDate: TDateTime;            //          8

   //   sname:string[17];               //          17



  end;


 THumDataInfo =Packed record            //   3164
  Header:TRecordHeader;//THumInfo;
  data:THumData ;
//  boSelected   :boolean;
  end;
TLoadUser=record
  nSessionID:integer;
  nSocket:integer;
  nGateIdx:integer;
  nGSocketIdx:integer;
  sAccount  :string[10];
  sIPaddr    :string[20];
  nPayMent  :integer;
  nPayMode      :integer;
  dwNewUserTick     :integer;
  nSoftVersionDate     :integer;
  end;

 TUserOpenInfo=record
   sChrName:string[14];
   LoadUser:  TLoadDBInfo;
   HumanRcd : THumDataInfo;
 end;
 pTUserOpenInfo=^TUserOpenInfo;


 TSendMessage =record
       wIdent :word;

       Buff :pchar;

         wParam         :word;
         nParam1          :integer;
         nParam2          :integer;
         nParam3         :integer;
         dwDeliveryTime   :integer;
         BaseObject       :tObject;
        boLateDelivery:boolean;

 end;
   pTSendMessage =^TSendMessage;

  TObjectFeature = record
    btGender    :Byte;
    btWear      :Byte;
    btHair      :Byte;
    btWeapon    :Byte;
  end;
  pTObjectFeature = ^TObjectFeature;
  TStatusInfo = record
    nStatus      :Integer;  //0x60
    dwStatusTime :LongWord; //0x1E8
    sm218        :SmallInt;  //0x218
    dwTime220    :LongWord; //0x220
  end;
  TMsgHeader = record                         //0x20
    dwCode         :LongWord;//0x00
    nSocket        :integer; //0x04
     wGSocketIdx   :integer;
    wGateIndex     :Word;    //0x08
    wIdent        :integer;// :Word;    //0x0A
    nUserListIndex :integer; //0x0C
     wUserListIndex :integer;
     wTemp          :Word;    //0x0E
    nLength        :Integer; //0x10

  
  end;
  pTMsgHeader = ^TMsgHeader;

 TUserEntryInfo =record
    LoginId      :String[10];
    Password     :String[10];
    UserName     :String[20];
    SSNo         :String[14];
    Phone        :String[14];
    Quiz         :String[20];
    Answer       :String[12];
    EMail        :String[40];
  end;
  TUserEntryAddInfo =record
    Quiz2        :String[20];
    Answer2      :String[12];
    BirthDay     :String[10];
    MobilePhone  :String[13];
  end;

  TUserEntry  =Packed record
    sAccount      :String[10];
    SPassword     :String[10];
    SUserName     :String[20];
    SSSNo         :String[14];
    SPhone        :String[14];
    SQuiz         :String[20];
    SAnswer       :String[12];
    SEMail        :String[40];
  end;
  TUserEntryAdd  =Packed record
    SQuiz2        :String[20];
    SAnswer2      :String[12];
    SBirthDay     :String[10];
    SMobilePhone  :String[13];
    sMemo:         String[20];
    sMemo2:        String[20];
  end;


  tnameheander=Packed record
   sName:string;
   nSelectID:integer;
   UpdateDate:tdatetime;
  end;

   TAcDBInfo=Packed Record   //

      boDeleted:boolean;      //
      btCount:byte;
      nSelectID:word;

    CreateDate:TDateTime ;
    UpdateDate:TDateTime; //20


    sAccount:string[11];
  
  end;

  TAccountDBRecord= PACKED Record
   Header:TAcDBInfo;     //  32
   UserEntry:TUserEntry;
   UserEntryAdd:TUserEntryAdd;
   nErrorCount:integer;
   dwActionTick:integer;           //   32+14   -8
   unknow:string[38];
  // unkonw1:byte;         //38= 46-8
  end;



  TUserInfo = record
    bo00        :Boolean;   //0x00
    bo01        :Boolean;   //0x01 ?
    bo02        :Boolean;   //0x02 ?
    bo03        :Boolean;   //0x03 ?
    n04         :Integer;   //0x0A ?
    n08         :integer;   //0x0B ?
    bo0C        :Boolean;   //0x0C ?
    bo0D        :Boolean;   //0x0D
    bo0E        :Boolean;   //0x0E ?
    bo0F        :Boolean;   //0x0F ?
    n10         :Integer;   //0x10 ?
    n14         :Integer;   //0x14 ?
    n18         :Integer;   //0x18 ?
    sStr        :String[20];//0x1C
    nSocket     :integer;   //0x34
    nGateIndex  :Integer;   //0x38
    n3C         :integer;   //0x3C
    n40         :integer;   //0x40 ?
    n44         :integer;   //0x44
    List48      :TList;     //0x48
    Cert        :TObject;   //0x4C
    dwTime50    :LongWord;  //0x50
    bo54        :Boolean;   //0x54
  end;
  pTUserInfo = ^TUserInfo;

  TGlobaSessionInfo = record
    sAccount    :String;
    sIPaddr     :String;
    nSessionID  :Integer;
    n24         :Integer;
    bo28        :Boolean;
    dwAddTick   :LongWord;
    dAddDate    :TDateTime;
    boLoadRcd:BOOLEAN;
    boStartPlay:BOOLEAN;
  end;
  pTGlobaSessionInfo = ^TGlobaSessionInfo;

 var
            CSTGLIST       :TRTLCriticalSection;
            CSTGsLIST       :TRTLCriticalSection;
implementation

   procedure TGlist.lock;
   begin
   //   EnterCriticalSection(CSTGLIST);
   end;

    procedure TGlist.unlock;
    begin
   //    LeaveCriticalSection(CSTGLIST);
    end;


    procedure TGStringList.lock;
   begin
   //  EnterCriticalSection(CSTGsLIST);
   end;

    procedure TGStringList.unlock;
    begin
    //   LeaveCriticalSection(CSTGsLIST);
    end;

end.

