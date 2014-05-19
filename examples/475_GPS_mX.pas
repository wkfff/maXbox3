unit GPSUtils_Demo;

//http://www.eye4software.com/products/gpstoolkit/source/delphi/nmea0183/
//#locs:182
//#sign:Administrator: PC08: 15/05/2014 06:02:13 PM 
//http://projecteuler.net/


//Declare and create the object(s)

{First, we have to include some units to be able to use ActiveX controls in our Delphi project. We need to include the following units: OleServer, ComObj, ActiveX. You can modify code like this:}

//7uses
  //Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  //Dialogs, StdCtrls, ExtCtrls, OleServer, ComObj, ActiveX;

{Now we are ready to declare and the GPS Toolkit objects. You can add the defintion in the "private" declarations section at the top of the source file:}

//private:
{  var
  objGps         : Variant;
  objConstants   : Variant;

create the GPS Toolkit objects in the form, double click on the form to create and edit the FormCreate handler:

  objGps            := CreateOleObject ( 'Eye4Software.Gps' );
  objGpsConstants   := CreateOleObject ( 'Eye4Software.GpsConstants' );

After these steps, you can start with programming the rest of the GPS code.
The source code

Below you can find the sourcecode from the Borland Delphi demo as shipped with the GPS Toolkit.  }

//unit GPSDemo;

interface

{uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OleServer, ComObj, ActiveX;}

//type
  //TForm1 = class(TForm)
    var
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxDevice: TComboBox;
    ComboBoxSpeed: TComboBox;
    ButtonStart: TButton;
    ButtonStop: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EditLatitude: TEdit;
    EditLongitude: TEdit;
    EditSpeed: TEdit;
    EditCourse: TEdit;
    EditAltitude: TEdit;
    EditTime: TEdit;
    EditFix: TEdit;
    EditSats: TEdit;
    GroupBox3: TGroupBox;
    LabelStatus: TLabel;
    Timer1: TTimer;
    Label11: TLabel;
    procedure TForm1_FormCreate(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
  //private

  var
    objGps        : Variant;

  //public
    { Public declarations }
  //end;

var
  Form1: TForm;

implementation

//{$R *.dfm}

{//////////////////////////////////////////////////////////////////////////////}

procedure TForm1_FormCreate(Sender: TObject);
var i : Integer;
begin

  objGps        := CreateOleObject ( 'Eye4Software.Gps' );

  ComboBoxDevice.Items.Add ( 'Garmin USB' );

  for i := 1 to 16 do
  begin
    ComboBoxDevice.Items.Add('COM' + IntToStr ( i ) );
  end;

  ComboBoxDevice.ItemIndex := 1;

  ComboBoxSpeed.Items.Add ( '1200' );
  ComboBoxSpeed.Items.Add ( '2400' );
  ComboBoxSpeed.Items.Add ( '4800' );
  ComboBoxSpeed.Items.Add ( '9600' );
  ComboBoxSpeed.Items.Add ( '19200' );
  ComboBoxSpeed.Items.Add ( '38400' );
  ComboBoxSpeed.Items.Add ( '57600' );
  ComboBoxSpeed.Items.Add ( '115200' );

  ComboBoxSpeed.ItemIndex := 2;

end;

{//////////////////////////////////////////////////////////////////////////////}

procedure ButtonStartClick(Sender: TObject);
begin
  objGps.DeviceSerialPort := ComboBoxDevice.ItemIndex;
  objGps.DeviceBaudrate   := StrToInt ( ComboBoxSpeed.Text );

  objGps.Open;

  LabelStatus.Caption := objGps.LastErrorDescription;

  if ( objGps.LastError = 0 ) then begin
    ButtonStart.Enabled := False;
    ButtonStop.Enabled := True;
    Timer1.Enabled := True;
  end;
end;

{//////////////////////////////////////////////////////////////////////////////}

procedure ButtonStopClick(Sender: TObject);
begin
  objGps.Close;

  LabelStatus.Caption := objGps.LastErrorDescription;

  if ( objGps.LastError = 0 ) then begin
    ButtonStart.Enabled := True;
    ButtonStop.Enabled := False;
    Timer1.Enabled := False;
  end;
end;

{//////////////////////////////////////////////////////////////////////////////}

procedure Timer1Timer(Sender: TObject);
begin
  EditLatitude.Text :=  objGps.gpsLatitudeString;
  EditLongitude.Text := objGps.gpsLongitudeString;
  EditSpeed.Text :=  FloatToStr ( objGps.gpsSpeed );
  EditCourse.Text :=  FloatToStr ( objGps.gpsCourse );
  EditAltitude.Text := FloatToStr ( objGps.gpsAltitude );
  EditFix.Text := IntToStr ( objGps.gpsQuality );
  EditSats.Text := IntToStr ( objGps.gpsSatellites );
  EditTime.Text := objGps.gpsTimeString;
end;

{//////////////////////////////////////////////////////////////////////////////}


begin
 if isInternet then 
     //wGet('http://www.softwareschule.ch/download/maxbox_starter4.pdf','mytestpdf.pdf');
     
     //openDoc('http://www.eye4software.com/products/gpstoolkit/source/delphi/nmea0183/');
     //S_ShellExecute('http:'+getHostIP+':'+IntToStr(APORT)+'/','',seCmdOpen)
     S_ShellExecute('http://www.eye4software.com/products/gpstoolkit/source/delphi/nmea0183/','',seCmdOpen)
     
     //http://www.eye4software.com/products/gpstoolkit/source/delphi/nmea0183/'
end.



  //maXbox converted by mX
  

 {Delphi component for easy interface to your GPS receiver.
TGPS is an interface to a GPS receiver. TGPS can be used with all GPS receiver that sends NMEA 0183 data, and that can be connected to a COM port on the computer.
With TGPS you will:

    Have access to position, time, speed, heading, bearings, waypoints, routes and more. (This may however vary depending on what data the connected GPS receiver delivers.)
    Also included are two components that gives a graphical picture of satellite positions and signal strength.
    Autodetect method for easy COM port setup

TGPS is tested with Delphi 3.0, 4.0, 6.0 and 7.0
TGPS comes with an exe-demo that let you easily test your receiver with the component. All you have to do is to click Auto Detect, and then the component will detect the GPS. Please note that the receiver must be set to transmitting NMEA data. The default setting for many receivers is a propriarity format.

If you register TGPS, you will have these benefits:

    Rights to use TGPS commercially.
    Receive full source code.
    The unregistered version will only send all data for 60 minutes. After that it will only send positions.
    Fast and efficient support.
    
    function  MyGetTickCount: Longint;
       external 'GetTickCount@kernel32.dll stdcall';  }
       

