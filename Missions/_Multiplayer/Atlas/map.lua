include('translation_const');

--Extra interface bit for additional map functions

--Custom interface properties
Background2={bevel=true,
	bevel_colour1=GRAY(10),
	bevel_colour2=GRAY(10),
	gradient_colour1=RGBA(32,32,32,220),
	gradient_colour2=RGBA(32,32,32,220),
	gradient=true};

Background3={bevel=true,
	bevel_colour1=GRAY(0),
	bevel_colour2=GRAY(0),
	gradient_colour1=RGBA(50,50,50,220),
	gradient_colour2=RGBA(50,50,50,220),
	gradient=true};
	
Area_Names = {};
Area_Names[15] = loc(NW); --'North-West'
Area_Names[16] = loc(NE); --'North-East';
Area_Names[17] = loc(SW); --'South-East';
Area_Names[18] = loc(SE); --'South-West';

No_Depot			= 0;	
Deathmatch 			= 0;	
Max_Tech 			= 0;
Order_Type 			= 0;
Crates_Delivered 	= 0;
Oil_Delivered 		= 0;
Sib_Delivered 		= 0;
Crates_Order 		= 0;
Oil_Order 			= 0;
Sib_Order 			= 0;
Waiting				= 0;
Is_Spectator		= 0;


ConvoyButtonWidth=math.max(SGUI_widelen(loc(SendTransport)),SGUI_widelen(loc(NW)),SGUI_widelen(loc(NE)),SGUI_widelen(loc(SW)),SGUI_widelen(loc(SE)))*10;
CloseButtonWidth=math.max(SGUI_widelen(loc(SideInterfaceButtonClose)),SGUI_widelen(loc(SideInterfaceButtonCancel)));
SideInterfaceMaxWidth=math.max(SGUI_widelen(loc(MainSideWindowTitle))*10,SGUI_widelen(loc(VictoryConditon))*10+60,SGUI_widelen(loc(YourTechLevel))*10+10,ConvoyButtonWidth+110);
ButtonOpenLength=math.max(SGUI_widelen(loc(SpecInterfaceButtonOpen)),SGUI_widelen(loc(SideInterfaceButtonOpen)))*10;
--PerspectiveLabel=math.max(SGUI_widelen(loc(Team1)),SGUI_widelen(loc(Team2)),SGUI_widelen(loc(Spectate)))*11;

--Interface element definitions

