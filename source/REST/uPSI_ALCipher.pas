unit uPSI_ALCipher;
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
  TPSImport_ALCipher = class(TPSPlugin)
  protected
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_ALCipher(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_ALCipher_Routines(S: TPSExec);
procedure RIRegister_ALCipher(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   Windows
  ,AlFcnString
  ,ALCipher
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_ALCipher]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_ALCipher(CL: TPSPascalCompiler);
begin
 CL.AddConstantN('cALCipherMaxStructSize','LongInt').SetInt( 1024 * 2000000);
  CL.AddClassN(CL.FindClass('TOBJECT'),'EALCipherException');
  CL.AddTypeS('pALCipherLongIntArray', '^TALCipherLongIntArray // will not work');
  CL.AddTypeS('TALCipherLongIntRec', 'record Lo : Word; Hi : Word; end');
  CL.AddTypeS('TALCipherInt64', 'record Lo : LongInt; Hi : LongInt; LoLo : Word'
   +'; end');
  CL.AddTypeS('TALCipherRDLVector', 'record dw : DWord; end');
  CL.AddTypeS('PALCipherKey64', '^TALCipherKey64 // will not work');
  CL.AddTypeS('PALCipherKey128', '^TALCipherKey128 // will not work');
  CL.AddTypeS('PALCipherKey192', '^TALCipherKey192 // will not work');
  CL.AddTypeS('PALCipherKey256', '^TALCipherKey256 // will not work');
 CL.AddConstantN('cALCipherBFRounds','LongInt').SetInt( 16);
 CL.AddConstantN('cALCipherMaxRDLRounds','LongInt').SetInt( 14);
 CL.AddDelphiFunction('Procedure ALCipherGenerateMD5Key( var Key : TALCipherKey128; const Str : AnsiString)');
 CL.AddDelphiFunction('Procedure ALCipherGenerateRandomKey( var Key, KeySize : Integer)');
 CL.AddDelphiFunction('Function AlCipherBufferToHex( const Buf, BufSize : Cardinal) : AnsiString');
 CL.AddDelphiFunction('Procedure ALCipherXorMem( var Mem1 : string; const Mem2 : string; Count : Cardinal)');
 CL.AddDelphiFunction('Function ALCipherRolX( I, C : DWord) : DWord');
 CL.AddDelphiFunction('Procedure ALCipherInitEncryptBF( Key : TALCipherKey128; var Context : TALCipherBFContext)');
 CL.AddDelphiFunction('Procedure ALCipherEncryptBF( const Context : TALCipherBFContext; var Block : TALCipherBFBlock; Encrypt : Boolean)');
 CL.AddDelphiFunction('Procedure ALCipherEncryptBFCBC( const Context : TALCipherBFContext; const Prev : TALCipherBFBlock; var Block : TALCipherBFBlock; Encrypt : Boolean)');
 CL.AddDelphiFunction('Procedure ALBFEncryptString( const InString : AnsiString; var OutString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptStringCBC( const InString : AnsiString; var OutString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean);');
 CL.AddDelphiFunction('Function AlBFEncryptString( const InString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Function ALBFEncryptStringCBC( const InString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALBFEncryptFile( const InFile, OutFile : AnsiString; const Key : TAlCipherKey128; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptFileCBC( const InFile, OutFile : AnsiString; const Key : TAlCipherKey128; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptStream( InStream, OutStream : TStream; const Key : TAlCipherKey128; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptStreamCBC( InStream, OutStream : TStream; const Key : TAlCipherKey128; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptString( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptStringCBC( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Function AlBFEncryptString( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Function ALBFEncryptStringCBC( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALBFEncryptStream( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptStreamCBC( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptFile( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALBFEncryptFileCBC( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALCipherInitEncryptRDL( const Key, KeySize : Longint; var Context : TALCipherRDLContext; Encrypt : Boolean)');
 CL.AddDelphiFunction('Procedure ALCipherEncryptRDL( const Context : TALCipherRDLContext; var Block : TALCipherRDLBlock)');
 CL.AddDelphiFunction('Procedure ALCipherEncryptRDLCBC( const Context : TALCipherRDLContext; const Prev : TALCipherRDLBlock; var Block : TALCipherRDLBlock)');
 CL.AddDelphiFunction('Procedure ALRDLEncryptString( const InString : AnsiString; var OutString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptStringCBC( const InString : AnsiString; var OutString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);');
 CL.AddDelphiFunction('Function ALRDLEncryptString( const InString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Function ALRDLEncryptStringCBC( const InString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALRDLEncryptFile( const InFile, OutFile : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptFileCBC( const InFile, OutFile : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptStream( InStream, OutStream : TStream; const Key, KeySize : Longint; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptStreamCBC( InStream, OutStream : TStream; const Key, KeySize : Longint; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptString( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptStringCBC( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Function ALRDLEncryptString( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Function ALRDLEncryptStringCBC( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALRDLEncryptFile( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptFileCBC( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptStream( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALRDLEncryptStreamCBC( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);');
 CL.AddDelphiFunction('Procedure ALCipherInitMD5( var Context : TALCipherMD5Context)');
 CL.AddDelphiFunction('Procedure ALCipherHashMD5( var Digest : TALCipherMD5Digest; const Buf, BufSize : LongInt)');
 CL.AddDelphiFunction('Procedure ALCipherFinalizeMD5( var Context : TALCipherMD5Context; var Digest : TALCipherMD5Digest)');
 CL.AddDelphiFunction('Procedure ALCipherUpdateMD5( var Context : TALCipherMD5Context; const Buf, BufSize : LongInt)');
 CL.AddDelphiFunction('Procedure ALFileHashMD5( var Digest : TAlCipherMD5Digest; const AFileName : AnsiString);');
 CL.AddDelphiFunction('Function ALFileHashMD51( const AFileName : AnsiString) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALStreamHashMD5( var Digest : TAlCipherMD5Digest; AStream : TStream);');
 CL.AddDelphiFunction('Function ALStreamHashMD51( AStream : TStream) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALStringHashMD5( var Digest : TALCipherMD5Digest; const Str : AnsiString);');
 CL.AddDelphiFunction('Function ALStringHashMD51( const Str : AnsiString) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALCipherInitSHA1( var Context : TALCipherSHA1Context)');
 CL.AddDelphiFunction('Procedure ALCipherHashSHA1( var Digest : TALCipherSHA1Digest; const Buf, BufSize : Longint)');
 CL.AddDelphiFunction('Procedure ALCipherUpdateSHA1( var Context : TALCipherSHA1Context; const Buf, BufSize : Longint)');
 CL.AddDelphiFunction('Procedure ALCipherFinalizeSHA1( var Context : TALCipherSHA1Context; var Digest : TALCipherSHA1Digest)');
 CL.AddDelphiFunction('Procedure ALFileHashSHA1( var Digest : TAlCipherSHA1Digest; const AFileName : AnsiString);');
 CL.AddDelphiFunction('Function ALFileHashSHA11( const AFileName : AnsiString) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALStreamHashSHA1( var Digest : TAlCipherSHA1Digest; AStream : TStream);');
 CL.AddDelphiFunction('Function ALStreamHashSHA11( AStream : TStream) : AnsiString;');
 CL.AddDelphiFunction('Procedure ALStringHashSHA1( var Digest : TALCipherSHA1Digest; const Str : AnsiString);');
 CL.AddDelphiFunction('Function ALStringHashSHA11( const Str : AnsiString) : AnsiString;');
 CL.AddDelphiFunction('Function ALCalcHMACSHA1( const Str, Key : AnsiString) : AnsiString');
 CL.AddDelphiFunction('Function ALCalcHMACMD5( const Str, Key : AnsiString) : AnsiString');
 CL.AddDelphiFunction('Procedure ALCipherHashELF( var Digest : LongInt; const Buf, BufSize : LongInt)');
 CL.AddDelphiFunction('Procedure ALCipherHashMix128( var Digest : LongInt; const Buf, BufSize : LongInt)');
 CL.AddDelphiFunction('Procedure ALStringHashELF( var Digest : LongInt; const Str : AnsiString);');
 CL.AddDelphiFunction('Function ALStringHashELF1( const Str : AnsiString) : LongInt;');
 CL.AddDelphiFunction('Procedure ALStringHashMix128( var Digest : LongInt; const Str : AnsiString);');
 CL.AddDelphiFunction('Function ALStringHashMix1281( const Str : AnsiString) : LongInt;');
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
Function ALStringHashMix1281_P( const Str : AnsiString) : LongInt;
Begin Result := ALCipher.ALStringHashMix128(Str); END;

(*----------------------------------------------------------------------------*)
Procedure ALStringHashMix128_P( var Digest : LongInt; const Str : AnsiString);
Begin ALCipher.ALStringHashMix128(Digest, Str); END;

(*----------------------------------------------------------------------------*)
Function ALStringHashELF1_P( const Str : AnsiString) : LongInt;
Begin Result := ALCipher.ALStringHashELF(Str); END;

(*----------------------------------------------------------------------------*)
Procedure ALStringHashELF_P( var Digest : LongInt; const Str : AnsiString);
Begin ALCipher.ALStringHashELF(Digest, Str); END;

(*----------------------------------------------------------------------------*)
Function ALStringHashSHA11_P( const Str : AnsiString) : AnsiString;
Begin Result := ALCipher.ALStringHashSHA1(Str); END;

(*----------------------------------------------------------------------------*)
Procedure ALStringHashSHA1_P( var Digest : TALCipherSHA1Digest; const Str : AnsiString);
Begin ALCipher.ALStringHashSHA1(Digest, Str); END;

(*----------------------------------------------------------------------------*)
Function ALStreamHashSHA11_P( AStream : TStream) : AnsiString;
Begin Result := ALCipher.ALStreamHashSHA1(AStream); END;

(*----------------------------------------------------------------------------*)
Procedure ALStreamHashSHA1_P( var Digest : TAlCipherSHA1Digest; AStream : TStream);
Begin ALCipher.ALStreamHashSHA1(Digest, AStream); END;

(*----------------------------------------------------------------------------*)
Function ALFileHashSHA11_P( const AFileName : AnsiString) : AnsiString;
Begin Result := ALCipher.ALFileHashSHA1(AFileName); END;

(*----------------------------------------------------------------------------*)
Procedure ALFileHashSHA1_P( var Digest : TAlCipherSHA1Digest; const AFileName : AnsiString);
Begin ALCipher.ALFileHashSHA1(Digest, AFileName); END;

(*----------------------------------------------------------------------------*)
Function ALStringHashMD51_P( const Str : AnsiString) : AnsiString;
Begin Result := ALCipher.ALStringHashMD5(Str); END;

(*----------------------------------------------------------------------------*)
Procedure ALStringHashMD5_P( var Digest : TALCipherMD5Digest; const Str : AnsiString);
Begin ALCipher.ALStringHashMD5(Digest, Str); END;

(*----------------------------------------------------------------------------*)
Function ALStreamHashMD51_P( AStream : TStream) : AnsiString;
Begin Result := ALCipher.ALStreamHashMD5(AStream); END;

(*----------------------------------------------------------------------------*)
Procedure ALStreamHashMD5_P( var Digest : TAlCipherMD5Digest; AStream : TStream);
Begin ALCipher.ALStreamHashMD5(Digest, AStream); END;

(*----------------------------------------------------------------------------*)
Function ALFileHashMD51_P( const AFileName : AnsiString) : AnsiString;
Begin Result := ALCipher.ALFileHashMD5(AFileName); END;

(*----------------------------------------------------------------------------*)
Procedure ALFileHashMD5_P( var Digest : TAlCipherMD5Digest; const AFileName : AnsiString);
Begin ALCipher.ALFileHashMD5(Digest, AFileName); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptStreamCBC_P( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptStreamCBC(InStream, OutStream, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptStream_P( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptStream(InStream, OutStream, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptFileCBC_P( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptFileCBC(InFile, OutFile, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptFile_P( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptFile(InFile, OutFile, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function ALRDLEncryptStringCBC_P( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.ALRDLEncryptStringCBC(InString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function ALRDLEncryptString_P( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.ALRDLEncryptString(InString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptStringCBC_P( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptStringCBC(InString, OutString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptString_P( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptString(InString, OutString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptStreamCBC_P( InStream, OutStream : TStream; const Key, KeySize : Longint; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptStreamCBC(InStream, OutStream, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptStream_P( InStream, OutStream : TStream; const Key, KeySize : Longint; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptStream(InStream, OutStream, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptFileCBC_P( const InFile, OutFile : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptFileCBC(InFile, OutFile, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptFile_P( const InFile, OutFile : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptFile(InFile, OutFile, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function ALRDLEncryptStringCBC_P( const InString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.ALRDLEncryptStringCBC(InString, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function ALRDLEncryptString_P( const InString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.ALRDLEncryptString(InString, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptStringCBC_P( const InString : AnsiString; var OutString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptStringCBC(InString, OutString, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALRDLEncryptString_P( const InString : AnsiString; var OutString : AnsiString; const Key, KeySize : Longint; Encrypt : Boolean);
Begin ALCipher.ALRDLEncryptString(InString, OutString, Key, KeySize, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptFileCBC_P( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptFileCBC(InFile, OutFile, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptFile_P( const InFile, OutFile : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptFile(InFile, OutFile, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptStreamCBC_P( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptStreamCBC(InStream, OutStream, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptStream_P( InStream, OutStream : TStream; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptStream(InStream, OutStream, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function ALBFEncryptStringCBC_P( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.ALBFEncryptStringCBC(InString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function AlBFEncryptString_P( const InString : AnsiString; const Key : AnsiString; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.AlBFEncryptString(InString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptStringCBC_P( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptStringCBC(InString, OutString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptString_P( const InString : AnsiString; var OutString : AnsiString; const Key : AnsiString; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptString(InString, OutString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptStreamCBC_P( InStream, OutStream : TStream; const Key : TAlCipherKey128; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptStreamCBC(InStream, OutStream, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptStream_P( InStream, OutStream : TStream; const Key : TAlCipherKey128; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptStream(InStream, OutStream, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptFileCBC_P( const InFile, OutFile : AnsiString; const Key : TAlCipherKey128; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptFileCBC(InFile, OutFile, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptFile_P( const InFile, OutFile : AnsiString; const Key : TAlCipherKey128; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptFile(InFile, OutFile, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function ALBFEncryptStringCBC_P( const InString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.ALBFEncryptStringCBC(InString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Function AlBFEncryptString_P( const InString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean) : AnsiString;
Begin Result := ALCipher.AlBFEncryptString(InString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptStringCBC_P( const InString : AnsiString; var OutString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptStringCBC(InString, OutString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
Procedure ALBFEncryptString_P( const InString : AnsiString; var OutString : AnsiString; const Key : TALCipherKey128; Encrypt : Boolean);
Begin ALCipher.ALBFEncryptString(InString, OutString, Key, Encrypt); END;

(*----------------------------------------------------------------------------*)
procedure RIRegister_ALCipher_Routines(S: TPSExec);
begin
 S.RegisterDelphiFunction(@ALCipherGenerateMD5Key, 'ALCipherGenerateMD5Key', cdRegister);
 S.RegisterDelphiFunction(@ALCipherGenerateRandomKey, 'ALCipherGenerateRandomKey', cdRegister);
 S.RegisterDelphiFunction(@AlCipherBufferToHex, 'AlCipherBufferToHex', cdRegister);
 S.RegisterDelphiFunction(@ALCipherXorMem, 'ALCipherXorMem', cdRegister);
 S.RegisterDelphiFunction(@ALCipherRolX, 'ALCipherRolX', cdRegister);
 S.RegisterDelphiFunction(@ALCipherInitEncryptBF, 'ALCipherInitEncryptBF', cdRegister);
 S.RegisterDelphiFunction(@ALCipherEncryptBF, 'ALCipherEncryptBF', cdRegister);
 S.RegisterDelphiFunction(@ALCipherEncryptBFCBC, 'ALCipherEncryptBFCBC', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptString, 'ALBFEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStringCBC, 'ALBFEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@AlBFEncryptString, 'AlBFEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStringCBC, 'ALBFEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptFile, 'ALBFEncryptFile', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptFileCBC, 'ALBFEncryptFileCBC', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStream, 'ALBFEncryptStream', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStreamCBC, 'ALBFEncryptStreamCBC', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptString, 'ALBFEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStringCBC, 'ALBFEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@AlBFEncryptString, 'AlBFEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStringCBC, 'ALBFEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStream, 'ALBFEncryptStream', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptStreamCBC, 'ALBFEncryptStreamCBC', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptFile, 'ALBFEncryptFile', cdRegister);
 S.RegisterDelphiFunction(@ALBFEncryptFileCBC, 'ALBFEncryptFileCBC', cdRegister);
 S.RegisterDelphiFunction(@ALCipherInitEncryptRDL, 'ALCipherInitEncryptRDL', cdRegister);
 S.RegisterDelphiFunction(@ALCipherEncryptRDL, 'ALCipherEncryptRDL', cdRegister);
 S.RegisterDelphiFunction(@ALCipherEncryptRDLCBC, 'ALCipherEncryptRDLCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptString, 'ALRDLEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStringCBC, 'ALRDLEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptString, 'ALRDLEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStringCBC, 'ALRDLEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptFile, 'ALRDLEncryptFile', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptFileCBC, 'ALRDLEncryptFileCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStream, 'ALRDLEncryptStream', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStreamCBC, 'ALRDLEncryptStreamCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptString, 'ALRDLEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStringCBC, 'ALRDLEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptString, 'ALRDLEncryptString', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStringCBC, 'ALRDLEncryptStringCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptFile, 'ALRDLEncryptFile', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptFileCBC, 'ALRDLEncryptFileCBC', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStream, 'ALRDLEncryptStream', cdRegister);
 S.RegisterDelphiFunction(@ALRDLEncryptStreamCBC, 'ALRDLEncryptStreamCBC', cdRegister);
 S.RegisterDelphiFunction(@ALCipherInitMD5, 'ALCipherInitMD5', cdRegister);
 S.RegisterDelphiFunction(@ALCipherHashMD5, 'ALCipherHashMD5', cdRegister);
 S.RegisterDelphiFunction(@ALCipherFinalizeMD5, 'ALCipherFinalizeMD5', cdRegister);
 S.RegisterDelphiFunction(@ALCipherUpdateMD5, 'ALCipherUpdateMD5', cdRegister);
 S.RegisterDelphiFunction(@ALFileHashMD5, 'ALFileHashMD5', cdRegister);
 S.RegisterDelphiFunction(@ALFileHashMD51, 'ALFileHashMD51', cdRegister);
 S.RegisterDelphiFunction(@ALStreamHashMD5, 'ALStreamHashMD5', cdRegister);
 S.RegisterDelphiFunction(@ALStreamHashMD51, 'ALStreamHashMD51', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashMD5, 'ALStringHashMD5', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashMD51, 'ALStringHashMD51', cdRegister);
 S.RegisterDelphiFunction(@ALCipherInitSHA1, 'ALCipherInitSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALCipherHashSHA1, 'ALCipherHashSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALCipherUpdateSHA1, 'ALCipherUpdateSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALCipherFinalizeSHA1, 'ALCipherFinalizeSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALFileHashSHA1, 'ALFileHashSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALFileHashSHA11, 'ALFileHashSHA11', cdRegister);
 S.RegisterDelphiFunction(@ALStreamHashSHA1, 'ALStreamHashSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALStreamHashSHA11, 'ALStreamHashSHA11', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashSHA1, 'ALStringHashSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashSHA11, 'ALStringHashSHA11', cdRegister);
 S.RegisterDelphiFunction(@ALCalcHMACSHA1, 'ALCalcHMACSHA1', cdRegister);
 S.RegisterDelphiFunction(@ALCalcHMACMD5, 'ALCalcHMACMD5', cdRegister);
 S.RegisterDelphiFunction(@ALCipherHashELF, 'ALCipherHashELF', cdRegister);
 S.RegisterDelphiFunction(@ALCipherHashMix128, 'ALCipherHashMix128', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashELF, 'ALStringHashELF', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashELF1, 'ALStringHashELF1', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashMix128, 'ALStringHashMix128', cdRegister);
 S.RegisterDelphiFunction(@ALStringHashMix1281, 'ALStringHashMix1281', cdRegister);
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_ALCipher(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(EALCipherException) do
end;

 
 
{ TPSImport_ALCipher }
(*----------------------------------------------------------------------------*)
procedure TPSImport_ALCipher.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_ALCipher(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_ALCipher.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_ALCipher(ri);
  RIRegister_ALCipher_Routines(CompExec.Exec); // comment it if no routines
end;
(*----------------------------------------------------------------------------*)
 
 
end.
