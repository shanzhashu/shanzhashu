object FormSetting: TFormSetting
  Left = 522
  Top = 213
  BorderStyle = bsDialog
  Caption = #35774#32622
  ClientHeight = 180
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object grpSetting: TGroupBox
    Left = 16
    Top = 16
    Width = 281
    Height = 113
    Caption = #35774#32622#20869#23481
    TabOrder = 0
    object lbl1: TLabel
      Left = 24
      Top = 32
      Width = 60
      Height = 12
      Caption = #21021#22987#30446#24405#65306
    end
    object lbl2: TLabel
      Left = 24
      Top = 64
      Width = 60
      Height = 12
      Caption = #24187#28783#38388#38548#65306
    end
    object lbl3: TLabel
      Left = 244
      Top = 64
      Width = 12
      Height = 12
      Caption = #31186
    end
    object btnBrowse: TSpeedButton
      Left = 240
      Top = 28
      Width = 23
      Height = 22
      Caption = '...'
      Flat = True
      OnClick = btnBrowseClick
    end
    object edtRoot: TEdit
      Left = 96
      Top = 28
      Width = 129
      Height = 20
      TabOrder = 0
    end
    object seInterval: TSpinEdit
      Left = 96
      Top = 60
      Width = 129
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object btnOK: TButton
    Left = 134
    Top = 144
    Width = 75
    Height = 21
    Caption = #30830#23450'(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 222
    Top = 144
    Width = 75
    Height = 21
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 2
  end
end