--Main Window	
SideInterface 									= {};
SideInterface.window							= {};
SideInterface.label 							= {};
SideInterface.button 							= {};
SideInterface.window.main 						= getWindowEX(game.window,anchorNone,XYWH(ScrWidth-SideInterfaceMaxWidth,ScrHeight*0.72-280,SideInterfaceMaxWidth,330),false,loc(MainSideWindowTitle),Background2,{title_colour=RGBA(40,40,40,200),title_border_colour=MenuColour_Background6,title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_18B});
SideInterface.button_open 						= getButtonEX_Gradient(game.window,anchorNone,XYWH(ScrWidth-ButtonOpenLength,ScrHeight*0.72,ButtonOpenLength,50),-1,'LUA_OpenSideInterface();',GradButton_Grey_Dark,{text=loc(SideInterfaceButtonOpen),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SideInterface.button_close 						= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)-CloseButtonWidth*12-10,getHeight(SideInterface.window.main)-(30+5),CloseButtonWidth*12,30),-1,'LUA_HideSideInterface();',GradButton_Red,{text=loc(SideInterfaceButtonClose),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SideInterface.label.tech_level 					= getLabelEX(SideInterface.window.main,anchorNone,XYWH(10,40,SGUI_widelen(loc(YourTechLevel))*10,10),Tahoma_16B,loc(YourTechLevel)..' : ',{font_colour=WHITE()});	
SideInterface.label.tech_level.number 			= getLabelEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)-(10+10),40,10,10),Tahoma_16B,'0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.victory_condition			= getLabelEX(SideInterface.window.main,anchorNone,XYWH(10,65,SGUI_widelen(loc(VictoryConditon))*10,10),Tahoma_16B,loc(VictoryConditon)..' : ',{font_colour=WHITE()});
SideInterface.label.victory_condition_number 	= getLabelEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)-(10+60),65,60,10),Tahoma_16B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.nodepot 					= getLabelEX(SideInterface.window.main,anchorNone,XYWH(10,90,getWidth(SideInterface.window.main)-20,getHeight(SideInterface.window.main)-90-40),Tahoma_16B,loc(NoDepotWarning),{colour1=RGBA(255,0,0,20),border_type=BORDER_TYPE_OUTER,border_colour=BLACKA(200),border_size=1,wordwrap=true,font_colour=RGBA(255,0,0,255),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SideInterface.label.lost 						= getLabelEX(SideInterface.window.main,anchorNone,XYWH(10,90,getWidth(SideInterface.window.main)-20,getHeight(SideInterface.window.main)-90-40),Tahoma_18B,loc(LostWarning),{colour1=RGBA(255,0,0,20),border_type=BORDER_TYPE_OUTER,border_colour=BLACKA(200),border_size=1,font_colour=RGBA(255,0,0,255),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SideInterface.button_upgrade 					= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(15,110,getWidth(SideInterface.window.main)-30,40),-1,'LUA_OpenTechUpgrade();',GradButton_Green,{text=loc(GetTechOrder),font_colour=WHITE(),fontname=Tahoma_16B});
SideInterface.button_reinforce 					= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(15,170,getWidth(SideInterface.window.main)-30,40),-1,'LUA_OpenReinforce();',GradButton_Green,{text=loc(ReinforcementOrder),font_colour=WHITE(),fontname=Tahoma_16B});
SideInterface.button_siberite 					= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(15,230,getWidth(SideInterface.window.main)-30,40),-1,'LUA_OpenSendSiberite()',GradButton_Green,{text=loc(SiberiteOrder),font_colour=WHITE(),fontname=Tahoma_16B});
SideInterface.button.cancel 					= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(10,getHeight(SideInterface.window.main)-(30+5),CloseButtonWidth*12,30),-1,'LUA_BackToMainSideInterface(); Order_Type = 0;',GradButton_Red,{text=loc(SideInterfaceButtonCancel),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Technology upgrades window
SideInterface.window.upgrade 					= getWindowEX(SideInterface.window.main,anchorNone,XYWH(10,90,getWidth(SideInterface.window.main)-20,getHeight(SideInterface.window.main)-90-40),false,loc(GetTechOrder),Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.upgrade_cost_label_crates 	= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(40,60,SGUI_widelen(loc(CostCrates))*10,10),Tahoma_14B,loc(CostCrates)..' : ',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_label_oil 		= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(40,90,SGUI_widelen(loc(CostOil))*10,10),Tahoma_14B,loc(CostOil)..' : ',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_label_siberite = getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(40,120,SGUI_widelen(loc(CostSiberite))*10,10),Tahoma_14B,loc(CostSiberite)..' : ',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_crates 		= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(getWidth(SideInterface.window.upgrade)-(100),60,60,10),Tahoma_14B,'0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.upgrade_cost_oil 			= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(getWidth(SideInterface.window.upgrade)-(100),90,60,10),Tahoma_14B,'0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.upgrade_cost_siberite 		= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(getWidth(SideInterface.window.upgrade)-(100),120,60,10),Tahoma_14B,'0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.button.upgrade_confirm 			= getButtonEX_Gradient(SideInterface.window.upgrade,anchorNone,XYWH(getWidth(SideInterface.window.upgrade)/2-SGUI_widelen(loc(ButtonConfirm))*10/2,getHeight(SideInterface.window.upgrade)-(30+15),SGUI_widelen(loc(ButtonConfirm))*10,30),-1,'OW_CUSTOM_COMMAND(204,2); Order_Type = 2;',GradButton_Green,{text=loc(ButtonConfirm),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Reinforcement calling window
SideInterface.window.reinforce 						= getWindowEX(SideInterface.window.main,anchorNone,XYWH(10,90,getWidth(SideInterface.window.main)-20,getHeight(SideInterface.window.main)-90-40),false,loc(ReinforcementOrder),Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.reinforce_amount 				= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2-15,35,30,25),Tahoma_18B,'0',{font_colour=WHITE(),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SideInterface.label.reinforce_cost_label_crates 	= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(40,70,SGUI_widelen(loc(CostCrates))*10,10),Tahoma_14B,loc(CostCrates)..' : ',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_label_oil 		= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(40,100,SGUI_widelen(loc(CostOil))*10,10),Tahoma_14B,loc(CostOil)..' : ',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_label_siberite 	= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(40,130,SGUI_widelen(loc(CostSiberite))*10,10),Tahoma_14B,loc(CostSiberite)..' : ',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_crates 			= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)-(100),70,60,10),Tahoma_14B,'0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.reinforce_cost_oil 				= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)-(100),100,60,10),Tahoma_14B,'0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.reinforce_cost_siberite 		= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)-(100),130,60,10),Tahoma_14B,'0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.button.reinforce_increase 			= getButtonEX_Gradient(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2+15,35,25,25),-1,'OW_CUSTOM_COMMAND(2021);',GradButton_Green,{text='+',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_20B});
SideInterface.button.reinforce_decrease 			= getButtonEX_Gradient(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2-40,35,25,25),-1,'OW_CUSTOM_COMMAND(2020);',GradButton_Green,{text='-',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_20B});
SideInterface.button.reinforce_confirm 				= getButtonEX_Gradient(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2-SGUI_widelen(loc(ButtonConfirm))*10/2,getHeight(SideInterface.window.reinforce)-(30+15),SGUI_widelen(loc(ButtonConfirm))*10,30),-1,'OW_CUSTOM_COMMAND(204,1); Order_Type = 1;',GradButton_Green,{text=loc(ButtonConfirm),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Siberite sending window
SideInterface.window.siberite 			= getWindowEX(SideInterface.window.main,anchorNone,XYWH(10,90,getWidth(SideInterface.window.main)-20,getHeight(SideInterface.window.main)-90-40),false,loc(SiberiteOrder),Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.sib_text			= getLabelEX(SideInterface.window.siberite,anchorNone,XYWH(getWidth(SideInterface.window.siberite)/2-SGUI_widelen(loc(SiberiteSent))*10/2,50,SGUI_widelen(loc(SiberiteSent))*10,10),Tahoma_16B,loc(SiberiteSent),{font_colour=WHITE(),text_halign=ALIGN_MIDDLE});
SideInterface.label.sent_sib			= getLabelEX(SideInterface.window.siberite,anchorNone,XYWH(getWidth(SideInterface.window.siberite)/2-60,80,120,10),Tahoma_16B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_MIDDLE});
SideInterface.button.siberite_confirm 	= getButtonEX_Gradient(SideInterface.window.siberite,anchorNone,XYWH(getWidth(SideInterface.window.siberite)/2-SGUI_widelen(loc(ButtonConfirm))*10/2,getHeight(SideInterface.window.siberite)-(30+15),SGUI_widelen(loc(ButtonConfirm))*10,30),-1,'OW_CUSTOM_COMMAND(204,3); Order_Type = 3;',GradButton_Green,{text=loc(ButtonConfirm),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Confirmed orders and pending resources window (upgrade/reinforcements/siberite)
SideInterface.window.orders						= getWindowEX(SideInterface.window.main,anchorNone,XYWH(10,90,getWidth(SideInterface.window.main)-20,getHeight(SideInterface.window.main)-90-40),false,loc(ConvoyStatus),Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.orders_cost_label_crates 	= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(40,40,SGUI_widelen(loc(CostCrates))*10,10),Tahoma_14B,loc(CostCrates)..' : ',{font_colour=WHITE()});
SideInterface.label.orders_cost_label_oil 		= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(40,65,SGUI_widelen(loc(CostOil))*10,10),Tahoma_14B,loc(CostOil)..' : ',{font_colour=WHITE()});
SideInterface.label.orders_cost_label_siberite 	= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(40,90,SGUI_widelen(loc(CostSiberite))*10,10),Tahoma_14B,loc(CostSiberite)..' : ',{font_colour=WHITE()});
SideInterface.label.orders_cost_crates 			= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)-(100),40,60,10),Tahoma_14B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.orders_cost_oil 			= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)-(100),65,60,10),Tahoma_14B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.orders_cost_siberite 		= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)-(100),90,60,10),Tahoma_14B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_RIGHT});
SideInterface.label.sib_text_order				= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)/2-SGUI_widelen(loc(SiberiteSent))/2*10,40,SGUI_widelen(loc(SiberiteSent))*10,15),Tahoma_16B,loc(SiberiteSent),{font_colour=WHITE(),text_halign=ALIGN_MIDDLE});
SideInterface.label.sent_sib_order				= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)/2-60,70,120,10),Tahoma_16B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_MIDDLE});
SideInterface.button.orders_pick_zone 			= getButtonEX_Gradient(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)/2-ConvoyButtonWidth/2,120,ConvoyButtonWidth+5,30),-1,'OW_CUSTOM_COMMAND(2040);',GradButton_Green,{text='',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SideInterface.button.orders_left 				= getButtonEX_Gradient(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)/2-ConvoyButtonWidth/2-4-30,120,30,30),-1,'OW_CUSTOM_COMMAND(2041);',GradButton_Grey_Light,{text='<<',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_20B});
SideInterface.button.orders_right 				= getButtonEX_Gradient(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)/2+ConvoyButtonWidth/2+8,120,30,30),-1,'OW_CUSTOM_COMMAND(2042);',GradButton_Grey_Light,{text='>>',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_20B});
SideInterface.button.orders_send		 		= getButtonEX_Gradient(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.orders)/2-ConvoyButtonWidth/2,155,ConvoyButtonWidth+5,30),-1,'OW_CUSTOM_COMMAND(205);',GradButton_Grey_Dark,{text=loc(SendTransport),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Waiting for reinforcements window
SideInterface.window.waiting 				= getWindowEX(SideInterface.window.main,anchorNone,XYWH(10,90,getWidth(SideInterface.window.main)-20,getHeight(SideInterface.window.main)-90-40),false,loc(WaitingTransfer),Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.time_remaining 			= getLabelEX(SideInterface.window.waiting,anchorNone,XYWH(getWidth(SideInterface.window.waiting)/2-SGUI_widelen(loc(RemainingTime))*10/2,getHeight(SideInterface.window.waiting)/2-40,SGUI_widelen(loc(RemainingTime))*10,20),Tahoma_18B,loc(RemainingTime),{font_colour=WHITE(),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SideInterface.label.time_remaining_counter 	= getLabelEX(SideInterface.window.waiting,anchorNone,XYWH(getWidth(SideInterface.window.waiting)/2-100,getHeight(SideInterface.window.waiting)/2,200,20),Tahoma_20B,'',{font_colour=WHITE(),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});

--Spectator window
SpecInterface 								= {};
SpecInterface.window						= {};
SpecInterface.window.team					= {};
SpecInterface.label							= {};
SpecInterface.label.tech_level 				= {};
SpecInterface.label.tech_level.number		= {};
SpecInterface.label.victory_progress		= {};

SpecInterface.window.main 						= getWindowEX(game.window,anchorNone,XYWH(ScrWidth-SGUI_widelen(loc(SpecTechLevelPart1))*10-SGUI_widelen(loc(SpecTechLevelPart2))*10-25,ScrHeight*0.72-405,SGUI_widelen(loc(SpecTechLevelPart1))*10+SGUI_widelen(loc(SpecTechLevelPart2))*10+25,400),false,loc(MainSpecWindowTitle),Background2,{title_colour=RGBA(32,32,32,200),title_border_colour=MenuColour_Background6,title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_18B});
SpecInterface.window.team[1]					= getWindowEX(SpecInterface.window.main,anchorNone,XYWH(10,30,SGUI_widelen(loc(SpecTechLevelPart1))*10+SGUI_widelen(loc(SpecTechLevelPart2))*10+5,160),false,loc(Team1),Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B,text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SpecInterface.window.team[2]					= getWindowEX(SpecInterface.window.main,anchorNone,XYWH(10,200,SGUI_widelen(loc(SpecTechLevelPart1))*10+SGUI_widelen(loc(SpecTechLevelPart2))*10+5,160),false,loc(Team2),Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B,text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SpecInterface.label.victory_progress[1]			= getLabelEX(SpecInterface.window.team[1],anchorNone,XYWH(getWidth(SpecInterface.window.team[1])/2-120,35,240,10),Tahoma_16B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_MIDDLE});
SpecInterface.label.victory_progress[2]			= getLabelEX(SpecInterface.window.team[2],anchorNone,XYWH(getWidth(SpecInterface.window.team[2])/2-120,35,240,10),Tahoma_16B,'0 / 0',{font_colour=WHITE(),text_halign=ALIGN_MIDDLE});
SpecInterface.button_open 						= getButtonEX_Gradient(game.window,anchorNone,XYWH(ScrWidth-ButtonOpenLength,ScrHeight*0.72-55,ButtonOpenLength,50),-1,'LUA_OpenSpecInterface();',GradButton_Grey_Dark,{text=loc(SpecInterfaceButtonOpen),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SpecInterface.button_close 						= getButtonEX_Gradient(SpecInterface.window.main,anchorNone,XYWH(getWidth(SpecInterface.window.main)-SGUI_widelen(loc(SpecInterfaceButtonClose))*12-10,getHeight(SpecInterface.window.main)-(30+5),SGUI_widelen(loc(SpecInterfaceButtonClose))*12,30),-1,'LUA_HideSpecInterface();',GradButton_Red,{text=loc(SpecInterfaceButtonClose),font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Perspective changer
--PerspectiveChanger					= {};
--PerspectiveChanger.label			= getLabelEX(game.window,anchorNone,XYWH(ScrWidth/2-PerspectiveLabel/2,0,PerspectiveLabel,40),Tahoma_18B,'',{colour1=RGBA(0,0,0,255),border_type=BORDER_TYPE_OUTER,border_colour=BLACKA(200),border_size=1,wordwrap=true,font_colour=RGBA(255,0,0,255),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
--PerspectiveChanger.button_prev		= getButtonEX_Gradient(game.window,anchorNone,XYWH(ScrWidth/2-PerspectiveLabel/2-30-5,0,30,40),-1,'OW_CUSTOM_COMMAND(501)',GradButton_Grey_Light,{text='<<',font_colour=WHITE(),fontname=Tahoma_18B});
--PerspectiveChanger.button_next		= getButtonEX_Gradient(game.window,anchorNone,XYWH(ScrWidth/2+PerspectiveLabel/2+5,0,30,40),-1,'OW_CUSTOM_COMMAND(502)',GradButton_Grey_Light,{text='>>',font_colour=WHITE(),fontname=Tahoma_18B});


--Initiate side interface
function StartSideInterface()		
	setVisible(SideInterface.button_open,true);
	setVisible(SideInterface.window.main,false);
	setVisible(SideInterface.label.nodepot,false);
	setVisible(SideInterface.label.lost,false);
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,false);
	
	setVisible(SideInterface.window.upgrade,false);	
	setVisible(SideInterface.window.reinforce,false);	
	setVisible(SideInterface.window.siberite,false);	
	setVisible(SideInterface.window.orders,false);							
	
	setVisible(SpecInterface.button_open,true);
	setVisible(SpecInterface.window.main,false);
end;
	
 --Initiate spec interface
function StartSpecInterface()		
	setVisible(SpecInterface.button_open,true);
	setVisible(SpecInterface.window.main,false);

	if Is_Spectator==1 then
		setVisible(SideInterface.button_open,false);
		setVisible(SideInterface.window.main,false);
	elseif Is_Spectator==0 then
		setVisible(SideInterface.button_open,true);
		setVisible(SideInterface.window.main,false);
	end		
end;

--Initiate perspective changer (only for spectators)
--function StartPerspectiveChanger()
--	if Is_Spectator==1 then
--		setVisible(PerspectiveChanger.label,true);
--		setVisible(PerspectiveChanger.button_prev,true);
--		setVisible(PerspectiveChanger.button_next,true);
--	elseif Is_Spectator==0 then
--		setVisible(PerspectiveChanger.label,false);
--		setVisible(PerspectiveChanger.button_prev,false);
--		setVisible(PerspectiveChanger.button_next,false);
--	end;
--end;

--Hide interface
function LUA_HideSideInterface()
	setVisible(SideInterface.button_open,true);
	setVisible(SpecInterface.button_open,true);
	setVisible(SideInterface.window.main,false);
end;

--Hide spectator interface
function LUA_HideSpecInterface()
	setVisible(SpecInterface.button_open,true);
	setVisible(SpecInterface.window.main,false);
	
	if Is_Spectator==0 then
		setVisible(SideInterface.button_open,true);
	end;
end;

--Open interface
function LUA_OpenSideInterface()
	setVisible(SideInterface.window.main,true);
	setVisible(SpecInterface.button_open,false);
	setVisible(SideInterface.button_open,false);
end;

--Open spectator interface
function LUA_OpenSpecInterface()
	setVisible(SpecInterface.window.main,true);
	setVisible(SpecInterface.window.team[1],true);			
	setVisible(SpecInterface.window.team[2],true);			
	setVisible(SpecInterface.label.victory_progress[1],true);	
	setVisible(SpecInterface.label.victory_progress[2],true);	
	setVisible(SpecInterface.button_open,false);
	setVisible(SideInterface.button_open,false);
end;

--Side interface when there is no depot built by the side
function LUA_NoDepot()
	No_Depot = 1;
	setVisible(SideInterface.label.nodepot,true);
	setVisible(SideInterface.label.lost,false);
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,false);
	setVisible(SideInterface.window.upgrade,false);
	setVisible(SideInterface.window.reinforce,false);
	setVisible(SideInterface.window.siberite,false);
	setVisible(SideInterface.window.orders,false);
	setVisible(SideInterface.window.waiting,false);
	setEnabled(SideInterface.button.orders_pick_zone,true);
	updateGradButton(SideInterface.button.orders_pick_zone,GradButton_Green);
	setVisible(SideInterface.button.orders_left,true);
	setVisible(SideInterface.button.orders_right,true);
	OW_CUSTOM_COMMAND(300);
end;

--Side interface when depot is built
function LUA_IsDepot()
	No_Depot = 0;
	setVisible(SideInterface.label.nodepot,false);
	setVisible(SideInterface.label.lost,false);
	
	if Waiting==1 then
		setVisible(SideInterface.window.waiting,true);
	elseif Waiting==0 then
		LUA_BackToMainSideInterface();
	end;
end;

--Side interface when side lost
function LUA_Lost()
	setVisible(SideInterface.label.nodepot,false);
	setVisible(SideInterface.label.lost,true);
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,false);
	setVisible(SideInterface.window.upgrade,false);
	setVisible(SideInterface.window.reinforce,false);
	setVisible(SideInterface.window.siberite,false);
	setVisible(SideInterface.window.orders,false);
	setVisible(SideInterface.window.waiting,false);
	OW_CUSTOM_COMMAND(301);
end;

--Side interface when all tech levels were bought
function LUA_SideTechMax()
	setEnabled(SideInterface.button_upgrade,false);
	updateGradButton(SideInterface.button_upgrade,GradButton_Grey_Dark);
	
	Max_Tech = 1;
end;

--Side interface when upgrade chosen
function LUA_OpenTechUpgrade()
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,true);

	setVisible(SideInterface.window.upgrade,true);
	OW_CUSTOM_COMMAND(201);
end;

--Side interface when reinforcement chosen
function LUA_OpenReinforce()
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,true);

	setVisible(SideInterface.window.reinforce,true);
	OW_CUSTOM_COMMAND(202);
end;

--Side interface when sending siberite
function LUA_OpenSendSiberite()
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,true);

	setVisible(SideInterface.window.siberite,true);
	OW_CUSTOM_COMMAND(203);
end;

--Side interface when going back to main window
function LUA_BackToMainSideInterface()
	setVisible(SideInterface.window.upgrade,false);
	setVisible(SideInterface.window.reinforce,false);
	setVisible(SideInterface.window.siberite,false);
	setVisible(SideInterface.window.orders,false);
	setVisible(SideInterface.window.waiting,false);
	setVisible(SideInterface.button.cancel,false);
	
	if No_Depot==0 and Waiting==0 then;
		setVisible(SideInterface.button_upgrade,true);
		setVisible(SideInterface.button_siberite,true);
		setVisible(SideInterface.button_reinforce,true);
	end;
	
	if Max_Tech==0 and Deathmatch==0 and No_Depot==0 and Waiting==0 then
		setEnabled(SideInterface.button_upgrade,true);
		setEnabled(SideInterface.button_siberite,true);
		updateGradButton(SideInterface.button_siberite,GradButton_Green);
		updateGradButton(SideInterface.button_siberite,GradButton_Green);
	elseif Max_Tech==0 and Deathmatch==1 and No_Depot==0 and Waiting==0 then
		setEnabled(SideInterface.button_upgrade,true);
		setEnabled(SideInterface.button_siberite,false);
		updateGradButton(SideInterface.button_siberite,GradButton_Green);
		updateGradButton(SideInterface.button_siberite,GradButton_Grey_Dark);
	elseif Max_Tech==1 and Deathmatch==0 and No_Depot==0 and Waiting==0 then
		setEnabled(SideInterface.button_upgrade,false);
		setEnabled(SideInterface.button_siberite,true);
		updateGradButton(SideInterface.button_siberite,GradButton_Grey_Dark);
		updateGradButton(SideInterface.button_siberite,GradButton_Green);
	elseif Max_Tech==1 and Deathmatch==1 and No_Depot==0 and Waiting==0 then
		setEnabled(SideInterface.button_upgrade,false);
		setEnabled(SideInterface.button_siberite,false);
		updateGradButton(SideInterface.button_siberite,GradButton_Grey_Dark);
		updateGradButton(SideInterface.button_siberite,GradButton_Grey_Dark);	
	end;
	
	setEnabled(SideInterface.button.orders_pick_zone,true);
	updateGradButton(SideInterface.button.orders_pick_zone,GradButton_Green);
	setVisible(SideInterface.button.orders_left,true);
	setVisible(SideInterface.button.orders_right,true);
	
	OW_CUSTOM_COMMAND(301);
end;
	
--Side interface when order for reinforcements/upgrade has been issued
function LUA_OrderIssued()
	setVisible(SideInterface.window.upgrade,false);
	setVisible(SideInterface.window.reinforce,false);
	setVisible(SideInterface.window.siberite,false);
	
	setVisible(SideInterface.window.orders,true);
	setVisible(SideInterface.button.orders_pick_zone,true);
	setVisible(SideInterface.button.orders_send,true);
	setVisible(SideInterface.button.orders_right,true);
	setVisible(SideInterface.button.orders_left,true);
	setEnabled(SideInterface.button.orders_send,false);
			   
	if Order_Type == 1 then
		setVisible(SideInterface.label.orders_cost_label_crates,true);
		setVisible(SideInterface.label.orders_cost_label_oil,true);
		setVisible(SideInterface.label.orders_cost_label_siberite,true);
		setVisible(SideInterface.label.orders_cost_crates,true);
		setVisible(SideInterface.label.orders_cost_oil,true);
		setVisible(SideInterface.label.orders_cost_siberite,true);
		setVisible(SideInterface.label.sib_text_order,false);
		setVisible(SideInterface.label.sent_sib_order,false);
	
	elseif Order_Type == 2 then
		setVisible(SideInterface.label.orders_cost_label_crates,true);
		setVisible(SideInterface.label.orders_cost_label_oil,true);
		setVisible(SideInterface.label.orders_cost_label_siberite,true);
		setVisible(SideInterface.label.orders_cost_crates,true);
		setVisible(SideInterface.label.orders_cost_oil,true);
		setVisible(SideInterface.label.orders_cost_siberite,true);
		setVisible(SideInterface.label.sib_text_order,false);
		setVisible(SideInterface.label.sent_sib_order,false);

	elseif Order_Type == 3 then
		setVisible(SideInterface.label.orders_cost_label_crates,false);
		setVisible(SideInterface.label.orders_cost_label_oil,false);
		setVisible(SideInterface.label.orders_cost_label_siberite,false);
		setVisible(SideInterface.label.orders_cost_crates,false);
		setVisible(SideInterface.label.orders_cost_oil,false);
		setVisible(SideInterface.label.orders_cost_siberite,false);
		setVisible(SideInterface.label.sib_text_order,true);
		setVisible(SideInterface.label.sent_sib_order,true);
	end;
	
end;

--Side interface when waiting for the transfer to finish
function LUA_WaitingTransfer()
	Waiting = 1;
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);	
	setVisible(SideInterface.window.orders,false);
	setVisible(SideInterface.button.cancel,false);
	setVisible(SideInterface.window.waiting,true);
end;

--Side interface when transfer has been completed
function LUA_TransferFinished()
	Waiting = 0;
	LUA_BackToMainSideInterface();
end;




--INTERFACE ELEMENT UPDATE FUNCTIONS

--Render spectator interface labels for the first time
function LUA_RenderSpecLabels(side,team,count,colour,tech)
	if team~=0 then
		SpecInterface.label.tech_level[side] 			= getLabelEX(SpecInterface.window.team[team],anchorNone,XYWH(10,35+count*25,SGUI_widelen(loc(SpecTechLevelPart1))*10+SGUI_widelen(loc(SpecTechLevelPart2))*10,10),Tahoma_12B,loc(SpecTechLevelPart1)..' '..side..' '..loc(SpecTechLevelPart2)..' : ',{font_colour=SIDE_COLOURS[colour+1]});
		SpecInterface.label.tech_level[side].number 	= getLabelEX(SpecInterface.window.team[team],anchorNone,XYWH(getWidth(SpecInterface.window.team[team])-20,35+count*25,15,10),Tahoma_12B,tech,{font_colour=WHITE()});
	elseif team==0 then
		SpecInterface.label.tech_level[side] 			= {};
		SpecInterface.label.tech_level[side].number 	= {};
	end;
end;

--Refresh spec interface labels
function LUA_UpdateSpecInterface(side,colour,tech)
	setFontColour(SpecInterface.label.tech_level[side],SIDE_COLOURS[colour+1]);
	setText(SpecInterface.label.tech_level[side].number,tech);
end;

--Refresh side interface labels
function LUA_UpdateSideInterface(side,tech)
	setText(SideInterface.label.tech_level.number,tech);	
end;

--Update resource costs of next technology upgrade
function LUA_UpdateUpgradeCost(crates,oil,siberite)
	setText(SideInterface.label.upgrade_cost_crates,crates);
	setText(SideInterface.label.upgrade_cost_oil,oil);
	setText(SideInterface.label.upgrade_cost_siberite,siberite);
end;

--Update resource costs and reinforcements number in the reinforcement window
function LUA_UpdateReinforceCost(crates,oil,siberite,soldiers);
	setText(SideInterface.label.reinforce_amount,soldiers);
	setText(SideInterface.label.reinforce_cost_crates,crates);
	setText(SideInterface.label.reinforce_cost_oil,oil);
	setText(SideInterface.label.reinforce_cost_siberite,siberite);
end;

--Update sent/required siberite in the sending window
function LUA_UpdateSiberiteSent(stockpiled,required)
	setText(SideInterface.label.sent_sib,stockpiled..' / '..required);
	setText(SideInterface.label.victory_condition_number,stockpiled..' / '..required);
	
	if Deathmatch==1 then
		setText(SideInterface.label.victory_condition_number,'Deathmatch');
	end;
end;

function LUA_UpdateSiberiteSpec(stockpiled,required,team)
	if Deathmatch==0 then
		setText(SpecInterface.label.victory_progress[team],stockpiled..' / '..required);
	elseif Deathmatch==1 then
		setText(SpecInterface.label.victory_progress[team],'Deathmatch');
	end;
end;

--Update resources in the transfer window
function LUA_UpdateTransferResources(crates, oil, siberite, wincond, setting)	
	if setting==0 then
		Crates_Order = crates;
		Oil_Order = oil;
		Sib_Order = siberite;
	elseif setting>0 then 
		Crates_Delivered = crates;
		Oil_Delivered = oil;
		Sib_Delivered = siberite;
	end;
	
	setText(SideInterface.label.orders_cost_crates,Crates_Delivered..' / '..Crates_Order);
	setText(SideInterface.label.orders_cost_oil,Oil_Delivered..' / '..Oil_Order);
	setText(SideInterface.label.orders_cost_siberite,Sib_Delivered..' / '..Sib_Order);
	setText(SideInterface.label.sent_sib_order,siberite..' / '..wincond);
end;

--Update picked zone in the transfer window
function LUA_UpdateTransferZone(zone)
	setText(SideInterface.button.orders_pick_zone,Area_Names[zone]);
end;

--Transfer zone chosen
function LUA_ChosenTransferZone()
	setEnabled(SideInterface.button.orders_pick_zone,false);
	updateGradButton(SideInterface.button.orders_pick_zone,GradButton_Grey_Light);
	setVisible(SideInterface.button.orders_left,false);
	setVisible(SideInterface.button.orders_right,false);
end;

--Disable transfer when not enough resources are at the transfer zone or the transfer zone is not yet set up
function LUA_CannotSendShipment()
	setEnabled(SideInterface.button.orders_send,false);
	updateGradButton(SideInterface.button.orders_send,GradButton_Grey_Dark);
end;

--Enable transfer when resources are ready at the transfer zone
function LUA_CanSendShipment()
	setEnabled(SideInterface.button.orders_send,true);
	updateGradButton(SideInterface.button.orders_send,GradButton_Green);
end;

--Update the time remaining on the clock in the transfer waiting window
function LUA_UpdateClock(remaining)
	m = math.floor(remaining/2100);
	s = math.floor((remaining % 2100)/35);
	
	if s<10 then
		setText(SideInterface.label.time_remaining_counter,m..':0'..s);
	elseif s>=10 then
		setText(SideInterface.label.time_remaining_counter,m..':'..s);
	end;
end;

--Update current perspective readout
--function LUA_UpdatePerspective(team)
--	if team==1 then
--		setText(PerspectiveChanger.label,loc(Team1));
--	elseif team==2 then
--		setText(PerspectiveChanger.label,loc(Team2));
--	elseif team==9 then
--		setText(PerspectiveChanger.label,loc(Spectate));
--	end
--end;




--SPECIAL

--Close all interfaces at the end of the game
function FROMOW_MAP_END()
	setVisible(SideInterface.window.main,false);
	setVisible(SideInterface.button_open,false);
	setVisible(SpecInterface.window.main,false);
	setVisible(SpecInterface.button_open,false);
--	setVisible(PerspectiveChanger.label,false);
--	setVisible(PerspectiveChanger.button_prev,false);
--	setVisible(PerspectiveChanger.button_next,false);
	SideInterface=nil;
	SpecInterface=nil;
--	PerspectiveChanger=nil;
end;

--Send resources through the transfer automatically (if the order is not about siberite)
function LUA_AutomaticSend()
	OW_CUSTOM_COMMAND(205);
end;



