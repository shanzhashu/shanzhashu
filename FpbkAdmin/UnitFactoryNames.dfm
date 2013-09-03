object FormFactoryNames: TFormFactoryNames
  Left = 462
  Top = 274
  BorderStyle = bsDialog
  Caption = #21046#20316#26041#31649#29702
  ClientHeight = 404
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object lblDesc: TLabel
    Left = 16
    Top = 16
    Width = 324
    Height = 12
    Caption = #24744#21487#20197#22312#27492#31649#29702#21046#20316#26041#30340#21517#31216#12290#19968#33324#24773#20917#19979#26080#38656#21024#38500#21046#20316#26041#12290
  end
  object dbgrdFactoryNames: TDBGrid
    Left = 16
    Top = 40
    Width = 401
    Height = 313
    DataSource = dsFactoryNames
    TabOrder = 0
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Caption = #21046#20316#26041#24207#21495
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FactoryName'
        Title.Caption = #21046#20316#26041#21517#31216
        Width = 303
        Visible = True
      end>
  end
  object dbnvgrFactoryNames: TDBNavigator
    Left = 16
    Top = 368
    Width = 168
    Height = 21
    DataSource = dsFactoryNames
    VisibleButtons = [nbInsert, nbEdit, nbPost, nbCancel]
    Hints.Strings = (
      'First record'
      'Prior record'
      'Next record'
      'Last record'
      #26032#24314#35774#35745#26041
      'Delete record'
      #32534#36753#35774#35745#26041
      #20445#23384#25913#21160
      #25764#38144#25913#21160
      'Refresh data')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object btnClose: TButton
    Left = 344
    Top = 368
    Width = 75
    Height = 21
    Caption = #20851#38381
    ModalResult = 1
    TabOrder = 2
  end
  object dsFactoryNames: TDataSource
    DataSet = DataModuleMain.tblFactoryNames
    Left = 176
    Top = 168
  end
end
