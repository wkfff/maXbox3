unit uPSI_Tabs;
{
This file has been generated by UnitParser v0.7, written by M. Knight
and updated by NP. v/d Spek and George Birbilis. 
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ROPS are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok's conv utility

}
interface
 
uses
   SysUtils
  ,Classes
  ,uPSComponent
  ,uPSRuntime
  ,uPSCompiler
  ;
 
type 
(*----------------------------------------------------------------------------*)
  TPSImport_Tabs = class(TPSPlugin)
  protected
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TTabSet(CL: TPSPascalCompiler);
procedure SIRegister_TTabList(CL: TPSPascalCompiler);
procedure SIRegister_TScroller(CL: TPSPascalCompiler);
procedure SIRegister_Tabs(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TTabSet(CL: TPSRuntimeClassImporter);
procedure RIRegister_TTabList(CL: TPSRuntimeClassImporter);
procedure RIRegister_TScroller(CL: TPSRuntimeClassImporter);
procedure RIRegister_Tabs(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   Windows
  ,Graphics
  ,Forms
  ,Controls
  ,Messages
  ,ImgList
  ,ComCtrls
  ,ExtCtrls
  ,Tabs
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_Tabs]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TTabSet(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomControl', 'TTabSet') do
  with CL.AddClassN(CL.FindClass('TCustomControl'),'TTabSet') do
  begin
    RegisterMethod('Constructor Create( AOwner : TComponent)');
    RegisterMethod('Function ItemAtPos( Pos : TPoint; IgnoreTabHeight : Boolean) : Integer');
    RegisterMethod('Function ItemRect( Index : Integer) : TRect');
    RegisterMethod('Function ItemWidth( Index : Integer) : Integer');
    RegisterMethod('Function MinClientRect : TRect;');
    RegisterMethod('Function MinClientRect1( IncludeScroller : Boolean) : TRect;');
    RegisterMethod('Function MinClientRect( TabCount : Integer; IncludeScroller : Boolean) : TRect;');
    RegisterMethod('Procedure SelectNext( Direction : Boolean)');
    RegisterProperty('FirstIndex', 'Integer', iptrw);
    RegisterProperty('AutoScroll', 'Boolean', iptrw);
    RegisterProperty('BackgroundColor', 'TColor', iptrw);
    RegisterProperty('DitherBackground', 'Boolean', iptrw);
    RegisterProperty('EndMargin', 'Integer', iptrw);
    RegisterProperty('Images', 'TCustomImageList', iptrw);
    RegisterProperty('ShrinkToFit', 'Boolean', iptrw);
    RegisterProperty('StartMargin', 'Integer', iptrw);
    RegisterProperty('SelectedColor', 'TColor', iptrw);
    RegisterProperty('SoftTop', 'Boolean', iptrw);
    RegisterProperty('Style', 'TTabStyle', iptrw);
    RegisterProperty('TabHeight', 'Integer', iptrw);
    RegisterProperty('Tabs', 'TStrings', iptrw);
    RegisterProperty('TabIndex', 'Integer', iptrw);
    RegisterProperty('TabPosition', 'TTabPosition', iptrw);
    RegisterProperty('UnselectedColor', 'TColor', iptrw);
    RegisterProperty('VisibleTabs', 'Integer', iptr);
    RegisterProperty('OnChange', 'TTabChangeEvent', iptrw);
    RegisterProperty('OnDrawTab', 'TDrawTabEvent', iptrw);
    RegisterProperty('OnGetImageIndex', 'TTabGetImageEvent', iptrw);
    RegisterProperty('OnMeasureTab', 'TMeasureTabEvent', iptrw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TTabList(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TStringList', 'TTabList') do
  with CL.AddClassN(CL.FindClass('TStringList'),'TTabList') do
  begin
    RegisterMethod('Constructor Create( const ATabSet : TTabSet)');
    RegisterMethod('Procedure Insert( Index : Integer; const S : string)');
    RegisterMethod('Procedure Delete( Index : Integer)');
    RegisterMethod('Function Add( const S : string) : Integer');
    RegisterMethod('Procedure Put( Index : Integer; const S : string)');
    RegisterMethod('Procedure Clear');
    RegisterMethod('Procedure AddStrings( Strings : TStrings)');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TScroller(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomControl', 'TScroller') do
  with CL.AddClassN(CL.FindClass('TCustomControl'),'TScroller') do
  begin
    RegisterMethod('Constructor Create( AOwner : TComponent)');
    RegisterMethod('Procedure Paint');
    RegisterProperty('OnClick', 'TNotifyEvent', iptrw);
    RegisterProperty('Min', 'Longint', iptrw);
    RegisterProperty('Max', 'Longint', iptrw);
    RegisterProperty('Position', 'Longint', iptrw);
    RegisterProperty('ScrollOrientation', 'TScrollOrientation', iptrw);
    RegisterProperty('Change', 'Integer', iptrw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_Tabs(CL: TPSPascalCompiler);
begin
  CL.AddTypeS('TScrollBtn', '( sbLeft, sbRight )');
  CL.AddTypeS('TScrollOrientation', '( soLeftRight, soUpDown )');
  SIRegister_TScroller(CL);
  CL.AddClassN(CL.FindClass('TOBJECT'),'TTabSet');
  SIRegister_TTabList(CL);
  CL.AddTypeS('TEdgePart', '( epSelectedLeft, epUnselectedLeft, epSelectedRight'
   +', epUnselectedRight )');
  CL.AddTypeS('TEdgeType', '( etNone, etFirstIsSel, etFirstNotSel, etLastIsSel,'
   +' etLastNotSel, etNotSelToSel, etSelToNotSel, etNotSelToNotSel )');
  CL.AddTypeS('TTabSetTabStyle', '( tsStandard, tsOwnerDraw, tsSoftTabs, tsMode'
   +'rnTabs, tsModernPopout )');
  CL.AddTypeS('TTabStyle', 'TTabSetTabStyle');
  CL.AddTypeS('TMeasureTabEvent', 'Procedure ( Sender : TObject; Index : Intege'
   +'r; var TabWidth : Integer)');
  CL.AddTypeS('TTabSetDrawTabEvent', 'Procedure ( Sender : TObject; TabCanvas :'
   +' TCanvas; R : TRect; Index : Integer; Selected : Boolean)');
  CL.AddTypeS('TDrawTabEvent', 'TTabSetDrawTabEvent');
  CL.AddTypeS('TTabChangeEvent', 'Procedure ( Sender : TObject; NewTab : Intege'
   +'r; var AllowChange : Boolean)');
  SIRegister_TTabSet(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure TTabSetOnMeasureTab_W(Self: TTabSet; const T: TMeasureTabEvent);
begin Self.OnMeasureTab := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetOnMeasureTab_R(Self: TTabSet; var T: TMeasureTabEvent);
begin T := Self.OnMeasureTab; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetOnGetImageIndex_W(Self: TTabSet; const T: TTabGetImageEvent);
begin Self.OnGetImageIndex := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetOnGetImageIndex_R(Self: TTabSet; var T: TTabGetImageEvent);
begin T := Self.OnGetImageIndex; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetOnDrawTab_W(Self: TTabSet; const T: TDrawTabEvent);
begin Self.OnDrawTab := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetOnDrawTab_R(Self: TTabSet; var T: TDrawTabEvent);
begin T := Self.OnDrawTab; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetOnChange_W(Self: TTabSet; const T: TTabChangeEvent);
begin Self.OnChange := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetOnChange_R(Self: TTabSet; var T: TTabChangeEvent);
begin T := Self.OnChange; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetVisibleTabs_R(Self: TTabSet; var T: Integer);
begin T := Self.VisibleTabs; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetUnselectedColor_W(Self: TTabSet; const T: TColor);
begin Self.UnselectedColor := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetUnselectedColor_R(Self: TTabSet; var T: TColor);
begin T := Self.UnselectedColor; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabPosition_W(Self: TTabSet; const T: TTabPosition);
begin Self.TabPosition := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabPosition_R(Self: TTabSet; var T: TTabPosition);
begin T := Self.TabPosition; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabIndex_W(Self: TTabSet; const T: Integer);
begin Self.TabIndex := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabIndex_R(Self: TTabSet; var T: Integer);
begin T := Self.TabIndex; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabs_W(Self: TTabSet; const T: TStrings);
begin Self.Tabs := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabs_R(Self: TTabSet; var T: TStrings);
begin T := Self.Tabs; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabHeight_W(Self: TTabSet; const T: Integer);
begin Self.TabHeight := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetTabHeight_R(Self: TTabSet; var T: Integer);
begin T := Self.TabHeight; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetStyle_W(Self: TTabSet; const T: TTabStyle);
begin Self.Style := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetStyle_R(Self: TTabSet; var T: TTabStyle);
begin T := Self.Style; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetSoftTop_W(Self: TTabSet; const T: Boolean);
begin Self.SoftTop := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetSoftTop_R(Self: TTabSet; var T: Boolean);
begin T := Self.SoftTop; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetSelectedColor_W(Self: TTabSet; const T: TColor);
begin Self.SelectedColor := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetSelectedColor_R(Self: TTabSet; var T: TColor);
begin T := Self.SelectedColor; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetStartMargin_W(Self: TTabSet; const T: Integer);
begin Self.StartMargin := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetStartMargin_R(Self: TTabSet; var T: Integer);
begin T := Self.StartMargin; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetShrinkToFit_W(Self: TTabSet; const T: Boolean);
begin Self.ShrinkToFit := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetShrinkToFit_R(Self: TTabSet; var T: Boolean);
begin T := Self.ShrinkToFit; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetImages_W(Self: TTabSet; const T: TCustomImageList);
begin Self.Images := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetImages_R(Self: TTabSet; var T: TCustomImageList);
begin T := Self.Images; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetEndMargin_W(Self: TTabSet; const T: Integer);
begin Self.EndMargin := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetEndMargin_R(Self: TTabSet; var T: Integer);
begin T := Self.EndMargin; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetDitherBackground_W(Self: TTabSet; const T: Boolean);
begin Self.DitherBackground := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetDitherBackground_R(Self: TTabSet; var T: Boolean);
begin T := Self.DitherBackground; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetBackgroundColor_W(Self: TTabSet; const T: TColor);
begin Self.BackgroundColor := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetBackgroundColor_R(Self: TTabSet; var T: TColor);
begin T := Self.BackgroundColor; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetAutoScroll_W(Self: TTabSet; const T: Boolean);
begin Self.AutoScroll := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetAutoScroll_R(Self: TTabSet; var T: Boolean);
begin T := Self.AutoScroll; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetFirstIndex_W(Self: TTabSet; const T: Integer);
begin Self.FirstIndex := T; end;

(*----------------------------------------------------------------------------*)
procedure TTabSetFirstIndex_R(Self: TTabSet; var T: Integer);
begin T := Self.FirstIndex; end;

(*----------------------------------------------------------------------------*)
Function TTabSetMinClientRect_P(Self: TTabSet;  TabCount : Integer; IncludeScroller : Boolean) : TRect;
Begin Result := Self.MinClientRect(TabCount, IncludeScroller); END;

(*----------------------------------------------------------------------------*)
Function TTabSetMinClientRect1_P(Self: TTabSet;  IncludeScroller : Boolean) : TRect;
Begin Result := Self.MinClientRect(IncludeScroller); END;

(*----------------------------------------------------------------------------*)
Function TTabSetMinClientRect_P(Self: TTabSet) : TRect;
Begin Result := Self.MinClientRect; END;

(*----------------------------------------------------------------------------*)
procedure TScrollerChange_W(Self: TScroller; const T: Integer);
begin Self.Change := T; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerChange_R(Self: TScroller; var T: Integer);
begin T := Self.Change; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerScrollOrientation_W(Self: TScroller; const T: TScrollOrientation);
begin Self.ScrollOrientation := T; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerScrollOrientation_R(Self: TScroller; var T: TScrollOrientation);
begin T := Self.ScrollOrientation; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerPosition_W(Self: TScroller; const T: Longint);
begin Self.Position := T; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerPosition_R(Self: TScroller; var T: Longint);
begin T := Self.Position; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerMax_W(Self: TScroller; const T: Longint);
begin Self.Max := T; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerMax_R(Self: TScroller; var T: Longint);
begin T := Self.Max; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerMin_W(Self: TScroller; const T: Longint);
begin Self.Min := T; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerMin_R(Self: TScroller; var T: Longint);
begin T := Self.Min; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerOnClick_W(Self: TScroller; const T: TNotifyEvent);
begin Self.OnClick := T; end;

(*----------------------------------------------------------------------------*)
procedure TScrollerOnClick_R(Self: TScroller; var T: TNotifyEvent);
begin T := Self.OnClick; end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TTabSet(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TTabSet) do
  begin
    RegisterConstructor(@TTabSet.Create, 'Create');
    RegisterMethod(@TTabSet.ItemAtPos, 'ItemAtPos');
    RegisterMethod(@TTabSet.ItemRect, 'ItemRect');
    RegisterMethod(@TTabSet.ItemWidth, 'ItemWidth');
    RegisterMethod(@TTabSetMinClientRect_P, 'MinClientRect');
    RegisterMethod(@TTabSetMinClientRect1_P, 'MinClientRect1');
    RegisterMethod(@TTabSetMinClientRect_P, 'MinClientRect');
    RegisterMethod(@TTabSet.SelectNext, 'SelectNext');
    RegisterPropertyHelper(@TTabSetFirstIndex_R,@TTabSetFirstIndex_W,'FirstIndex');
    RegisterPropertyHelper(@TTabSetAutoScroll_R,@TTabSetAutoScroll_W,'AutoScroll');
    RegisterPropertyHelper(@TTabSetBackgroundColor_R,@TTabSetBackgroundColor_W,'BackgroundColor');
    RegisterPropertyHelper(@TTabSetDitherBackground_R,@TTabSetDitherBackground_W,'DitherBackground');
    RegisterPropertyHelper(@TTabSetEndMargin_R,@TTabSetEndMargin_W,'EndMargin');
    RegisterPropertyHelper(@TTabSetImages_R,@TTabSetImages_W,'Images');
    RegisterPropertyHelper(@TTabSetShrinkToFit_R,@TTabSetShrinkToFit_W,'ShrinkToFit');
    RegisterPropertyHelper(@TTabSetStartMargin_R,@TTabSetStartMargin_W,'StartMargin');
    RegisterPropertyHelper(@TTabSetSelectedColor_R,@TTabSetSelectedColor_W,'SelectedColor');
    RegisterPropertyHelper(@TTabSetSoftTop_R,@TTabSetSoftTop_W,'SoftTop');
    RegisterPropertyHelper(@TTabSetStyle_R,@TTabSetStyle_W,'Style');
    RegisterPropertyHelper(@TTabSetTabHeight_R,@TTabSetTabHeight_W,'TabHeight');
    RegisterPropertyHelper(@TTabSetTabs_R,@TTabSetTabs_W,'Tabs');
    RegisterPropertyHelper(@TTabSetTabIndex_R,@TTabSetTabIndex_W,'TabIndex');
    RegisterPropertyHelper(@TTabSetTabPosition_R,@TTabSetTabPosition_W,'TabPosition');
    RegisterPropertyHelper(@TTabSetUnselectedColor_R,@TTabSetUnselectedColor_W,'UnselectedColor');
    RegisterPropertyHelper(@TTabSetVisibleTabs_R,nil,'VisibleTabs');
    RegisterPropertyHelper(@TTabSetOnChange_R,@TTabSetOnChange_W,'OnChange');
    RegisterPropertyHelper(@TTabSetOnDrawTab_R,@TTabSetOnDrawTab_W,'OnDrawTab');
    RegisterPropertyHelper(@TTabSetOnGetImageIndex_R,@TTabSetOnGetImageIndex_W,'OnGetImageIndex');
    RegisterPropertyHelper(@TTabSetOnMeasureTab_R,@TTabSetOnMeasureTab_W,'OnMeasureTab');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TTabList(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TTabList) do
  begin
    RegisterConstructor(@TTabList.Create, 'Create');
    RegisterMethod(@TTabList.Insert, 'Insert');
    RegisterMethod(@TTabList.Delete, 'Delete');
    RegisterMethod(@TTabList.Add, 'Add');
    RegisterMethod(@TTabList.Put, 'Put');
    RegisterMethod(@TTabList.Clear, 'Clear');
    RegisterMethod(@TTabList.AddStrings, 'AddStrings');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TScroller(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TScroller) do
  begin
    RegisterConstructor(@TScroller.Create, 'Create');
    RegisterMethod(@TScroller.Paint, 'Paint');
    RegisterPropertyHelper(@TScrollerOnClick_R,@TScrollerOnClick_W,'OnClick');
    RegisterPropertyHelper(@TScrollerMin_R,@TScrollerMin_W,'Min');
    RegisterPropertyHelper(@TScrollerMax_R,@TScrollerMax_W,'Max');
    RegisterPropertyHelper(@TScrollerPosition_R,@TScrollerPosition_W,'Position');
    RegisterPropertyHelper(@TScrollerScrollOrientation_R,@TScrollerScrollOrientation_W,'ScrollOrientation');
    RegisterPropertyHelper(@TScrollerChange_R,@TScrollerChange_W,'Change');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_Tabs(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TScroller(CL);
  with CL.Add(TTabSet) do
  RIRegister_TTabList(CL);
  RIRegister_TTabSet(CL);
end;

 
 
{ TPSImport_Tabs }
(*----------------------------------------------------------------------------*)
procedure TPSImport_Tabs.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_Tabs(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_Tabs.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_Tabs(ri);
end;
(*----------------------------------------------------------------------------*)
 
 
end.
