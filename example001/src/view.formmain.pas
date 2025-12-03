unit view.FormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, extctrls,
  StdCtrls, StrUtils, uElectricalOutlet, uLightingFixture, uFan;

type

  { TFormMain }

  TFormMain = class(TForm)
    BtnDevice: TButton;
    GBEletrodomestico: TGroupBox;
    RGEletricalOutlet: TRadioGroup;
    TBEnergy: TToggleBox;
    procedure BtnDeviceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RGEletricalOutletSelectionChanged(Sender: TObject);
    procedure TBEnergyChange(Sender: TObject);
  private
    FAppliance: TAppliance;
    FPlug: IPlug;
    function CurrentFan: TFan;
    procedure CreateAppliance;
    procedure UpdateUI;
    procedure HandleFanAction;
    procedure HandleLightingAction;
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

function TFormMain.CurrentFan: TFan;
begin
  if FAppliance is TFan then
    Result := TFan(FAppliance)
  else
    Result := nil;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FPlug := TElectricalOutlet.New;
  FAppliance := nil;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FAppliance);
end;

procedure TFormMain.RGEletricalOutletSelectionChanged(Sender: TObject);
begin
  CreateAppliance;
end;

procedure TFormMain.TBEnergyChange(Sender: TObject);
begin
  FPlug.Energize := TBEnergy.Checked;
  UpdateUI;
end;

procedure TFormMain.BtnDeviceClick(Sender: TObject);
begin
  if Assigned(CurrentFan) then
    HandleFanAction
  else
    HandleLightingAction;
end;

procedure TFormMain.CreateAppliance;
begin
  FreeAndNil(FAppliance);
  case RGEletricalOutlet.ItemIndex of
    1: FAppliance := TLightingFixture.Create(FPlug);
    2: FAppliance := TFan.Create(FPlug);
    else
      FAppliance := nil;
  end;
  UpdateUI;
end;

procedure TFormMain.UpdateUI;
begin
  BtnDevice.Enabled := Assigned(FAppliance);
  if not Assigned(FAppliance) then
  begin
    BtnDevice.Caption := '—';
    ShowMessage('Nenhum dispositivo conectado.');
    Exit;
  end;

  if Assigned(CurrentFan) then
    BtnDevice.Caption := CurrentFan.Speed.ToString
  else
    BtnDevice.Caption := IfThen(FAppliance.OnOff, 'Desligar', 'Ligar');

  ShowMessage(FAppliance.StatusMessage);
end;


procedure TFormMain.HandleFanAction;
begin
  CurrentFan.Speed := CurrentFan.Speed.Next;
  UpdateUI;
end;

procedure TFormMain.HandleLightingAction;
begin
  if not Assigned(FAppliance) then Exit;
  FAppliance.OnOff := not FAppliance.OnOff;
  UpdateUI;
end;

end.
