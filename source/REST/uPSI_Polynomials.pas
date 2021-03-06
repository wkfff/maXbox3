unit uPSI_Polynomials;
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
  TPSImport_Polynomials = class(TPSPlugin)
  protected
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_Polynomials(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_Polynomials_Routines(S: TPSExec);

procedure Register;

implementation


uses
   VectorGeometry
  ,Polynomials
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_Polynomials]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_Polynomials(CL: TPSPascalCompiler);
begin
  CL.AddTypeS('TDoubleArray', 'array of Double');
 CL.AddDelphiFunction('Function EvalPolynom( const poly : TDoubleArray; const x : Double) : Double');
 CL.AddDelphiFunction('Function DerivatedPolynom( const poly : TDoubleArray) : TDoubleArray');
 CL.AddDelphiFunction('Function FindRoot( const poly : TDoubleArray; min, max, epsilon : Double) : Double');
 CL.AddDelphiFunction('Function MinPositiveCoef( const coefs : TDoubleArray; var aMin : Double) : Boolean');
 CL.AddDelphiFunction('Function cbrt( const x : Double) : Double');
 CL.AddDelphiFunction('Function SolveQuadric( const c : PDoubleArray) : TDoubleArray');
 CL.AddDelphiFunction('Function SolveCubic( const c : PDoubleArray) : TDoubleArray');
 CL.AddDelphiFunction('Function SolveQuartic( const c : PDoubleArray) : TDoubleArray');
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure RIRegister_Polynomials_Routines(S: TPSExec);
begin
 S.RegisterDelphiFunction(@EvalPolynom, 'EvalPolynom', cdRegister);
 S.RegisterDelphiFunction(@DerivatedPolynom, 'DerivatedPolynom', cdRegister);
 S.RegisterDelphiFunction(@FindRoot, 'FindRoot', cdRegister);
 S.RegisterDelphiFunction(@MinPositiveCoef, 'MinPositiveCoef', cdRegister);
 S.RegisterDelphiFunction(@cbrt, 'cbrt', cdRegister);
 S.RegisterDelphiFunction(@SolveQuadric, 'SolveQuadric', cdRegister);
 S.RegisterDelphiFunction(@SolveCubic, 'SolveCubic', cdRegister);
 S.RegisterDelphiFunction(@SolveQuartic, 'SolveQuartic', cdRegister);
end;

 
 
{ TPSImport_Polynomials }
(*----------------------------------------------------------------------------*)
procedure TPSImport_Polynomials.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_Polynomials(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_Polynomials.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_Polynomials(ri);
  RIRegister_Polynomials_Routines(CompExec.Exec); // comment it if no routines
end;
(*----------------------------------------------------------------------------*)
 
 
end.
