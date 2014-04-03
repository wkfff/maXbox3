unit uPSI_StdActnMenus;
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
  TPSImport_StdActnMenus = class(TPSPlugin)
  protected
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TStandardDropDownButton(CL: TPSPascalCompiler);
procedure SIRegister_TStandardButtonControl(CL: TPSPascalCompiler);
procedure SIRegister_TStandardCustomizePopup(CL: TPSPascalCompiler);
procedure SIRegister_TStandardAddRemoveItem(CL: TPSPascalCompiler);
procedure SIRegister_TStandardMenuPopup(CL: TPSPascalCompiler);
procedure SIRegister_TStandardMenuExpandBtn(CL: TPSPascalCompiler);
procedure SIRegister_TStandardToolScrollBtn(CL: TPSPascalCompiler);
procedure SIRegister_TStandardMenuButton(CL: TPSPascalCompiler);
procedure SIRegister_TStandardMenuItem(CL: TPSPascalCompiler);
procedure SIRegister_StdActnMenus(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_StdActnMenus_Routines(S: TPSExec);
procedure RIRegister_TStandardDropDownButton(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardButtonControl(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardCustomizePopup(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardAddRemoveItem(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardMenuPopup(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardMenuExpandBtn(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardToolScrollBtn(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardMenuButton(CL: TPSRuntimeClassImporter);
procedure RIRegister_TStandardMenuItem(CL: TPSRuntimeClassImporter);
procedure RIRegister_StdActnMenus(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   Windows
  ,Messages
  ,Controls
  ,Graphics
  ,Buttons
  ,ActnMenus
  ,ToolWin
  ,ActnMan
  ,ActnCtrls
  ,StdActnMenus
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_StdActnMenus]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardDropDownButton(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomDropDownButton', 'TStandardDropDownButton') do
  with CL.AddClassN(CL.FindClass('TCustomDropDownButton'),'TStandardDropDownButton') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardButtonControl(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomButtonControl', 'TStandardButtonControl') do
  with CL.AddClassN(CL.FindClass('TCustomButtonControl'),'TStandardButtonControl') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardCustomizePopup(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomizeActionToolBar', 'TStandardCustomizePopup') do
  with CL.AddClassN(CL.FindClass('TCustomizeActionToolBar'),'TStandardCustomizePopup') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardAddRemoveItem(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomAddRemoveItem', 'TStandardAddRemoveItem') do
  with CL.AddClassN(CL.FindClass('TCustomAddRemoveItem'),'TStandardAddRemoveItem') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardMenuPopup(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomActionPopupMenu', 'TStandardMenuPopup') do
  with CL.AddClassN(CL.FindClass('TCustomActionPopupMenu'),'TStandardMenuPopup') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardMenuExpandBtn(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomMenuExpandBtn', 'TStandardMenuExpandBtn') do
  with CL.AddClassN(CL.FindClass('TCustomMenuExpandBtn'),'TStandardMenuExpandBtn') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardToolScrollBtn(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomToolScrollBtn', 'TStandardToolScrollBtn') do
  with CL.AddClassN(CL.FindClass('TCustomToolScrollBtn'),'TStandardToolScrollBtn') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardMenuButton(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomMenuButton', 'TStandardMenuButton') do
  with CL.AddClassN(CL.FindClass('TCustomMenuButton'),'TStandardMenuButton') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TStandardMenuItem(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomMenuItem', 'TStandardMenuItem') do
  with CL.AddClassN(CL.FindClass('TCustomMenuItem'),'TStandardMenuItem') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_StdActnMenus(CL: TPSPascalCompiler);
begin
  SIRegister_TStandardMenuItem(CL);
  SIRegister_TStandardMenuButton(CL);
  SIRegister_TStandardToolScrollBtn(CL);
  SIRegister_TStandardMenuExpandBtn(CL);
  SIRegister_TStandardMenuPopup(CL);
  SIRegister_TStandardAddRemoveItem(CL);
  SIRegister_TStandardCustomizePopup(CL);
  SIRegister_TStandardButtonControl(CL);
  SIRegister_TStandardDropDownButton(CL);
 CL.AddDelphiFunction('Procedure RegisterStandardMenus');
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure RIRegister_StdActnMenus_Routines(S: TPSExec);
begin
 S.RegisterDelphiFunction(@RegisterStandardMenus, 'RegisterStandardMenus', cdRegister);
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardDropDownButton(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardDropDownButton) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardButtonControl(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardButtonControl) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardCustomizePopup(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardCustomizePopup) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardAddRemoveItem(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardAddRemoveItem) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardMenuPopup(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardMenuPopup) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardMenuExpandBtn(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardMenuExpandBtn) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardToolScrollBtn(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardToolScrollBtn) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardMenuButton(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardMenuButton) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TStandardMenuItem(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TStandardMenuItem) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_StdActnMenus(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TStandardMenuItem(CL);
  RIRegister_TStandardMenuButton(CL);
  RIRegister_TStandardToolScrollBtn(CL);
  RIRegister_TStandardMenuExpandBtn(CL);
  RIRegister_TStandardMenuPopup(CL);
  RIRegister_TStandardAddRemoveItem(CL);
  RIRegister_TStandardCustomizePopup(CL);
  RIRegister_TStandardButtonControl(CL);
  RIRegister_TStandardDropDownButton(CL);
end;

 
 
{ TPSImport_StdActnMenus }
(*----------------------------------------------------------------------------*)
procedure TPSImport_StdActnMenus.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_StdActnMenus(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_StdActnMenus.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_StdActnMenus(ri);
  RIRegister_StdActnMenus_Routines(CompExec.Exec); // comment it if no routines
end;
(*----------------------------------------------------------------------------*)
 
 
end.