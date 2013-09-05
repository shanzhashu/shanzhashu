object FormSuite: TFormSuite
  Left = 386
  Top = 177
  BorderStyle = bsDialog
  Caption = #22871#39184#20869#23481#31649#29702
  ClientHeight = 517
  ClientWidth = 394
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
    Width = 372
    Height = 12
    Caption = #24744#21487#20197#22312#27492#31649#29702#21508#31181#39044#35774#32622#30340#22871#39184#20869#23481#12290#22871#39184#20869#23481#20379#35746#21333#20013#22635#20889#20351#29992#12290
  end
  object dbgrdPreContents: TDBGrid
    Left = 16
    Top = 40
    Width = 361
    Height = 120
    DataSource = dsPreContents
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PreContentName'
        Title.Caption = #22871#39184#21517#31216
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PreContentPrice'
        Title.Caption = #22871#39184#20215#26684
        Width = 107
        Visible = True
      end>
  end
  object grpSuite: TGroupBox
    Left = 16
    Top = 216
    Width = 361
    Height = 249
    Caption = #32534#36753#22871#39184#20869#23481
    TabOrder = 1
    object lblPreContentName: TLabel
      Left = 16
      Top = 24
      Width = 60
      Height = 12
      Caption = #22871#39184#21517#31216#65306
    end
    object lblPreContentPrice: TLabel
      Left = 16
      Top = 56
      Width = 60
      Height = 12
      Caption = #22871#39184#20215#26684#65306
    end
    object lblYuan: TLabel
      Left = 336
      Top = 56
      Width = 12
      Height = 12
      Caption = #20803
    end
    object lblPreContentDescription: TLabel
      Left = 16
      Top = 88
      Width = 60
      Height = 12
      Caption = #22871#39184#20869#23481#65306
    end
    object dbedtPreContentName: TDBEdit
      Left = 88
      Top = 20
      Width = 241
      Height = 20
      DataField = 'PreContentName'
      DataSource = dsPreContents
      TabOrder = 0
    end
    object dbedtPreContentPrice: TDBEdit
      Left = 88
      Top = 52
      Width = 241
      Height = 20
      DataField = 'PreContentPrice'
      DataSource = dsPreContents
      TabOrder = 1
    end
    object dbmmoDescription: TDBMemo
      Left = 16
      Top = 112
      Width = 329
      Height = 121
      DataField = 'PreContentDescription'
      DataSource = dsPreContents
      TabOrder = 2
    end
  end
  object dbnvgrSuite: TDBNavigator
    Left = 16
    Top = 176
    Width = 360
    Height = 25
    DataSource = dsPreContents
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
    TabOrder = 2
  end
  object btnClose: TButton
    Left = 302
    Top = 480
    Width = 75
    Height = 21
    Caption = #20851#38381
    ModalResult = 2
    TabOrder = 3
  end
  object btnOK: TButton
    Left = 208
    Top = 480
    Width = 75
    Height = 21
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 4
    Visible = False
  end
  object dsPreContents: TDataSource
    DataSet = DataModuleMain.tblPreContents
    Left = 152
    Top = 88
  end
end
