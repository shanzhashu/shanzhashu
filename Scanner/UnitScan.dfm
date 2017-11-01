object FormScan: TFormScan
  Left = 192
  Top = 107
  Width = 854
  Height = 403
  Caption = 'Scan'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblHost: TLabel
    Left = 32
    Top = 24
    Width = 25
    Height = 13
    Caption = 'Host:'
  end
  object lblPort: TLabel
    Left = 424
    Top = 24
    Width = 48
    Height = 13
    Caption = 'Port from: '
  end
  object lblTo: TLabel
    Left = 568
    Top = 24
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object mmoResult: TMemo
    Left = 32
    Top = 56
    Width = 777
    Height = 289
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object edtHost: TEdit
    Left = 80
    Top = 20
    Width = 273
    Height = 21
    TabOrder = 1
    Text = '127.0.0.1'
  end
  object edtFromPort: TEdit
    Left = 480
    Top = 20
    Width = 73
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object edtPortTo: TEdit
    Left = 600
    Top = 20
    Width = 73
    Height = 21
    TabOrder = 3
    Text = '1024'
  end
  object btnScan: TButton
    Left = 736
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Scan'
    TabOrder = 4
    OnClick = btnScanClick
  end
end
