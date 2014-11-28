unit uPSI_NeuralNetwork;
{
   of openCL
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
  TPSImport_NeuralNetwork = class(TPSPlugin)
  protected
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TNeuralNet(CL: TPSPascalCompiler);
procedure SIRegister_TNeuronLayer(CL: TPSPascalCompiler);
procedure SIRegister_TNeuron(CL: TPSPascalCompiler);
procedure SIRegister_NeuralNetwork(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TNeuralNet(CL: TPSRuntimeClassImporter);
procedure RIRegister_TNeuronLayer(CL: TPSRuntimeClassImporter);
procedure RIRegister_TNeuron(CL: TPSRuntimeClassImporter);
procedure RIRegister_NeuralNetwork(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   NeuralNetwork
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_NeuralNetwork]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TNeuralNet(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TOBJECT', 'TNeuralNet') do
  with CL.AddClassN(CL.FindClass('TOBJECT'),'TNeuralNet') do begin
    RegisterMethod('Procedure AddLayer( ANumNeurons : Integer)');
    RegisterMethod('Procedure ConnectAll( )');
    RegisterMethod('Procedure Train( ATrainData : array of Real; ATrainResult : array of Real)');
    RegisterMethod('Procedure Compute( )');
    RegisterMethod('Constructor Create( )');
      RegisterMethod('Procedure Free');
      RegisterProperty('CountLayers', 'Integer', iptr);
    RegisterProperty('CountInputs', 'Integer', iptr);
    RegisterProperty('CountOutputs', 'Integer', iptr);
    RegisterProperty('Inputs', 'Real Integer', iptrw);
    RegisterProperty('Outputs', 'Real Integer', iptr);
    RegisterProperty('Results', 'Real Integer', iptr);
    RegisterProperty('Epoch', 'Integer', iptr);
    RegisterProperty('Error', 'Real', iptr);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TNeuronLayer(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TOBJECT', 'TNeuronLayer') do
  with CL.AddClassN(CL.FindClass('TOBJECT'),'TNeuronLayer') do
  begin
    RegisterMethod('Constructor Create( ACountNeurons : Integer)');
      RegisterMethod('Procedure Free');
      RegisterProperty('CountNeurons', 'Integer', iptr);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TNeuron(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TOBJECT', 'TNeuron') do
  with CL.AddClassN(CL.FindClass('TOBJECT'),'TNeuron') do
  begin
    RegisterMethod('Constructor Create( )');
    RegisterProperty('CountSynapses', 'Integer', iptr);
    RegisterProperty('Input', 'Real', iptrw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_NeuralNetwork(CL: TPSPascalCompiler);
begin
  CL.AddClassN(CL.FindClass('TOBJECT'),'TNeuron');
  CL.AddTypeS('TSynapse', 'record W : Real; Connection : TNeuron; end');
  CL.AddTypeS('TAcson', 'record Alfa : Real; Beta : Real; Gama : Real; end');
  SIRegister_TNeuron(CL);
  SIRegister_TNeuronLayer(CL);
  SIRegister_TNeuralNet(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure TNeuralNetError_R(Self: TNeuralNet; var T: Real);
begin T := Self.Error; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetEpoch_R(Self: TNeuralNet; var T: Integer);
begin T := Self.Epoch; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetResults_R(Self: TNeuralNet; var T: Real; const t1: Integer);
begin T := Self.Results[t1]; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetOutputs_R(Self: TNeuralNet; var T: Real; const t1: Integer);
begin T := Self.Outputs[t1]; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetInputs_W(Self: TNeuralNet; const T: Real; const t1: Integer);
begin Self.Inputs[t1] := T; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetInputs_R(Self: TNeuralNet; var T: Real; const t1: Integer);
begin T := Self.Inputs[t1]; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetCountOutputs_R(Self: TNeuralNet; var T: Integer);
begin T := Self.CountOutputs; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetCountInputs_R(Self: TNeuralNet; var T: Integer);
begin T := Self.CountInputs; end;

(*----------------------------------------------------------------------------*)
procedure TNeuralNetCountLayers_R(Self: TNeuralNet; var T: Integer);
begin T := Self.CountLayers; end;

(*----------------------------------------------------------------------------*)
procedure TNeuronLayerCountNeurons_R(Self: TNeuronLayer; var T: Integer);
begin T := Self.CountNeurons; end;

(*----------------------------------------------------------------------------*)
procedure TNeuronInput_W(Self: TNeuron; const T: Real);
begin Self.Input := T; end;

(*----------------------------------------------------------------------------*)
procedure TNeuronInput_R(Self: TNeuron; var T: Real);
begin T := Self.Input; end;

(*----------------------------------------------------------------------------*)
procedure TNeuronCountSynapses_R(Self: TNeuron; var T: Integer);
begin T := Self.CountSynapses; end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TNeuralNet(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TNeuralNet) do begin
    RegisterMethod(@TNeuralNet.AddLayer, 'AddLayer');
    RegisterMethod(@TNeuralNet.ConnectAll, 'ConnectAll');
    RegisterMethod(@TNeuralNet.Train, 'Train');
    RegisterMethod(@TNeuralNet.Compute, 'Compute');
    RegisterConstructor(@TNeuralNet.Create, 'Create');
    RegisterMethod(@TNeuralNet.Destroy, 'Free');
    RegisterPropertyHelper(@TNeuralNetCountLayers_R,nil,'CountLayers');
    RegisterPropertyHelper(@TNeuralNetCountInputs_R,nil,'CountInputs');
    RegisterPropertyHelper(@TNeuralNetCountOutputs_R,nil,'CountOutputs');
    RegisterPropertyHelper(@TNeuralNetInputs_R,@TNeuralNetInputs_W,'Inputs');
    RegisterPropertyHelper(@TNeuralNetOutputs_R,nil,'Outputs');
    RegisterPropertyHelper(@TNeuralNetResults_R,nil,'Results');
    RegisterPropertyHelper(@TNeuralNetEpoch_R,nil,'Epoch');
    RegisterPropertyHelper(@TNeuralNetError_R,nil,'Error');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TNeuronLayer(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TNeuronLayer) do  begin
    RegisterConstructor(@TNeuronLayer.Create, 'Create');
          RegisterMethod(@TNeuronLayer.Destroy, 'Free');
      RegisterPropertyHelper(@TNeuronLayerCountNeurons_R,nil,'CountNeurons');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TNeuron(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TNeuron) do
  begin
    RegisterConstructor(@TNeuron.Create, 'Create');
    RegisterPropertyHelper(@TNeuronCountSynapses_R,nil,'CountSynapses');
    RegisterPropertyHelper(@TNeuronInput_R,@TNeuronInput_W,'Input');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_NeuralNetwork(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TNeuron) do
  RIRegister_TNeuron(CL);
  RIRegister_TNeuronLayer(CL);
  RIRegister_TNeuralNet(CL);
end;

 
 
{ TPSImport_NeuralNetwork }
(*----------------------------------------------------------------------------*)
procedure TPSImport_NeuralNetwork.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_NeuralNetwork(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_NeuralNetwork.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_NeuralNetwork(ri);
end;
(*----------------------------------------------------------------------------*)
 
 
end.