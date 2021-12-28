object FormLucky: TFormLucky
  Left = 147
  Top = 111
  BorderStyle = bsNone
  ClientHeight = 622
  ClientWidth = 1192
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
  DesignSize = (
    1192
    622)
  PixelsPerInch = 96
  TextHeight = 12
  object img1: TImage
    Left = 0
    Top = 0
    Width = 1192
    Height = 622
    Align = alClient
    Stretch = True
    Transparent = True
  end
  object lblCount: TLabel
    Left = 648
    Top = 37
    Width = 21
    Height = 28
    Caption = #25277
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblRen: TLabel
    Left = 776
    Top = 36
    Width = 21
    Height = 28
    Caption = #20154
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object btnClose: TSpeedButton
    Left = 1157
    Top = 16
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'X'
    Flat = True
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
    OnClick = btnCloseClick
  end
  object btnMax: TSpeedButton
    Left = 1133
    Top = 16
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    Caption = #21475
    Flat = True
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
    OnClick = btnMaxClick
  end
  object btnMin: TSpeedButton
    Left = 1109
    Top = 16
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '-'
    Flat = True
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -20
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
    OnClick = btnMinClick
  end
  object edtCount: TEdit
    Left = 680
    Top = 32
    Width = 57
    Height = 36
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '3'
  end
  object udCount: TUpDown
    Left = 737
    Top = 32
    Width = 24
    Height = 36
    Associate = edtCount
    Min = 1
    Position = 3
    TabOrder = 2
  end
  object btnImport: TButton
    Left = 40
    Top = 32
    Width = 169
    Height = 41
    Caption = #23548#20837#25277#22870#20154#20204
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnImportClick
  end
  object btnChou: TButton
    Left = 816
    Top = 32
    Width = 217
    Height = 41
    Caption = #24320#22987#33988#21147#8230#8230
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnChouClick
  end
  object pnlScroll: TPanel
    Left = 40
    Top = 96
    Width = 1102
    Height = 145
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvLowered
    Color = clCream
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -29
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object mmoResult: TMemo
    Left = 40
    Top = 360
    Width = 1102
    Height = 201
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clInfoBk
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object dlgOpen1: TOpenDialog
    Left = 232
    Top = 24
  end
end
