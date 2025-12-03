unit uLightingFixture;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uElectricalOutlet;

type

  { TLightingFixture }

  TLightingFixture = class(TAppliance)
  private
  public
    constructor Create(Value: IPlug); reintroduce;
    procedure ResetState; override;
    function StatusMessage: string; override;
  end;

implementation

{ TLightingFixture }

constructor TLightingFixture.Create(Value: IPlug);
begin
  inherited Create(Value);
end;

procedure TLightingFixture.ResetState;
begin
  OnOff := false;
end;

function TLightingFixture.StatusMessage: string;
begin
  if Working then
    Result := 'A luminária está LIGADA!'
  else
    Result := 'A luminária está DESLIGADA.';
end;

end.

