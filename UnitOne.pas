unit UnitOne;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts,
  FMX.TabControl, FMX.MultiView, FMX.StdCtrls, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  FMX.ScrollBox,
  FMX.Memo;

type
  TForm1 = class(TForm)
    EditAPIkey: TEdit;
    TabControl1: TTabControl;
    MultiView1: TMultiView;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    GridLayout1: TGridLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Text1: TText;
    EditLng: TEdit;
    Label1: TLabel;
    EditLat: TEdit;
    Label2: TLabel;
    RoundRect1: TRoundRect;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Rectangle4: TRectangle;
    SpeedButton1: TSpeedButton;
    Text2: TText;
    NetHTTPClient1: TNetHTTPClient;
    Memo1: TMemo;
    Layout1: TLayout;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Text3: TText;
    procedure FormCreate(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Rectangle5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure test;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


uses JsonDataObjects;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.TabIndex := 0;
  Layout1.Visible := False;
end;

procedure TForm1.Rectangle5Click(Sender: TObject);
begin
  Layout1.Visible := False;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
end;

procedure TForm1.test;
var
  Obj: TJsonObject;
  s: string;
  latlng: string;
  lat, lng: Double;
  a: TArray<string>;
begin
  // s := '{                            '+
  // '	"status"     : "1",        '+
  // '	"info"       : "ok",       '+
  // '  "infocode"   : "10000",    '+
  // '  "locations"  : "116.487585177952,39.991754014757"'+
  // '}';
  Obj := TJsonObject.Parse(s) as TJsonObject;

  ShowMessage(Obj['status']);
  ShowMessage(Obj['info']);
  ShowMessage(Obj['infocode']);
  ShowMessage(Obj['locations']);
  ShowMessage(Obj['Locations']); // ???

  ShowMessage(Obj.I['status'].ToString);
  ShowMessage(Obj.s['info']);
  ShowMessage(Obj.I['infocode'].ToString);
  ShowMessage(Obj.s['locations']);
  ShowMessage(Obj.s['locations']); // ???

  latlng := Obj['locations'];
  a := latlng.Split([',']);
  ShowMessage(a[0]);
  ShowMessage(a[1]);
  lat := a[1].ToDouble;
  lng := a[0].ToDouble;

  Obj.Free;
end;

procedure TForm1.Text1Click(Sender: TObject);
begin
  TabControl1.TabIndex := 1;
end;

procedure TForm1.Text2Click(Sender: TObject);
var
  apiAddress: string;
  ss: TStringStream;
  jsonObj: TJsonObject;
  lnglat: string;
  sa: TArray<string>;
begin
  apiAddress := 'http://restapi.amap.com/v3/assistant/coordinate/convert?';
  apiAddress := apiAddress + '&coordsys=gps&output=json';
  apiAddress := apiAddress + '&key=' + EditAPIkey.Text;
  apiAddress := apiAddress + '&locations=';
  apiAddress := apiAddress + EditLng.Text + ',' + EditLat.Text;

  Memo1.Lines.Text := apiAddress;
  Layout1.Visible := True;
  Text3.Text := apiAddress;
  { http://restapi.amap.com/v3/assistant/coordinate/convert?&coordsys=gps&
    output=xml&key=<ÓÃ»§µÄkey>
    locations=116.481499,39.990475 }
  ss := TStringStream.Create;
  NetHTTPClient1.Get(apiAddress, ss);
  Memo1.Lines.Text := ss.DataString;

  jsonObj := TJsonObject.Parse(ss.DataString) as TJsonObject;
  if jsonObj['status'] = '1' then
  begin
    lnglat := jsonObj['locations'];
    sa := lnglat.Split([',']);
    Edit3.Text := sa[0];
    Edit2.Text := sa[1];
  end;

  jsonObj.Free;
  ss.Free;

  // NetHTTPClient1.Get()
  // NetHTTPClient1.Post()
  // NetHTTPClient1.Trace()
  // NetHTTPClient1.Delete()
  // NetHTTPClient1.Head()
  // NetHTTPClient1.Options()
end;

end.
