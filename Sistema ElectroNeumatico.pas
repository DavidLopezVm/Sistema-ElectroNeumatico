unit scadainterfaz;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dOPCIntf, dOPCComn, dOPCDA, Vcl.Mask, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    PICture: TImage;
    Button1: TButton;
    Label4: TLabel;
    ServerCombo: TComboBox;
    Topic: TComboBox;
    ATIM: TEdit;
    ACOU: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    CONS1: TShape;
    EXPS1: TShape;
    EXPS2: TShape;
    CONS2: TShape;
    EXPS3: TShape;
    CONS3: TShape;
    dOPCDAClient1: TdOPCDAClient;
    Shape2: TShape;
    Shape3: TShape;
    Image2: TImage;
    Label7: TLabel;
    Image3: TImage;
    Image4: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Shape1: TShape;
    Image5: TImage;
    Label10: TLabel;
    Button5: TButton;
    Shape4: TShape;
    Image6: TImage;
    Image7: TImage;
    PIST: TImage;
    PIST4: TImage;
    PIST5: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    PIST2: TImage;
    Image11: TImage;
    PIST3: TImage;
    Image12: TImage;
    Image8: TImage;
    Image9: TImage;
    procedure dOPCDAClient1Datachange(Sender: TObject;ItemList: TdOPCItemList);

    procedure Button1Click(Sender: TObject);
    procedure ServerComboDropDown(Sender: TObject);
    procedure TopicDropDown(Sender: TObject);
    procedure TopicChange(Sender: TObject);




    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);






  private
    { Private declarations }
    Items: TdOPCGroup;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   etapa: Integer;
  // Items del LADDER //
  StartV: TdOPCItem;
  StopV: TdOPCItem;
  ResetV: TdOPCItem;
  SC1:TdOPCItem; //Sensor de contracción 1 Pistón 1
  SC2:TdOPCItem; //Sensor de contracción 2 Pistón 2
  SC3:TdOPCItem; //Sensor de contracción 3 Pistón 3
  SE1:TdOPCItem; //Sensor de expulsión 1 Pistón 1
  SE2:TdOPCItem; //Sensor de expulsión 2 Pistón 2
  SE3:TdOPCItem; //Sensor de expulsión 3 Pistón 3
siston:TdOPCItem; //Encendido
Con:TdOPCItem; //CiCLos de trabajo
Timer0pre:TdOPCItem;
Timer1pre:TdOPCItem;
TDN0:TdOPCItem;
TDN1:TdOPCItem;
Accum:TdOPCItem;

TDN1A:TdOPCItem;
TDN2A:TdOPCItem;
TDN3A:TdOPCItem;
implementation

{$R *.dfm}

procedure TForm1.dOPCDAClient1Datachange(Sender: TObject;ItemList: TdOPCItemList);
begin
  if SE1.Value=0 then
   EXPS1.Brush.Color:=clWhite;
  if SE1.Value=1 then
    EXPS1.Brush.Color:=clRed;
  if SC1.Value=0 then
    CONS1.Brush.Color:=clWhite;
  if SC1.Value=1 then
    CONS1.Brush.Color:=clRed;

      if SE2.Value=0 then
   EXPS2.Brush.Color:=clWhite;
  if SE2.Value=1 then
    EXPS2.Brush.Color:=clRed;
  if SC2.Value=0 then
    CONS2.Brush.Color:=clWhite;
  if SC2.Value=1 then
    CONS2.Brush.Color:=clRed;

  if SE3.Value=0 then
    EXPS3.Brush.Color:=clWhite;
  if SE3.Value=1 then
    EXPS3.Brush.Color:=clRed;
  if SC3.Value=0 then
    CONS3.Brush.Color:=clWhite;
  if SC3.Value=1 then
    CONS3.Brush.Color:=clRed;
  end;








procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 StartV.WriteSync('1');
end;

procedure TForm1.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
StartV.WriteSync('0');
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
StopV.WriteSync('1') ;
end;

procedure TForm1.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 StopV.WriteSync('0') ;
end;



procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ResetV.WriteSync('1') ;
end;

procedure TForm1.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ResetV.WriteSync('0') ;
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
    if dOPCDAClient1.Active = false then
  begin
    dOPCDAClient1.ServerName := ServerCombo.Text;
    Button5.Caption := 'CONECTADO'; //Cambiar a imagen, ver como
    dOPCDAClient1.Active := true;   //Habilita algo
   // seropc.Enabled := false;   Desabilita el combobox de los servers
    //topico.Enabled := true;      habilita el combobox del grupo
  end
  else if dOPCDAClient1.Active = true then
  begin
    dOPCDAClient1.Active := false;
    dOPCDAClient1.OPCGroups.RemoveAll;
    Button5.Caption := 'CONECTAR';
 //   seropc.Enabled := true; Habilita el combobox de los servers
//    start.Enabled := false;
//    stop.Enabled := false;
//    Timer1.Enabled := false;
  end;
end;

procedure TForm1.Image6Click(Sender: TObject);
var
t0:integer;
c1:integer;
begin
t0:=StrToInt(ATIM.Text);
c1:=StrToInt(ACOU.Text);
if (t0>0)or(t0<=15) then
begin
Timer0pre.WriteSync(t0);
end else
begin
ShowMessage('Tu valor no es un número entero dentro del rango disponible');

