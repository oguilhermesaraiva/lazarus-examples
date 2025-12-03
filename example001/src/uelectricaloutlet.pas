unit uElectricalOutlet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { IPlug }

  IPlug = interface
    ['{9FF8EB53-0C8E-463C-91F3-DA048BC8DB4F}']
    function Energized: boolean; overload;
    function Energized(Value: boolean): IPlug; overload;
    function Connected: boolean; overload;
    function Connected(Value: boolean): IPlug; overload;
    procedure SetEnergized(Value: boolean);
    //To use the 'write property' without functional programming
    procedure SetConnected(Value: boolean);
    //To use the 'write property' without functional programming
    property Energize: boolean read Energized write SetEnergized;
    property Plugging: boolean read Connected write SetConnected;
  end;

  { TElectricalOutlet }

  TElectricalOutlet = class(TInterfacedObject, IPlug)
  private
    FEnergized, FPlugged: boolean;
  public
    constructor Create;
    class function New: IPlug;
    function Energized: boolean; overload;
    function Energized(Value: boolean): IPlug; overload;
    function Connected: boolean; overload;
    function Connected(Value: boolean): IPlug overload;
    procedure SetEnergized(Value: boolean);
    //To use the 'write property' without functional programming
    procedure SetConnected(Value: boolean);
    //To use the 'write property' without functional programming
    property Energize: boolean read Energized write SetEnergized;
    property Plugging: boolean read Connected write SetConnected;
  end;

  { TAppliance }

  TAppliance = class abstract
  private
    FOnOff: boolean;
  protected
    FPlug: IPlug;
    procedure SetOnOff(Value: boolean); virtual;
  public
    constructor Create(Value: IPlug); virtual;
    destructor Destroy; override;
    function Working: boolean; virtual;
    procedure ResetState; virtual;
    function StatusMessage: string; virtual; abstract;
    property OnOff: boolean read FOnOff write SetOnOff;
  end;

implementation

{ TElectricalOutlet }

constructor TElectricalOutlet.Create;
begin
  inherited Create;
  FEnergized := false;
  FPlugged := false;
end;

class function TElectricalOutlet.New: IPlug;
begin
  Result := TElectricalOutlet.Create;
end;

function TElectricalOutlet.Energized: boolean;
begin
  Result := FEnergized;
end;

function TElectricalOutlet.Energized(Value: boolean): IPlug;
begin
  FEnergized := Value;
  Result := Self;
end;

function TElectricalOutlet.Connected: boolean;
begin
  Result := FPlugged;
end;

function TElectricalOutlet.Connected(Value: boolean): IPlug;
begin
  FPlugged := Value;
  Result := Self;
end;

procedure TElectricalOutlet.SetEnergized(Value: boolean);
begin
  FEnergized := Value;
end;

procedure TElectricalOutlet.SetConnected(Value: boolean);
begin
  FPlugged := Value;
end;

{ TAppliance }

constructor TAppliance.Create(Value: IPlug);
begin
  inherited Create;
  FPlug := Value;
  if Assigned(FPlug) then
    FPlug.Plugging := true;
  FOnOff := false;
end;

destructor TAppliance.Destroy;
begin
  inherited Destroy;
end;

procedure TAppliance.SetOnOff(Value: boolean);
begin
  FOnOff := Value;
end;

function TAppliance.Working: boolean;
begin
  Result := Assigned(FPlug)
        and FPlug.Energized
        and FPlug.Connected
        and OnOff;
end;

procedure TAppliance.ResetState;
begin
  FOnOff := false;
end;

end.

