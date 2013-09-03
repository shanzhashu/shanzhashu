unit UnitOrderDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, ComCtrls, Buttons;

type
  TFormOrderDetail = class(TForm)
    grpDesign: TGroupBox;
    lblDesignName: TLabel;
    cbbDesignNames: TComboBox;
    lblDesignSend: TLabel;
    dtpDesignSend: TDateTimePicker;
    lblRecvDesign: TLabel;
    dtpRecvDesign: TDateTimePicker;
    grpFactory: TGroupBox;
    lblFactoryName: TLabel;
    lblSendToFactory: TLabel;
    lblRecvFromFactory: TLabel;
    cbbFactoryName: TComboBox;
    dtpSendToFactory: TDateTimePicker;
    dtpRecvFromFactory: TDateTimePicker;
    grpBaby: TGroupBox;
    lblBabyName: TLabel;
    lblContactNum: TLabel;
    lblOrderDate: TLabel;
    lblShotDate: TLabel;
    lblHour1: TLabel;
    edtBabyName: TEdit;
    edtContactNum: TEdit;
    dtpOrderDate: TDateTimePicker;
    dtpShotDate: TDateTimePicker;
    seOrderDate: TSpinEdit;
    lblTaken: TLabel;
    dtpTakenDate: TDateTimePicker;
    edtAge: TEdit;
    lblAge: TLabel;
    grpContent: TGroupBox;
    lblPrice: TLabel;
    lblPayment: TLabel;
    lblContent: TLabel;
    edtPrice: TEdit;
    edtPayment: TEdit;
    mmoContent: TMemo;
    cbbStatus: TComboBox;
    lblStatus: TLabel;
    bvl1: TBevel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    lblOrderDetail: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbbStatusChange(Sender: TObject);
  private
    FDesignNames: TStringList;
    FFactoryNames: TStringList;
    FIsNew: Boolean;
    procedure InitListValues;
    procedure SetIsNew(const Value: Boolean);
  public
    property IsNew: Boolean read FIsNew write SetIsNew;
  end;

var
  FormOrderDetail: TFormOrderDetail;

implementation

uses UnitDataModule;

{$R *.dfm}

{ TFormOrderDetail }

procedure TFormOrderDetail.InitListValues;
var
  I: TOrderStatus;
  AName: string;
begin
  cbbStatus.Clear;
  for I := Low(TOrderStatus) to High(TOrderStatus) do
    cbbStatus.Items.Add(OrderStatusStrings[I]);

  try
    cbbDesignNames.Clear;
    DataModuleMain.tblDesignNames.Active := True;
    DataModuleMain.tblDesignNames.First;
    while not DataModuleMain.tblDesignNames.Eof do
    begin
      I := DataModuleMain.tblDesignNames.FieldValues['ID'];
      AName := VarToStr(DataModuleMain.tblDesignNames.FieldValues['DesignName']);
      cbbDesignNames.Items.AddObject(AName, TObject(I));
      DataModuleMain.tblDesignNames.Next;
    end;
  finally
    DataModuleMain.tblDesignNames.Active := False;
  end;

  try
    cbbFactoryName.Clear;
    DataModuleMain.tblFactoryNames.Active := True;
    DataModuleMain.tblFactoryNames.First;
    while not DataModuleMain.tblFactoryNames.Eof do
    begin
      I := DataModuleMain.tblFactoryNames.FieldValues['ID'];
      AName := VarToStr(DataModuleMain.tblFactoryNames.FieldValues['FactoryName']);
      cbbFactoryName.Items.AddObject(AName, TObject(I));
      DataModuleMain.tblFactoryNames.Next;
    end;
  finally
    DataModuleMain.tblFactoryNames.Active := False;
  end;
end;

procedure TFormOrderDetail.FormCreate(Sender: TObject);
begin
  FDesignNames := TStringList.Create;
  FFactoryNames := TStringList.Create;
  InitListValues;
end;

procedure TFormOrderDetail.FormDestroy(Sender: TObject);
begin
  FFactoryNames.Free;
  FDesignNames.Free;
end;

procedure TFormOrderDetail.SetIsNew(const Value: Boolean);
begin
  if FIsNew <> Value then
  begin
    FIsNew := Value;
    
  end;
end;

procedure TFormOrderDetail.cbbStatusChange(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := cbbStatus.ItemIndex;
  if (Idx <= Integer(High(TOrderStatus))) and (Idx >= Integer(Low(TOrderStatus))) then
    lblOrderDetail.Caption := OrderStatusDetailStrings[TOrderStatus(Idx)];
end;

end.
