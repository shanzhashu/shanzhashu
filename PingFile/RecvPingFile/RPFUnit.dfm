object RPFForm: TRPFForm
  Left = 335
  Top = 236
  BorderStyle = bsDialog
  Caption = 'Receive File from Ping'
  ClientHeight = 226
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblDir: TLabel
    Left = 16
    Top = 16
    Width = 77
    Height = 13
    Caption = 'Store Directory:'
  end
  object lblRecvFrom: TLabel
    Left = 16
    Top = 96
    Width = 68
    Height = 13
    Caption = 'Recv From IP:'
  end
  object lblLocal: TLabel
    Left = 16
    Top = 56
    Width = 70
    Height = 13
    Caption = 'Local Adapter:'
  end
  object lblTimeout: TLabel
    Left = 320
    Top = 64
    Width = 42
    Height = 13
    Caption = 'Timeout:'
  end
  object btnCopy: TSpeedButton
    Left = 279
    Top = 78
    Width = 18
    Height = 18
    Caption = '='
    Flat = True
    OnClick = btnCopyClick
  end
  object edtDir: TEdit
    Left = 104
    Top = 16
    Width = 193
    Height = 21
    TabOrder = 0
    Text = 'C:\'
  end
  object btnBrowse: TButton
    Left = 312
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object btnRecv: TButton
    Left = 16
    Top = 176
    Width = 369
    Height = 25
    Caption = 'Recv!'
    TabOrder = 2
    OnClick = btnRecvClick
  end
  object pbRecv: TProgressBar
    Left = 16
    Top = 144
    Width = 369
    Height = 16
    TabOrder = 3
  end
  object cbbIP: TComboBox
    Left = 104
    Top = 56
    Width = 193
    Height = 21
    ItemHeight = 13
    TabOrder = 4
  end
  object edtFromIp: TEdit
    Left = 104
    Top = 96
    Width = 193
    Height = 21
    TabOrder = 5
  end
  object edtTimeout: TEdit
    Left = 320
    Top = 96
    Width = 49
    Height = 21
    TabOrder = 6
    Text = '50'
  end
  object udTimeout: TUpDown
    Left = 369
    Top = 96
    Width = 15
    Height = 21
    Associate = edtTimeout
    Max = 1000
    Position = 50
    TabOrder = 7
  end
end
