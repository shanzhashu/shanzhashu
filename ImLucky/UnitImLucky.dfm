object FormLucky: TFormLucky
  Left = 206
  Top = 118
  BorderStyle = bsNone
  ClientHeight = 536
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object img1: TImage
    Left = 0
    Top = 0
    Width = 971
    Height = 536
    Align = alClient
    Stretch = True
  end
  object lblCount: TLabel
    Left = 320
    Top = 16
    Width = 12
    Height = 12
    Caption = #25277
  end
  object lblRen: TLabel
    Left = 424
    Top = 24
    Width = 12
    Height = 12
    Caption = #20154
  end
  object btnClose: TSpeedButton
    Left = 936
    Top = 16
    Width = 23
    Height = 22
    Caption = 'X'
    Flat = True
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
    OnClick = btnCloseClick
  end
  object edtCount: TEdit
    Left = 344
    Top = 16
    Width = 57
    Height = 20
    TabOrder = 0
    Text = '3'
  end
  object udCount: TUpDown
    Left = 401
    Top = 16
    Width = 15
    Height = 20
    Associate = edtCount
    Min = 1
    Position = 3
    TabOrder = 1
  end
  object btnImport: TButton
    Left = 16
    Top = 16
    Width = 121
    Height = 25
    Caption = #23548#20837#25277#22870#20154#20204
    TabOrder = 2
  end
  object btnChou: TButton
    Left = 552
    Top = 24
    Width = 217
    Height = 25
    Caption = #25277#65281#65281#65281#25277#65281#65281#65281#25277#65281#65281#65281
    TabOrder = 3
    OnClick = btnChouClick
  end
  object pnlScroll: TPanel
    Left = 40
    Top = 72
    Width = 881
    Height = 97
    BevelOuter = bvLowered
    Color = clCream
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -29
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object mmoResult: TMemo
    Left = 48
    Top = 368
    Width = 873
    Height = 113
    ReadOnly = True
    TabOrder = 5
  end
end
