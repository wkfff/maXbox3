unit uPSI_DBXpressWeb;
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
  TPSImport_DBXpressWeb = class(TPSPlugin)
  protected
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TSQLQueryTableProducer(CL: TPSPascalCompiler);
procedure SIRegister_DBXpressWeb(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TSQLQueryTableProducer(CL: TPSRuntimeClassImporter);
procedure RIRegister_DBXpressWeb(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   HTTPApp
  ,HTTPProd
  ,DB
  ,DBWeb
  ,SqlExpr
  ,DBXpressWeb
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_DBXpressWeb]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TSQLQueryTableProducer(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TDSTableProducer', 'TSQLQueryTableProducer') do
  with CL.AddClassN(CL.FindClass('TDSTableProducer'),'TSQLQueryTableProducer') do
  begin
    RegisterProperty('Query', 'TSQLQuery', iptrw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_DBXpressWeb(CL: TPSPascalCompiler);
begin
  SIRegister_TSQLQueryTableProducer(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure TSQLQueryTableProducerQuery_W(Self: TSQLQueryTableProducer; const T: TSQLQuery);
begin Self.Query := T; end;

(*----------------------------------------------------------------------------*)
procedure TSQLQueryTableProducerQuery_R(Self: TSQLQueryTableProducer; var T: TSQLQuery);
begin T := Self.Query; end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TSQLQueryTableProducer(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TSQLQueryTableProducer) do
  begin
    RegisterPropertyHelper(@TSQLQueryTableProducerQuery_R,@TSQLQueryTableProducerQuery_W,'Query');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_DBXpressWeb(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TSQLQueryTableProducer(CL);
end;

 
 
{ TPSImport_DBXpressWeb }
(*----------------------------------------------------------------------------*)
procedure TPSImport_DBXpressWeb.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_DBXpressWeb(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_DBXpressWeb.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_DBXpressWeb(ri);
end;
(*----------------------------------------------------------------------------*)
 
 
end.
