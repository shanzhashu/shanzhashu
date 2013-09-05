unit UnitDataModule;

interface

uses
  SysUtils, Classes, Variants, Windows, ADODB, DB;

const
  EMPTY_DATETIME = 2;
  ORDER_FORM_SQL = 'SELECT * FROM OroderForms ';

type
  TDataModuleMain = class(TDataModule)
    dsOrderForms: TADODataSet;
    conDatabase: TADOConnection;
    tblDesignNames: TADOTable;
    tblFactoryNames: TADOTable;
    tblStatusStrings: TADOTable;
    dsOrderFormsID: TAutoIncField;
    dsOrderFormsBabyName: TWideStringField;
    dsOrderFormsAge: TIntegerField;
    dsOrderFormsContactNum: TWideStringField;
    dsOrderFormsOrderDate: TDateTimeField;
    dsOrderFormsPrice: TIntegerField;
    dsOrderFormsPayment: TIntegerField;
    dsOrderFormsShotDate: TDateTimeField;
    dsOrderFormsDesignName: TIntegerField;
    dsOrderFormsDesignSendDate: TDateTimeField;
    dsOrderFormsDesignReceiveDate: TDateTimeField;
    dsOrderFormsFactoryName: TIntegerField;
    dsOrderFormsSendToFactoryDate: TDateTimeField;
    dsOrderFormsRecvFromFactoryDate: TDateTimeField;
    dsOrderFormsCustomerTakenDate: TDateTimeField;
    dsOrderFormsStatus: TIntegerField;
    dsOrderFormsPicContent: TMemoField;
    dsOrderFormsMemory: TWideStringField;
    dsOrderFormsDesignNameText: TStringField;
    dsOrderFormsFactoryNameText: TStringField;
    dsOrderFormsStatusText: TStringField;
    dsOrderFormsShotTime: TIntegerField;
    tblPreContents: TADOTable;
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

procedure ErrorDlg(const Msg: string);

procedure InfoDlg(const Msg: string);

implementation

{$R *.dfm}

procedure ErrorDlg(const Msg: string);
begin
  MessageBox(0, PChar(Msg), '¥ÌŒÛ', MB_OK + MB_ICONSTOP);
end;

procedure InfoDlg(const Msg: string);
begin
  MessageBox(0, PChar(Msg), 'Ã· æ', MB_OK + MB_ICONWARNING);
end;

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
