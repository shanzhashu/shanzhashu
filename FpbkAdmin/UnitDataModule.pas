unit UnitDataModule;

interface

uses
  SysUtils, Classes, Variants, ADODB, DB;

type
  TDataModuleMain = class(TDataModule)
    dsOrderForms: TADODataSet;
    conDatabase: TADOConnection;
    tblDesignNames: TADOTable;
    tblFactoryNames: TADOTable;
    tblStatusStrings: TADOTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure InitStatusStrings;
  public
    { Public declarations }
  end;

  TOrderStatus = (
    osOrdered,
    osShot,
    osSelected,
    osDesignSent,
    osDesignOK,
    osSentToFactory,
    osRecvFromFactory,
    osCustomerNotified,
    osCustomerTaken
  );

var
  OrderStatusStrings: array[Low(TOrderStatus)..High(TOrderStatus)] of string =
    ('', '', '', '', '', '', '', '', '');

  OrderStatusDetailStrings: array[Low(TOrderStatus)..High(TOrderStatus)] of string =
    ('', '', '', '', '', '', '', '', '');

var
  DataModuleMain: TDataModuleMain;

implementation

{$R *.dfm}

procedure TDataModuleMain.DataModuleCreate(Sender: TObject);
begin
  InitStatusStrings;
end;

procedure TDataModuleMain.InitStatusStrings;
var
  Status: Integer;
begin
  try
    tblStatusStrings.Active := True;
    tblStatusStrings.First;
    while not tblStatusStrings.Eof do
    begin
      Status := tblStatusStrings.FieldValues['Status'];
      if (Status <= Ord(High(TOrderStatus))) and (Status >= Ord(Low(TOrderStatus))) then
      begin
        OrderStatusStrings[TOrderStatus(Status)] := VarToStr(tblStatusStrings.FieldValues['StatusDescription']);
        OrderStatusDetailStrings[TOrderStatus(Status)] := VarToStr(tblStatusStrings.FieldValues['StatusDetail']);
      end;
      tblStatusStrings.Next;
    end;
  finally
    tblStatusStrings.Active := False;
  end;
end;

end.