end;
if (c1>0)or(c1<=10) then
begin
Con.WriteSync(c1);
ShowMessage('Valores actualizados');
end else
begin
ShowMessage('Tu valor no es un número entero dentro del rango disponible');
//Si no, muestra el mensaje para fuera de rango
end;
end;




procedure TForm1.Button1Click(Sender: TObject);
begin
    Form1.Close;
end;









procedure TForm1.ServerComboDropDown(Sender: TObject);
begin

  if trim(ServerCombo.Items.Text) = '' then  // if no OPC Servernames loaded
  begin
    Screen.Cursor := crHourGlass;
      GetOPCDAServers(ServerCombo.Items,coCOM);        // get OPC DA Server
    Screen.Cursor := crDefault;

end;
end;



procedure Topicos(Browser: TdOPCBrowser; ItemList: TStrings); // Función Tópicos
var
i : integer; //Iterador
Items : TdOPCBrowseItems; //Declaracion de un item de busqueda
BrowseItem : TdOPCBrowseItem; //Buscardor de items
begin
Browser.Browse; // Obtiene todos las sucursales e items en este nivel del OPC Server
Items := TdOPCBrowseItems.Create; // Crea una lista nueva
Items.Assign(Browser.Items); // Guarda y copia los Items en una lista nueva

for i := 0 to Items.Count-1 do // Para todos los items que se encuentran a su paso
begin
BrowseItem := Items[i]; //Entrada al arreglo
if BrowseItem.IsItem <> true then // Si el browse item no es un foder
ItemList.Add(BrowseItem.ItemName); // Añade el Item a la lista
end;
Items.Free; //Libera los items
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    pist4.Left:=451;
pist5.Left:=451;
if(pist.Left>=400) and (SE1.Value=1) then //Si el embolo del pistón 4B no ha llegado a su posición
begin
pist.Left:=pist.Left - 90; //Le pedimos que se mueva hasta la posición indicada
end;
if(pist.Left<=500) and (SC1.Value=1) then //Si el embolo del pistón 4B no ha llegado a su posición
begin
pist.Left:=pist.Left + 90; //Le pedimos que se mueva hasta la posición indicada
end;

if(pist2.Left>=400) and (SE2.Value=1) then //Si el embolo del pistón 4B no ha llegado a su posición
begin
pist2.Left:=pist2.Left - 90; //Le pedimos que se mueva hasta la posición indicada
end;
if(pist2.Left<=500) and (Sc2.Value=1) then //Si el embolo del pistón 4B no ha llegado a su posición
begin
pist2.Left:=pist2.Left + 90; //Le pedimos que se mueva hasta la posición indicada
end;

if(pist3.Left>=400) and (SE3.Value=1) then //Si el embolo del pistón 4B no ha llegado a su posición
begin
pist3.Left:=pist3.Left - 90; //Le pedimos que se mueva hasta la posición indicada
end;
if(pist3.Left<=500) and (SC3.Value=1) then //Si el embolo del pistón 4B no ha llegado a su posición
begin
pist3.Left:=pist3.Left + 90; //Le pedimos que se mueva hasta la posición indicada
end;
END ;

procedure TForm1.TopicChange(Sender: TObject);
begin
Items:= dOPCDAClient1.OPCGroups.Add('Items');//Declaración del grupo en donde escribimos nuestros variables
Items.UpdateRate:=10;
StartV:=Items.OPCItems.AddItem('[PROYECTO SCADA]B3:0.2');//Asignación de la variable START_R a la variable de memoria del controlador para escritura
StopV:=Items.OPCItems.AddItem('[PROYECTO SCADA]B3:0/3');
ResetV:=Items.OPCItems.AddItem('[PROYECTO SCADA]B3:0.13');
SC1:=Items.OPCItems.AddItem('[PROYECTO SCADA]I:1/2');
SE1:=Items.OPCItems.AddItem('[PROYECTO SCADA]I:1/3');
SC2:=Items.OPCItems.AddItem('[PROYECTO SCADA]I:1/4');
SE2:=Items.OPCItems.AddItem('[PROYECTO SCADA]I:1/5');
SC3:=Items.OPCItems.AddItem('[PROYECTO SCADA]I:1/6');
SE3:=Items.OPCItems.AddItem('[PROYECTO SCADA]I:1/7');
Con:=Items.OPCItems.AddItem('[PROYECTO SCADA]C5:0.PRE');
Timer0pre:=Items.OPCItems.AddItem('[PROYECTO SCADA]T4:0.PRE');
Timer1pre:=Items.OPCItems.AddItem('[PROYECTO SCADA]T4:1.PRE');
TDN0:=Items.OPCItems.AddItem('[PROYECTO SCADA]T4:0/DN');
TDN1:=Items.OPCItems.AddItem('[PROYECTO SCADA]T4:1/DN');
Accum:=Items.OPCItems.AddItem('[PROYECTO SCADA]C5:0.ACC');
end;

procedure TForm1.TopicDropDown(Sender: TObject);
begin
Topicos(dOPCDAClient1.Browser,Topic.Items);

end;


end.