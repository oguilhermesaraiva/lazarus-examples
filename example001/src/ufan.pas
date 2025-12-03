unit uFan;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}
interface

uses
  Classes, SysUtils, uElectricalOutlet;

type

  TFanSpeed = (fsOff, fsLow, fsMedium, fsHigh);

  { TFanSpeedHelper }

  TFanSpeedHelper = type helper for TFanSpeed
  public
    function Next: TFanSpeed;
    function ToString: string;
  end;

  { TFan }

  TFan = class(TAppliance)
  private
    FSpeed: TFanSpeed;
    procedure SetSpeed(Value: TFanSpeed);
    function GetSpeed: TFanSpeed;
  public
    constructor Create(Value: IPlug); reintroduce;
    function Working: boolean; override;
    procedure ResetState; override;
    function StatusMessage: string; override;
    property Speed: TFanSpeed read GetSpeed write SetSpeed;
  end;

implementation

{ TFanSpeedHelper }

function TFanSpeedHelper.Next: TFanSpeed;
begin
  case Self of
    fsOff:    Result := fsLow;
    fsLow:    Result := fsMedium;
    fsMedium: Result := fsHigh;
    fsHigh:   Result := fsOff;
  end;
end;

function TFanSpeedHelper.ToString: string;
begin
  case Self of
    fsOff: Result := 'Desligado';
    fsLow: Result := 'Baixa';
    fsMedium: Result := 'Média';
    fsHigh: Result := 'Alta';
  end;
end;

{ TFan }

constructor TFan.Create(Value: IPlug);
begin
  inherited Create(Value);
  FSpeed := fsOff;
end;

procedure TFan.SetSpeed(Value: TFanSpeed);
begin
  FSpeed := Value;
end;

function TFan.GetSpeed: TFanSpeed;
begin
  Result := FSpeed;
end;

function TFan.Working: boolean;
begin
  Result := Assigned(FPlug)
        and FPlug.Energize
        and FPlug.Connected
        and (FSpeed <> fsOff);
end;

procedure TFan.ResetState;
begin
  FSpeed := fsOff;
  OnOff := false;
end;

function TFan.StatusMessage: string;
begin
  if Working then
    Result := Format('O ventilador está funcionando na velocidade: %s', [FSpeed.ToString])
  else
    Result := Format('O ventilador NÃO está funcionando. Velocidade: %s', [FSpeed.ToString]);
end;

end.

