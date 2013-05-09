unit UnitOptions;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniConfigSection = 'Config';

  {Section: Config}
  csIniConfigRootDir = 'RootDir';
  csIniConfigSlideDelay = 'SlideDelay';

type
  TIniOptions = class(TObject)
  private
    {Section: Config}
    FConfigRootDir: string;
    FConfigSlideDelay: Integer;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);
    
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: Config}
    property ConfigRootDir: string read FConfigRootDir write FConfigRootDir;
    property ConfigSlideDelay: Integer read FConfigSlideDelay write FConfigSlideDelay;
  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: Config}
    FConfigRootDir := Ini.ReadString(csIniConfigSection, csIniConfigRootDir, 'E:\');
    FConfigSlideDelay := Ini.ReadInteger(csIniConfigSection, csIniConfigSlideDelay, 2);
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: Config}
    Ini.WriteString(csIniConfigSection, csIniConfigRootDir, FConfigRootDir);
    Ini.WriteInteger(csIniConfigSection, csIniConfigSlideDelay, FConfigSlideDelay);
  end;
end;

procedure TIniOptions.LoadFromFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    LoadSettings(Ini);
  finally
    Ini.Free;
  end;
end;

procedure TIniOptions.SaveToFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    SaveSettings(Ini);
  finally
    Ini.Free;
  end;
end;

initialization
  IniOptions := TIniOptions.Create;

finalization
  IniOptions.Free;

end.

