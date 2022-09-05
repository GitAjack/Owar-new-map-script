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
	
Deathmatch = 0;	
Max_Tech = 0;
Order_Pending = 0;
Order_Type = 0;
	
--Interface element definitions

--Main Window	
SideInterface = {};
SideInterface.window = {};
SideInterface.label = {};
SideInterface.button = {};
SideInterface.window.main 				= getWindowEX(game.window,anchorNone,XYWH(0,70,250,300),false,'Expedition status',Background2,{title_colour=RGBA(32,32,32,200),title_border_colour=MenuColour_Background6,title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_18B});
SideInterface.button_open 				= getButtonEX_Gradient(game.window,anchorNone,XYWH(0,70,80,50),-1,'LUA_OpenSideInterface();',GradButton_Grey_Dark,{text='Contact Base',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SideInterface.button_close 				= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)-(80+5),getHeight(SideInterface.window.main)-(30+5),80,30),-1,'LUA_HideSideInterface();',GradButton_Red,{text='Close',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SideInterface.label.tech_level 			= getLabelEX(SideInterface.window.main,anchorNone,XYWH(15,40,200,10),Tahoma_14B,'Current technology level :',{font_colour=WHITE()});	
SideInterface.label.tech_level.number 	= getLabelEX(SideInterface.window.main,anchorNone,XYWH(220,40,10,10),Tahoma_16B,'0',{font_colour=WHITE()});
SideInterface.label.nodepot 			= getLabelEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)/2-100,getHeight(SideInterface.window.main)/2-80,200,180),Tahoma_16B,'You need to establish your base before making contact.',{colour1=RGBA(255,0,0,20),border_type=BORDER_TYPE_OUTER,border_colour=BLACKA(200),border_size=1,wordwrap=true,font_colour=RGBA(255,0,0,255),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SideInterface.label.lost 				= getLabelEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)/2-100,getHeight(SideInterface.window.main)/2-30,200,60),Tahoma_18B,'YOU LOST',{colour1=RGBA(255,0,0,20),border_type=BORDER_TYPE_OUTER,border_colour=BLACKA(200),border_size=1,font_colour=RGBA(255,0,0,255),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SideInterface.button_upgrade 			= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(15,100,220,40),-1,'LUA_OpenTechUpgrade();',GradButton_Green,{text='Get technology upgrade',font_colour=WHITE(),fontname=Tahoma_16B});
SideInterface.button_reinforce 			= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(15,150,220,40),-1,'LUA_OpenReinforce();',GradButton_Green,{text='Call reinforcements',font_colour=WHITE(),fontname=Tahoma_16B});
SideInterface.button_siberite 			= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(15,100,220,40),-1,'LUA_OpenSendSiberite()',GradButton_Green,{text='Send siberite shipment',font_colour=WHITE(),fontname=Tahoma_16B});
SideInterface.button.cancel 			= getButtonEX_Gradient(SideInterface.window.main,anchorNone,XYWH(5,getHeight(SideInterface.window.main)-(30+5),80,30),-1,'LUA_BackToMainSideInterface();',GradButton_Red,{text='Cancel',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Technology upgrades window
SideInterface.window.upgrade 					= getWindowEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)/2-100,getHeight(SideInterface.window.main)/2-80,200,180),false,'Technology upgrade',Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.upgrade_cost_label_crates 	= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(40,50,150,10),Tahoma_14B,'Crates :',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_label_oil 		= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(40,80,150,10),Tahoma_14B,'Oil :',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_label_siberite = getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(40,110,150,10),Tahoma_14B,'Siberite :',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_crates 		= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(140,50,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_oil 			= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(140,80,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.label.upgrade_cost_siberite 		= getLabelEX(SideInterface.window.upgrade,anchorNone,XYWH(140,110,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.button.upgrade_confirm 			= getButtonEX_Gradient(SideInterface.window.upgrade,anchorNone,XYWH(getWidth(SideInterface.window.upgrade)/2-40,getHeight(SideInterface.window.upgrade)-(20+15),80,30),-1,'OW_CUSTOM_COMMAND(204,0,0,0,0,1);',GradButton_Green,{text='Confirm',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Reinforcement calling window
SideInterface.window.reinforce 						= getWindowEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)/2-100,getHeight(SideInterface.window.main)/2-80,200,180),false,'Reinforcements',Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.reinforce_amount 				= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2-11,40,20,10),Tahoma_16B,'0',{font_colour=WHITE(),text_valign=ALIGN_CENTER,text_halign=ALIGN_MIDDLE});
SideInterface.label.reinforce_cost_label_crates 	= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(40,70,10,10),Tahoma_14B,'Crates :',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_label_oil 		= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(40,90,10,10),Tahoma_14B,'Oil :',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_label_siberite 	= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(40,110,10,10),Tahoma_14B,'Siberite :',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_crates 			= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(140,70,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_oil 				= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(140,90,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.label.reinforce_cost_siberite 		= getLabelEX(SideInterface.window.reinforce,anchorNone,XYWH(140,110,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.button.reinforce_increase 			= getButtonEX_Gradient(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2+15,35,25,25),-1,'OW_CUSTOM_COMMAND(2020);',GradButton_Green,{text='+',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_20B});
SideInterface.button.reinforce_decrease 			= getButtonEX_Gradient(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2-45,35,25,25),-1,'OW_CUSTOM_COMMAND(2021);',GradButton_Green,{text='-',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_20B});
SideInterface.button.reinforce_confirm 				= getButtonEX_Gradient(SideInterface.window.reinforce,anchorNone,XYWH(getWidth(SideInterface.window.reinforce)/2-40,getHeight(SideInterface.window.reinforce)-(20+20),80,30),-1,'OW_CUSTOM_COMMAND(204,0,0,0,0,2);',GradButton_Green,{text='Confirm',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Siberite sending window
SideInterface.window.siberite 			= getWindowEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)/2-100,getHeight(SideInterface.window.main)/2-80,200,180),false,'Transfer siberite',Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.sib_text			= getLabelEX(SideInterface.window.siberite,anchorNone,XYWH(15,70,150,10),Tahoma_16B,'Crystals sent :',{font_colour=WHITE()});
SideInterface.label.sent_sib			= getLabelEX(SideInterface.window.siberite,anchorNone,XYWH(140,70,10,10),Tahoma_16B,'0 / 0',{font_colour=WHITE()});
SideInterface.button.siberite_confirm 	= getButtonEX_Gradient(SideInterface.window.siberite,anchorNone,XYWH(getWidth(SideInterface.window.siberite)/2-40,getHeight(SideInterface.window.siberite)-(20+50),80,30),-1,'OW_CUSTOM_COMMAND(204,0,0,0,0,3);',GradButton_Green,{text='Confirm',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Confirmed orders and pending resources window (upgrade/reinforcements/siberite)
SideInterface.window.orders						= getWindowEX(SideInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)/2-100,getHeight(SideInterface.window.main)/2-80,200,180),false,'Send resources',Background3,{title_colour=RGBA(50,50,50,200),title_border_colour=RGBA(0,0,0,255),title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_16B});
SideInterface.label.orders_cost_label_crates 	= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(40,50,10,10),Tahoma_14B,'Crates :',{font_colour=WHITE()});
SideInterface.label.orders_cost_label_oil 		= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(40,70,10,10),Tahoma_14B,'Oil :',{font_colour=WHITE()});
SideInterface.label.orders_cost_label_siberite 	= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(40,90,10,10),Tahoma_14B,'Siberite :',{font_colour=WHITE()});
SideInterface.label.orders_cost_crates 			= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(140,50,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.label.orders_cost_oil 			= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(140,70,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.label.orders_cost_siberite 		= getLabelEX(SideInterface.window.orders,anchorNone,XYWH(140,90,10,10),Tahoma_14B,'0',{font_colour=WHITE()});
SideInterface.button.orders_pick_zone 			= getButtonEX_Gradient(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.siberite)/2-60,110,120,30),-1,'',GradButton_Green,{text='Choose transfer zone',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SideInterface.button.orders_send		 		= getButtonEX_Gradient(SideInterface.window.orders,anchorNone,XYWH(getWidth(SideInterface.window.siberite)/2-60,160,120,30),-1,'',GradButton_Green,{text='Send transport',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

--Spectator window
SpecInterface 					= {};
SpecInterface.window			= {};
SpecInterface.label				= {};
SpecInterface.label.tech_level 	= {};
SpecInterface.window.main 		= getWindowEX(game.window,anchorNone,XYWH(0,70,250,300),false,'Player statistics',Background2,{title_colour=RGBA(32,32,32,200),title_border_colour=MenuColour_Background6,title_fontcolour=RGBA(255,255,255,255),title_fontname=Tahoma_18B});
SpecInterface.button_open 		= getButtonEX_Gradient(game.window,anchorNone,XYWH(0,70,80,50),-1,'LUA_OpenSpecInterface();',GradButton_Grey_Dark,{text='Player Stats',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});
SpecInterface.button_close 		= getButtonEX_Gradient(SpecInterface.window.main,anchorNone,XYWH(getWidth(SideInterface.window.main)-(80+5),getHeight(SideInterface.window.main)-(30+5),80,30),-1,'LUA_HideSpecInterface();',GradButton_Red,{text='Close',font_colour=WHITE(),wordwrap=true,fontname=Tahoma_18B});

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
	
	setVisible(SpecInterface.button_open,false);
	setVisible(SpecInterface.window.main,false);
end;
	
 --Initiate spec interface
function StartSpecInterface()		
	setVisible(SpecInterface.button_open,true);
	setVisible(SpecInterface.window.main,false);

	setVisible(SideInterface.button_open,false);
	setVisible(SideInterface.window.main,false);
end;

--Hide interface
function LUA_HideSideInterface()
	setVisible(SideInterface.button_open,true);
	setVisible(SideInterface.window.main,false); 
end;

--Hide spectator interface
function LUA_HideSpecInterface()
	setVisible(SpecInterface.button_open,true);
	setVisible(SpecInterface.window.main,false);
end;

--Open interface
function LUA_OpenSideInterface()
	setVisible(SideInterface.window.main,true);
	setVisible(SideInterface.button_open,false);
end;

--Open spectator interface
function LUA_OpenSpecInterface()
	setVisible(SpecInterface.window.main,true);
	setVisible(SpecInterface.button_open,false);
end;

--Side interface when there is no depot built by the side
function LUA_NoDepot()
	setVisible(SideInterface.label.tech_level,true);
	setVisible(SideInterface.label.tech_level.number,true);
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
end;

--Side interface when depot is built
function LUA_IsDepot()
	setVisible(SideInterface.label.tech_level,true);
	setVisible(SideInterface.label.tech_level.number,true);
	setVisible(SideInterface.label.nodepot,false);
	setVisible(SideInterface.label.lost,false);
	setVisible(SideInterface.button_reinforce,true);
	setVisible(SideInterface.button.cancel,false);
	
	if Max_Tech==0 then
		setVisible(SideInterface.button_upgrade,true);
	elseif Max_Tech==1 and Deathmatch==0 then
		setVisible(SideInterface.button_siberite,true);
	end;
	
	if Order_Pending==1 then
		LUA_OrderUpgradeReinforceIssued();
	end;
end;

--Side interface when side lost
function LUA_Lost()
	setVisible(SideInterface.label.tech_level,true);
	setVisible(SideInterface.label.tech_level.number,true);
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
end;

--Side interface when all tech levels were bought
function LUA_SideTechMax()
	setVisible(SideInterface.button_upgrade,false);
	if Deathmatch==0 then
		setVisible(SideInterface.button_siberite,true);
	end;
	
	Max_Tech = 1;
end;

--Side interface when upgrade chosen
function LUA_OpenTechUpgrade()
	setVisible(SideInterface.label.tech_level,true);
	setVisible(SideInterface.label.tech_level.number,true);
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,true);

	setVisible(SideInterface.window.upgrade,true);
	OW_CUSTOM_COMMAND(201);
end;

--Side interface when reinforcement chosen
function LUA_OpenReinforce()
	setVisible(SideInterface.label.tech_level,true);
	setVisible(SideInterface.label.tech_level.number,true);
	setVisible(SideInterface.button_upgrade,false);
	setVisible(SideInterface.button_reinforce,false);
	setVisible(SideInterface.button_siberite,false);
	setVisible(SideInterface.button.cancel,true);

	setVisible(SideInterface.window.reinforce,true);
	OW_CUSTOM_COMMAND(202);
end;

--Side interface when sending siberite
function LUA_OpenSendSiberite()
	setVisible(SideInterface.label.tech_level,true);
	setVisible(SideInterface.label.tech_level.number,true);
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
	setVisible(SideInterface.button.cancel,false);
	
	setVisible(SideInterface.label.tech_level,true);
	setVisible(SideInterface.label.tech_level.number,true);
	setVisible(SideInterface.button_reinforce,true);
	
	if Max_Tech==0 then
		setVisible(SideInterface.button_upgrade,true);
	elseif Max_Tech==1 and Deathmatch==0 then
		setVisible(SideInterface.button_siberite,true);
	end;
	
end;
	
--Side interface when order for reinforcements/upgrade has been issued
function LUA_OrderUpgradeReinforceIssued()
	setVisible(SideInterface.button.cancel,false);
	setVisible(SideInterface.window.upgrade,false);
	setVisible(SideInterface.window.reinforce,false);
	
	setVisible(SideInterface.window.orders,true);
end;



--LABELS

--Render spectator interface labels for the first time
function LUA_RenderSpecLabels(side,colour,tech)	
	SpecInterface.label.tech_level[side] = getLabelEX(SpecInterface.window.main,anchorNone,XYWH(15,15+side*25,200,10),Tahoma_14B,'Player '..side..' technology level :',{font_colour=SIDE_COLOURS[colour+1]});
    SpecInterface.label.tech_level[side].number = getLabelEX(SpecInterface.window.main,anchorNone,XYWH(220,15+side*25,10,10),Tahoma_16B,tech,{font_colour=WHITE()});
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
function LUA_UpdateUpgradeCost(crates,oil,siberite);
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
function LUA_UpdateSiberiteSent(stockpiled,required);
	setText(SideInterface.label.sent_sib,stockpiled..' / '..required);
end;

--SPECIAL

--Close all interfaces at the end of the game
function FROMOW_MAP_END()
	setVisible(SideInterface.window.main,false);
	setVisible(SideInterface.button_open,false);
	setVisible(SpecInterface.window.main,false);
	setVisible(SpecInterface.button_open,false);
	SideInterface=nil;
	SpecInterface=nil;
end;



